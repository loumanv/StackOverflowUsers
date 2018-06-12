//
//  User.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

enum UserError: LocalizedError {
    case missingName
    case missingReputation
    case missingProfileImage
}

class User {

    private(set) var name: String
    private(set) var reputation: Int?
    private(set) var profileImage: String?

    init(dictionary: JSONDictionary) throws {

        guard let name = dictionary[APIConstants.User.name] as? String else { throw UserError.missingName }
        self.name = name
        self.reputation = dictionary[APIConstants.User.reputation] as? Int
        self.profileImage = dictionary[APIConstants.User.profileImage] as? String
    }
}

extension User {
    static func array(json: JSONDictionary) -> [User]? {
        let jsonUsersArray =  json[APIConstants.User.usersArrayKey]
        guard let usersArray = jsonUsersArray as? [JSONDictionary]  else { return nil }
        return usersArray.compactMap { try? User(dictionary: $0) }
    }
}
