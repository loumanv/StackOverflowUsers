//
//  Factory.swift
//  StackOverflowUsersTests
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

class Factory {

    static func createUser() -> User {

        let dictionary: JSONDictionary = [
            "reputation": 1031313,
            "profile_image": "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG",
            "display_name": "Jon Skeet"
        ]
        return try! User(dictionary: dictionary)
    }

    static func createUserNoReputationAndProfileImage() -> User {

        let dictionary: JSONDictionary = [
            "display_name": "Jon Skeet"
        ]
        return try! User(dictionary: dictionary)
    }

    static func createUsers() -> [User] {
        let fileURL = Bundle(for: User.self).url(forResource: "users", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSONDictionary
        return User.array(json: dictionary)!
    }
}
