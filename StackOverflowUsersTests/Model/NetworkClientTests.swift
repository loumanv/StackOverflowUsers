//
//  NetworkClientTests.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 12/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class MockNetworkSession: NetworkSession {

    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    func load(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}

class NetworkClientTests: XCTestCase {

    let session = MockNetworkSession()
    var networkClient: NetworkClient {
        return NetworkClient(session: session)
    }
    let url = URL(string: "url")!
    let successfulResponse = HTTPURLResponse(url: URL(string: "url")!,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)

    func testLoadMethodReturnsErrorWhenErrorIsNotNil() {
        let expectedError = AppError(localizedTitle: "error", localizedDescription: "error", code: 30)
        session.error = expectedError

        networkClient.load(url) { (result, error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? AppError, expectedError)
        }
    }

    func testLoadMethodReturnsErrorWhenDataIsNil() {

        networkClient.load(url) { (result, error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? AppError, NetworkClientError.invalidResponse)
        }
    }

    func testLoadMethodReturnsErrorWhenResponseStatusCodeIsNot200() {
        session.data = Data(bytes: [0, 1, 0, 1])
        session.response = HTTPURLResponse(url: url, statusCode: 300, httpVersion: nil, headerFields: nil)

        networkClient.load(url) { (result, error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? AppError, NetworkClientError.invalidResponse)
        }
    }

    func testLoadMethodReturnsDataWhenErrorIsNilAndResponseCodeIsSuccessful() {
        let expectedData = Data(bytes: [0, 1, 0, 1])
        session.data = expectedData
        session.response = successfulResponse

        networkClient.load(url) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertEqual(result as? Data, expectedData)
        }
    }

    func testLoadUsersReturnsNoJsonResponseForNoJSONResult() {
        session.data = "No JSON Result".data(using: .utf8)!
        session.response = successfulResponse

        networkClient.loadUsers { (users, error) in
            XCTAssertNil(users)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, NetworkClientError.noJsonResponse)
        }
    }

    func testLoadUsersReturnsNilWhenResponseIsNotStructuredProperly() {
        session.data = "{\"person\": \"me\"}".data(using: .utf8)!
        session.response = successfulResponse

        networkClient.loadUsers { (users, error) in
            XCTAssertNil(users)
            XCTAssertNil(error)
        }
    }

    func testLoadUsersReturnsNilWhenResponseDoesNotHaveUsers() {
        session.data = "{\"\(APIConstants.User.usersArrayKey)\": \"[]\"}".data(using: .utf8)!
        session.response = successfulResponse

        networkClient.loadUsers { (users, error) in
            XCTAssertNil(users)
            XCTAssertNil(error)
        }
    }

    func testLoadUsersReturnsArrayOfUsersWhenResponseHasUsers() {
        let expectedDataString = "{" +
            "\"items\": [" +
                "{" +
                "\"\(APIConstants.User.name)\": \"name\"" +
                "}" +
            "]" +
        "}"
        session.data = expectedDataString.data(using: .utf8)
        session.response = successfulResponse

        networkClient.loadUsers { (users, error) in
            XCTAssertNotNil(users)
            XCTAssertNil(error)
            XCTAssertEqual(users!.count, 1)
        }
    }

    func testloadImageReturnsInvalidResponseResponseForNoImageResult() {
        session.data = "No Image Result".data(using: .utf8)!
        session.response = successfulResponse

        networkClient.loadImage(url: url) { (image, error) in
            XCTAssertNil(image)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, NetworkClientError.invalidResponse)
        }
    }

    func testloadImageReturnsExpectedImageWhenResponseHasImageData() {
        session.data = UIImagePNGRepresentation(#imageLiteral(resourceName: "placeholderImage"))
        session.response = successfulResponse

        networkClient.loadImage(url: url) { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
        }
    }
}
