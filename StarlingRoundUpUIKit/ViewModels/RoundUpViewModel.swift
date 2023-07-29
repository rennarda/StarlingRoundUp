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
    case noValidTransactionsToRoundup
}

/// The view model for the Round Up view
@MainActor
public class RoundUpViewModel: ObservableObject {
    private let accountsService: AccountsServiceProtocol
    private let transactionsService: TransactionsServiceProtocol
    private let savingsService: SavingsServiceProtocol

    // The transactions found for the specified date range
    @Published public var transactions: [Transaction] = [] {
        didSet {
            roundupSummary = roundupDescription()
        }
    }
    // The user's accounts
    @Published public var accounts: [Account] = []
    // Any error that has occurred that should be shown to the user
    @Published public var error: Error?
    // The selected start date
    @Published public var startDate: Date? {
        didSet {
            transactions = []
        }
    }
    // A text summary of what will be rounded up.
    @Published public var roundupSummary: String?
    
    var primaryAccount: Account? {
        accounts.first { $0.accountType == .primary }
    }
        
    init(accountsService: AccountsServiceProtocol,
         transactionsService: TransactionsServiceProtocol,
         savingsService: SavingsServiceProtocol
    )
    {
        self.accountsService = accountsService
        self.transactionsService = transactionsService
        self.savingsService = savingsService
    }
    
    /// Convenience method to create a `RoundUpViewModel` with the default dependencies
    /// - Returns: a `RoundUpViewModel`
    static func `default`() -> RoundUpViewModel {
        RoundUpViewModel(accountsService: AccountsService(),
                         transactionsService: TransactionsService(),
                         savingsService: SavingsService()
        )
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
        for transaction in filtered(transactions: transactions) {
            let transactionCurrency = transaction.amount.currency
            if let roundup = transaction.amount.roundupAmount() {
                if let runningTotal = allRoundups[transactionCurrency] {
                    allRoundups[transactionCurrency] = runningTotal + roundup
                } else {
                    allRoundups[transactionCurrency] = roundup
                }
            }
        }
        return allRoundups.keys.compactMap{ allRoundups[$0]}
    }
    
    /// Perform the roundup by creating a savings goal for each currency, and transferring the roundup amount
    public func performRoundup() async {
        guard let primaryAccount else {
            error = RoundUpViewModelError.noPrimaryAccountFound
            return
        }
        let roundups = calculateRoundup(for: transactions)
        guard !roundups.isEmpty else {
            error = RoundUpViewModelError.noValidTransactionsToRoundup
            return
        }
        // there is one entry in roundups per currency
        // create a savings goal for each currency, and transfer the roundup
        // Out of scope: fetch the existing savings goals first
        for roundup in roundups {
            do {
                let savingsGoal = try await savingsService.createSavingsGoal(named: "Test savings goal", in: primaryAccount, currency: roundup.currency)
                try await savingsService.add(roundup, to: savingsGoal, in: primaryAccount)
            } catch {
                self.error = error
                return
            }
        }
    }
    
    /// The transactions filtered down to only those that need rounding up
    /// - Parameter transactions: all the transactions
    /// - Returns: the filtered transactions
    ///
    /// Assumption: only `OUT` transactions need to be rounded up
    func filtered(transactions: [Transaction]) -> [Transaction] {
        transactions.filter({ $0.direction == .out })
    }
    
    /// A textual description of what will be rounded up
    /// - Returns: the string to display
    func roundupDescription() -> String {
        guard !transactions.isEmpty else {
            return "No transactions to roundup."
        }
        let roundupAmounts = calculateRoundup(for: transactions)
        
        return "Round up \(filtered(transactions: transactions).count) transactions for " +
            roundupAmounts.map({ $0.description }).joined(separator: ", ")
    }
}
