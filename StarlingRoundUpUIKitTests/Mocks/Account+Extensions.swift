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
                              defaultCategory: .init(uuidString: "C15BB901-1E17-497D-AC94-52DE9542CFEB")!,
                              currency: .GBP,
                              name: "Test account",
                              createdAt: .now)
}
