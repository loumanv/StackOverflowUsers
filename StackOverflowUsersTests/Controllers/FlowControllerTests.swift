//
//  FlowController.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class FlowControllerTests: XCTestCase {

    func testFlowControllerNavigationControllerReturnsANavigationController() {
        let navigationController = FlowController.shared.navigationController
        XCTAssertNotNil(navigationController)
        XCTAssertTrue(navigationController.isKind(of: UINavigationController.self))
    }

    func testInitialFlowControllerContainsAUsersViewController() {
        let navigationController = FlowController.shared.navigationController
        let rootVC = navigationController.viewControllers.first
        XCTAssertTrue(rootVC!.isKind(of: UsersViewController.self))
    }
}
