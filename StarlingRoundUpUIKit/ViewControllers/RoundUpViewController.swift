//
//  ViewController.swift
//  StarlingRoundUpUIKit
//
//  Created by Andy Rennard on 27/07/2023.
//

import UIKit
import Combine

public enum RoundUpViewModelError: Error {
    case invalidDateRange
    case noPrimaryAccountFound
}

@MainActor
public class RoundUpViewModel {
    private let accountsService: AccountsServiceProtocol
    private let transactionsService: TransactionsServiceProtocol

    @Published public var transactions: [Transaction] = []
    @Published public var accounts: [Account] = []
    @Published public var error: Error?
    @Published public var startDate: Date?
    
    var primaryAccount: Account? {
        accounts.first { $0.accountType == .primary }
    }
    
    init(accountsService: AccountsServiceProtocol,
         transactionsService: TransactionsServiceProtocol)
    {
        self.accountsService = accountsService
        self.transactionsService = transactionsService
    }
    
    /// Convenience method to create a `RoundUpViewModel` with the default dependencies
    /// - Returns: a `RoundUpViewModel`
    static func `default`() -> RoundUpViewModel {
        RoundUpViewModel(accountsService: AccountsService(),
                         transactionsService: TransactionsService())
    }
    
    /// Get the accounts for this user from the accounts service
    /// Accounts are assigned to the published `accounts` property
    public func fetchAccounts() async {
        do {
            accounts = try await accountsService.getAccounts()
        } catch {
            self.error = error
        }
    }
    
    /// Convenience method to fetch the transactions in the primary account over a 7 day period from the selected start date.
    /// Transactions are assigned to the `transactions` published property
    public func fetchTransactions() async {
        guard let startDate,
              let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)
        else {
            error = RoundUpViewModelError.invalidDateRange
            return
        }
        guard let primaryAccount else {
            error = RoundUpViewModelError.noPrimaryAccountFound
            return
        }

        await fetchTransactions(in: primaryAccount, over: startDate..<endDate)
    }
    
    /// Fetch the transactions in the specified account over the provided date range.
    /// Transactions are assigned to the `transactions` published property
    /// - Parameters:
    ///   - account: the account to fetch transactions for
    ///   - dateRange: the date range to fetch transactions over
    public func fetchTransactions(in account: Account, over dateRange: Range<Date>) async {
        do {
            transactions = try await transactionsService.getTransactions(for: account, in: dateRange)
        } catch {
            self.error = error
        }
    }
    
    /// Calculate the roundup amount for an array of transactions.
    ///
    /// *Assumption: only `OUT` transactions are rounded up*
    /// - Parameter transactions: the `Transaction`s to round up
    /// - Returns: an array of `CurrencyAmount`s for each discrete `CurrencyCode` in the transactions
    public func calculateRoundup(for transactions: [Transaction]) -> [CurrencyAmount] {
        var allRoundups = [CurrencyCode: CurrencyAmount]()
        for transaction in transactions.filter({ $0.direction == .out }) {
            let transactionCurrency = transaction.amount.currency
            if let roundup = roundupAmount(for: transaction.amount) {
                if let runningTotal = allRoundups[transactionCurrency] {
                    allRoundups[transactionCurrency] = runningTotal + roundup
                } else {
                    allRoundups[transactionCurrency] = roundup
                }
            }
        }
        return allRoundups.keys.compactMap{ allRoundups[$0]}
    }
    
    /// Calculate the roundup amount for a `CurrencyAmount`
    ///
    /// *Assumptions*:
    /// * that transactions at zero units do not need rounding up
    /// * that all currencies have 100 minor units to their major units (eg. pence, cents, etc).
    /// - Parameter transactionAmount: the `CurrencyAmount` to round up
    /// - Returns: a `CurrencyAmount` to round the transaction up to the nearest whole unit
    func roundupAmount(for transactionAmount: CurrencyAmount) -> CurrencyAmount? {
        guard transactionAmount.minorUnits % 100 != 0 else { return nil }
        return CurrencyAmount(currency: transactionAmount.currency,
                              minorUnits: 100 - (transactionAmount.minorUnits % 100))
    }
}

class RoundUpViewController: UIViewController {
    let viewModel = RoundUpViewModel.default()
    
    var subscriptions: [AnyCancellable] = []
    
    @IBAction func fetchTransactions(_ sender: Any) {
        Task {
            await viewModel.fetchTransactions()
        }
    }
    
    @IBOutlet weak var accountName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$accounts.sink { accounts in
            self.accountName.text = accounts.first?.name ?? "Not loaded"
        }.store(in: &subscriptions)

        viewModel.$error.sink { error in
            // Display the error to the user…
            UIAlertController(title: "Rrror", message: error?.localizedDescription, preferredStyle: .alert)
        }.store(in: &subscriptions)
        
        Task {
            await viewModel.fetchAccounts()
        }
    }

}

