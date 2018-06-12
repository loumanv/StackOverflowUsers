//
//  NetworkClient.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 12/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDictionary = [String: Any]

struct NetworkClientError {
    static let invalidResponse = AppError(localizedTitle: "Invalid Response",
                                          localizedDescription: "Not a valid response", code: 1)
    static let noJsonResponse = AppError(localizedTitle: "No JSON Response",
                                         localizedDescription: "Not a JSON Response", code: 2)
    static let invalidURL = AppError(localizedTitle: "Invalid URL",
                                     localizedDescription: "Not a valid URL", code: 3)
}

protocol NetworkSession {
    func load(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func load(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}

class NetworkClient {

    public static let shared = NetworkClient()

    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func load(_ url: URL, completion: @escaping ((Any?, Error?) -> Void)) {

        session.load(url) { (data, response, error) in

            var responseData: Any?
            var responseError: Error?

            if let error = error {
                responseError = error
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                responseData = data
            } else {
                responseError = NetworkClientError.invalidResponse
            }
            DispatchQueue.main.async {
                completion(responseData, responseError)
            }
        }
    }

    func loadUsers(completion: @escaping (([User]?, AppError?) -> Void)) {

        guard let url = URL(string: usersUrl() + usersParameters()) else {
            return completion(nil, NetworkClientError.invalidURL)
        }
        load(url) { (data, error) in

                guard error == nil,
                    let data = data as? Data,
                    let jsonData = try? JSONSerialization.jsonObject(with: data) as? JSONDictionary,
                    let json = jsonData else {
                        if let error = error {
                            completion(nil, error as? AppError)
                        } else {
                            completion(nil, NetworkClientError.noJsonResponse)
                        }
                        return
                }

                let users = User.array(json: json)
                completion(users, nil)
        }
    }

    func loadImage(url: URL, completion: @escaping ((UIImage?, AppError?) -> Void)) {

        load(url) { (data, error) in

            guard error == nil,
                let data = data as? Data,
                let image = UIImage(data: data) else {
                    if let error = error {
                        completion(nil, error as? AppError)
                    } else {
                        completion(nil, NetworkClientError.invalidResponse)
                    }
                    return
            }
            completion(image, nil)
        }
    }

    private func usersUrl() -> String {
        return APIConstants.UrlStrings.baseUrl + APIConstants.UrlStrings.apiVersion + APIConstants.UrlStrings.users
    }

    private func usersParameters() -> String {
        return "?\(APIConstants.UrlStrings.pagesizeKey)=\(APIConstants.UrlStrings.pagesizeValue)" +
               "&\(APIConstants.UrlStrings.orderKey)=\(APIConstants.UrlStrings.orderValue)" +
               "&\(APIConstants.UrlStrings.sortKey)=\(APIConstants.UrlStrings.sortValue)" +
               "&\(APIConstants.UrlStrings.siteKey)=\(APIConstants.UrlStrings.siteValue)"
    }
}
