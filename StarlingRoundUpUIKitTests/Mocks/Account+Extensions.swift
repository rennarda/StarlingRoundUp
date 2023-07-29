//
//  Account+Extensions.swift
//  StarlingRoundUpUIKitTests
//
//  Created by Andrew Rennard on 28/07/2023.
//

import Foundation
import StarlingRoundUpUIKit

extension Account {
    static let mock = Account(accountUid: .init(uuidString: "6CC723F4-8524-4E99-8F2C-2263801F9734")!,
                              accountType: .primary,
                              defaultCategory: .init(uuidString: "e75f6fbb-29fb-49e0-acc0-6717c0f3eb48")!,
                              currency: .GBP,
                              name: "Test account",
                              createdAt: .now)
}
