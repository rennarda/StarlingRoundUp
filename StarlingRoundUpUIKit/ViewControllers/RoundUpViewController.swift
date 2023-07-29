//
//  ViewController.swift
//  StarlingRoundUpUIKit
//
//  Created by Andy Rennard on 27/07/2023.
//

import UIKit
import Combine

class RoundUpViewController: UIViewController {
    let viewModel = RoundUpViewModel.default()
    
    var subscriptions: [AnyCancellable] = []
        
    @IBOutlet weak var fetchTransactionsButton: UIButton!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var roundupButton: UIButton!
    @IBOutlet weak var roundUpSummaryLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$accounts.sink { accounts in
            self.accountName.text = accounts.first?.name ?? "Not loaded"
            self.datePicker.isEnabled = !accounts.isEmpty
        }.store(in: &subscriptions)

        viewModel.$error.sink { error in
            // Display the error to the user…
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }.store(in: &subscriptions)

        viewModel.$startDate.sink { date in
            self.fetchTransactionsButton.isEnabled = (date != nil)
        }.store(in: &subscriptions)
        
        viewModel.$transactions.sink { transactions in
            self.roundupButton.isEnabled = !transactions.isEmpty
        }.store(in: &subscriptions)
        
        Task {
            await viewModel.fetchAccounts()
        }
    }

    @IBAction func performRoundup(_ sender: Any) {
        Task {
            await viewModel.performRoundup()
        }
    }
    
    @IBAction func didSelectDate(_ sender: UIDatePicker) {
        viewModel.startDate = sender.date
    }
    
    @IBAction func fetchTransactions(_ sender: Any) {
        Task {
            await viewModel.fetchTransactions()
            roundUpSummaryLabel.text = viewModel.roundupSummary
        }
    }

    
}

