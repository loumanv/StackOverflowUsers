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

    @IBOutlet weak var table: UITableView! {
        didSet {
            table.rowHeight = UITableViewAutomaticDimension
            table.estimatedRowHeight = 80
            let cellString = String(describing: UserCell.self)
            table.register(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: cellString)
        }
    }
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        refreshData()
        addNavigationItems()
    }

    func addNavigationItems() {
        let activityBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem  = activityBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reload",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(reload))
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
        // TODO: Add request to load the cell image 
        return cell
    }
}

extension UsersViewController: ContentLoadable {

    func prepareData(_ completion: @escaping ContentLoadableCompletion) {
        // TODO: Add actual network request
        viewModel = Factory.createUsersViewModel()
        completion(nil)
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
}
