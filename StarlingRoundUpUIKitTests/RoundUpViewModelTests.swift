//
//  RoundUpViewModelTests.swift
//  StarlingRoundUpUIKitTests
//
//  Created by Andrew Rennard on 28/07/2023.
//

import XCTest
@testable import StarlingRoundUpUIKit

@MainActor
final class RoundUpViewModelTests: XCTestCase {
    var sut: RoundUpViewModel!
    var accountsService: MockAccountsService!
    var transactionsService: MockTransactionsService!

    override func setUpWithError() throws {
        accountsService = MockAccountsService()
        transactionsService = MockTransactionsService()

        sut = RoundUpViewModel(accountsService: accountsService , transactionsService: transactionsService)
    }

    override func tearDownWithError() throws {
        sut = nil
        accountsService = nil
        transactionsService = nil
    }

    func test_getAccounts() async throws {
        await sut.fetchAccounts()
        XCTAssertEqual(sut.accounts.count, 1)
    }
    
    func test_getAccountsSetsError() async throws {
        accountsService.error = APIError.invalidResponse
        sut = RoundUpViewModel(accountsService: accountsService, transactionsService: transactionsService)
        await sut.fetchAccounts()
        XCTAssertNotNil(sut.error)
    }
    
    func test_getTransactionsSetsError() async throws {
        transactionsService.error = APIError.invalidResponse
        sut = RoundUpViewModel(accountsService: accountsService, transactionsService: transactionsService)
        let transactions = await sut.fetchTransactions(in: Account.mock, over: .now ..< .now.addingTimeInterval(1))
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(sut.transactions.isEmpty)
    }
}
