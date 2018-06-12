//
//  APIConstants.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

struct APIConstants {
    struct User {
        static let usersArrayKey = "items"
        static let name = "display_name"
        static let reputation = "reputation"
        static let profileImage = "profile_image"
    }

    struct UrlStrings {
        static let baseUrl = "http://api.stackexchange.com"
        static let apiVersion = "/2.2"
        static let users = "/users"
        static let pagesizeKey = "pagesize"
        static let pagesizeValue = "20"
        static let orderKey = "order"
        static let orderValue = "desc"
        static let sortKey = "sort"
        static let sortValue = "reputation"
        static let siteKey = "site"
        static let siteValue = "stackoverflow"
    }
}
