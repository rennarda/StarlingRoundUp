//
//  ViewController.swift
//  StarlingRoundUpUIKit
//
//  Created by Andy Rennard on 27/07/2023.
//

import UIKit

class RoundUpViewController: UIViewController {

    @IBAction func fetchAccounts(_ sender: Any) {
        Task {
            do {
                try await AccountsService().getAccounts()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

