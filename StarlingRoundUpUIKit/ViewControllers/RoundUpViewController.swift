//
//  ViewController.swift
//  StarlingRoundUpUIKit
//
//  Created by Andy Rennard on 27/07/2023.
//

import UIKit
import Combine

@MainActor
public class RoundUpViewModel {
    private let accountsService: AccountsServiceProtocol
    private let transactionsService: TransactionsServiceProtocol

    @Published public var transactions: [Transaction] = []
    @Published public var accounts: [Account] = []
    @Published public var error: Error?

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
    
    func fetchTransactions(in account: Account, over dateRange: Range<Date>) async -> [Transaction] {
        do {
            transactions = try await transactionsService.getTransactions(for: account, categoryID: account.defaultCategory, in: dateRange)
        } catch {
            self.error = error
        }
        return []
    }
}

class RoundUpViewController: UIViewController {
    let viewModel = RoundUpViewModel.default()
    
    var subscriptions: [AnyCancellable] = []
    
    @IBAction func fetchAccounts(_ sender: Any) {
    }

    @IBOutlet weak var accountName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$accounts.sink { accounts in
            self.accountName.text = accounts.first?.name ?? "Not loaded"
        }.store(in: &subscriptions)

        viewModel.$error.sink { error in
            // Display the error to the user…
        }.store(in: &subscriptions)
        
        Task {
            await viewModel.fetchAccounts()
        }
    }

}

