//
//  SavingsServiceTests.swift
//  StarlingRoundUpUIKitTests
//
//  Created by Andy Rennard on 31/07/2023.
//

import XCTest
@testable import StarlingRoundUpUIKit

final class SavingsServiceTests: XCTestCase {
    var sut: SavingsService!
    var apiClient: MockAPIClient!
    
    override func setUpWithError() throws {
        apiClient = MockAPIClient()
        sut = SavingsService(apiClient: apiClient)
    }

    override func tearDownWithError() throws {
        sut = nil
        apiClient = nil
    }
    
    /// Example of how you might use a mock API client to test the outgoing URLs that are called, and the request data being sent
    func test_moveMoneyRequest() async throws {
        let transferID = UUID(uuidString: "13C2074A-D097-4CCF-BBE1-9270E4D718AC")!
        let response = AddMoneyToSavingsGoalResponse(success: true, transferUid: transferID)
        try apiClient.responseData = response.encode()
        try await sut.add(CurrencyAmount(currency: .GBP, minorUnits: 100), to: SavingsGoal.mock, in: Account.mock, transferID: transferID)
        XCTAssertEqual(apiClient.requestURL?.absoluteString,
                       "https://api-sandbox.starlingbank.com/api/v2/account/6cc723f4-8524-4e99-8f2c-2263801f9734/savings-goals/4ef2b930-0d8a-4650-96f7-55610b370199/add-money/13C2074A-D097-4CCF-BBE1-9270E4D718AC"
        )
        
        XCTAssertNotNil(apiClient.requestData)
        if let requestData = apiClient.requestData,
           let requestBody = try? AddMoneyToSavingsGoalRequest.decode(from: requestData)
        {
            XCTAssertEqual(requestBody, AddMoneyToSavingsGoalRequest(amount: CurrencyAmount(currency: .GBP, minorUnits: 100)))
        } else {
            XCTFail("Expected a request body")
        }
    }
}
