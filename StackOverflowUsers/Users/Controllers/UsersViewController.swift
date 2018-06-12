//
//  UsersViewController.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    private(set) var viewModel: UsersViewModel?

    @IBOutlet weak private var table: UITableView! {
        didSet {
            table.rowHeight = UITableViewAutomaticDimension
            table.estimatedRowHeight = 80
            let cellString = String(describing: UserCell.self)
            table.register(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: cellString)
        }
    }
    @IBOutlet weak private var errorView: UIView!
    @IBOutlet weak private var errorLabel: UILabel!
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        refreshData()
        addNavigationItems()
        errorLabel.text = NSLocalizedString("UsersLoadError", comment: "")
    }

    func addNavigationItems() {
        let activityBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem  = activityBarButton
        let leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("UsersReloadButtonTitle", comment: ""),
                                                style: .plain,
                                                target: self,
                                                action: #selector(reload))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func reload() {
        refreshData()
    }
}

extension UsersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.users.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellString = String(describing: UserCell.self)
        let dequeueCell = table.dequeueReusableCell(withIdentifier: cellString, for: indexPath)
        guard let cell = dequeueCell as? UserCell else { return UITableViewCell() }
        cell.nameLabel.text = viewModel?.nameFor(row: indexPath.row)
        cell.reputationLabel.text = viewModel?.reputationFor(row: indexPath.row)
        if let url = viewModel?.profileImageURLFor(row: indexPath.row) {
            NetworkClient.shared.loadImage(url: url) { [cell] (image, error) in
                guard error == nil, let image = image else { return }
                cell.profileImageView.image = image
            }
        }

        return cell
    }
}

extension UsersViewController: ContentLoadable {

    func prepareData(_ completion: @escaping ContentLoadableCompletion) {
        view.bringSubview(toFront: table)
        NetworkClient.shared.loadUsers { [unowned self] (users, error) in
            guard error == nil, let users = users, users.count > 0 else {
                // Show appropriate error message
                let error = AppError(localizedTitle: "No users", localizedDescription: "No users", code: 4)
                completion(error)
                return
            }
            self.viewModel = UsersViewModel(users: users)
            completion(nil)
        }
    }

    func reloadView() {
        table.reloadData()
    }

    func showLoadingView() {
        activityIndicator.startAnimating()
    }

    func hideLoadingView() {
        activityIndicator.stopAnimating()
    }

    func showError(_ error: Error) {
        view.bringSubview(toFront: errorView)
    }
}
