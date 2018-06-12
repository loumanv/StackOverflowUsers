//
//  ContentLoadable.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

typealias ContentLoadableCompletion = (Error?) -> Void

protocol ContentLoadable {
    func refreshData()
    func showLoadingView()
    func prepareData(_ completion: @escaping ContentLoadableCompletion)
    func hideLoadingView()
    func reloadView()
    func showError(_ error: Error)
}

extension ContentLoadable {

    func refreshData() {
        showLoadingView()

        prepareData { error in
            self.hideLoadingView()
            guard error == nil else {
                self.showError(error!)
                return
            }
            self.reloadView()
        }
    }
}
