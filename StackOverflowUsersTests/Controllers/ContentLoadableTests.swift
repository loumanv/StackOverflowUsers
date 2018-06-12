//
//  ContentLoadableTests.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class MockContentLoadable: ContentLoadable {
    var hideLoadingViewCalled = false
    var prepareDataMethodCalled = false
    var reloadViewCalled = false
    var showErrorViewCalled = false
    var showLoadingViewCalled = false

    func hideLoadingView() {
        hideLoadingViewCalled = true
    }

    func showLoadingView() {
        showLoadingViewCalled = true
    }

    func prepareData(_ completion: @escaping ContentLoadableCompletion) {
        prepareDataMethodCalled = true
    }

    func showError(_ error: Error) {
        showErrorViewCalled = true
    }

    func reloadView() {
        reloadViewCalled = true
    }
}

class MockFailedPrepareData: MockContentLoadable {
    override func prepareData(_ completion: @escaping ContentLoadableCompletion) {
        let error = NSError() as Error
        completion(error)
    }
}

class MockSuccessPrepareData: MockContentLoadable {
    override func prepareData(_ completion: @escaping ContentLoadableCompletion) {
        completion(nil)
    }
}

class ContentLoadableTests: XCTestCase {

    func testRefreshDataShowsTheLoadingView() {
        let mockContentLoadable = MockContentLoadable()
        mockContentLoadable.refreshData()

        XCTAssertTrue(mockContentLoadable.showLoadingViewCalled)
    }

    func testRefreshDataPreparesTheData() {
        let mockContentLoadable = MockContentLoadable()
        mockContentLoadable.refreshData()

        XCTAssertTrue(mockContentLoadable.prepareDataMethodCalled)
    }

    func testRefreshDataWhenPrepareDataFinishesWithAnError() {
        let mockContentLoadable = MockFailedPrepareData()
        mockContentLoadable.refreshData()

        XCTAssertTrue(mockContentLoadable.hideLoadingViewCalled)
    }

    func testRefreshDataShowsTheErrorView() {
        let mockContentLoadable = MockFailedPrepareData()
        mockContentLoadable.refreshData()

        XCTAssertTrue(mockContentLoadable.showErrorViewCalled)
    }

    func testRefreshDataWhenPrepareDataFinishesSuccessfully() {
        let mockContentLoadable = MockSuccessPrepareData()
        mockContentLoadable.refreshData()

        XCTAssertTrue(mockContentLoadable.hideLoadingViewCalled)
    }

    func testRefreshDataReloadsTheView() {
        let mockContentLoadable = MockSuccessPrepareData()
        mockContentLoadable.refreshData()

        XCTAssertTrue(mockContentLoadable.reloadViewCalled)
    }
}
