//
//  UsersViewModelTests.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class UsersViewModelTests: XCTestCase {

    let viewModel = Factory.createUsersViewModel()

    func testUsersViewModelInitializationSucceeds() {
        XCTAssertNotNil(viewModel)
    }

    func testNameForRow() {
        XCTAssertEqual(viewModel.nameFor(row: 0), "Jon Skeet")
    }

    func testreputationForRow() {
        XCTAssertEqual(viewModel.reputationFor(row: 0), "1,031,313")
    }

    func profileImageURLForRow() {
        let url = URL(string: "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG")
        XCTAssertEqual(viewModel.profileImageURLFor(row: 0), url)
    }

    func testUsersViewModelReturnsTheCorrectInfoForEmptyReputationAndProfileImage() {
        let user = Factory.createUserNoReputationAndProfileImage()
        let viewModel = UsersViewModel(users: [user])

        XCTAssertEqual(viewModel.nameFor(row: 0), "Jon Skeet")
        XCTAssertEqual(viewModel.reputationFor(row: 0), "N/A")
        XCTAssertEqual(viewModel.profileImageURLFor(row: 0), nil)
    }
}
