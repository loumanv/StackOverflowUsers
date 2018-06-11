//
//  UsersViewControllerTests.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class UsersViewControllerTests: XCTestCase {

    func testUsersViewControllerInitializationSucceeds() {
        let searchVC = UsersViewController()
        XCTAssertNotNil(searchVC)
    }
}
