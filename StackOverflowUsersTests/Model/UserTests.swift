//
//  UserTests.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class UserTests: XCTestCase {

    func testUserInitializationSucceeds() {
        let user = Factory.createUser()
        XCTAssertNotNil(user)
    }

    func testThrowsErrorWhenNameIsMissing() {
        let dictionary: JSONDictionary = [
            "reputation": 1031313,
            "profile_image": "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG"
        ]
        XCTAssertThrowsError(try User(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! UserError, UserError.missingName)
        }
    }

    func testUserJsonParseSucceeds() {
        let user = Factory.createUser()
        XCTAssertEqual(user.name, "Jon Skeet")
        XCTAssertEqual(user.reputation, 1031313)
        let expectedImageURL = "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG"
        XCTAssertEqual(user.profileImage, expectedImageURL)
    }

    func testUsersInitializationSucceeds() {
        let users = Factory.createUsers()
        XCTAssertNotNil(users)
    }

    func testUsersJsonParseSucceeds() {
        let users = Factory.createUsers()
        XCTAssertEqual(users.count, 30)
    }
}
