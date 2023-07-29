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
        XCTAssertNotNil(sut.primaryAccount)
        XCTAssertEqual(sut.primaryAccount?.accountUid.uuidString, "6CC723F4-8524-4E99-8F2C-2263801F9734")
    }
    
    func test_getAccountsSetsError() async throws {
        accountsService.error = APIError.invalidResponse
        sut = RoundUpViewModel(accountsService: accountsService, transactionsService: transactionsService)
        await sut.fetchAccounts()
        XCTAssertNotNil(sut.error)
    }
    
    func test_getTransactions() async throws {
        await sut.fetchTransactions(in: Account.mock, over: .now ..< .now.addingTimeInterval(1))
        XCTAssertEqual(sut.transactions.count, 14)
    }
    
    func test_getTransactionsSetsError() async throws {
        transactionsService.error = APIError.invalidResponse
        sut = RoundUpViewModel(accountsService: accountsService, transactionsService: transactionsService)
        await sut.fetchTransactions(in: Account.mock, over: .now ..< .now.addingTimeInterval(1))
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(sut.transactions.isEmpty)
    }
    
    func test_getTransactions_noStartDate() async throws {
        await sut.fetchTransactions()
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.error as? RoundUpViewModelError, RoundUpViewModelError.invalidDateRange)
    }
    
    func test_getTransactions_noAccounts() async throws {
        sut.startDate = .now
        await sut.fetchTransactions()
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.error as? RoundUpViewModelError, RoundUpViewModelError.noPrimaryAccountFound)
    }
    
    func test_getTransactions_convenience() async throws {
        sut.startDate = .now
        sut.accounts = [Account.mock]
        await sut.fetchTransactions()
        XCTAssertEqual(sut.transactions.count, 14)
    }
    
    func test_roundup() async throws {
        sut.startDate = DateFormatter.starlingFormatter.date(from: "2023-07-27T00:00:00.000Z")
        sut.accounts = [Account.mock]

        // Based on data in the mock
        XCTAssertEqual(sut.calculateRoundup(for: Transaction.mock),
                       [CurrencyAmount(currency: .GBP, minorUnits: 337)])
    }
}
