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

extension ContentLoadable where Self: UIViewController {

    func showError(_ error: Error) {
        let alert = UIAlertController(title: title,
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
