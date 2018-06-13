//
//  UsersViewModel.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

class UsersViewModel {

    private(set) var users: [User]

    init(users: [User]) {
        self.users = users
    }

    func nameFor(row: Int) -> String {
        return users[row].name
    }

    func reputationFor(row: Int) -> String {
        guard let reputation =  users[row].reputation else { return "N/A" }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        guard let formattedReputation = numberFormatter.string(from: NSNumber(value: reputation)) else { return "N/A" }
        return String(formattedReputation)
    }

    func profileImageURLFor(row: Int) -> URL? {
        guard let profileImageUrl = users[row].profileImage,
            let imageURL = URL(string: profileImageUrl) else { return nil }
        return imageURL
    }

    func removeUser(at index: Int) {
        users.remove(at: index)
    }
}
