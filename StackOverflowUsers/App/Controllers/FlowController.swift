//
//  FlowController.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class FlowController: NSObject {

    static let shared = FlowController()

    lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: UsersViewController())
    }()
}
