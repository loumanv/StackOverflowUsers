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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Factory.createUsersViewModel()
        table.dataSource = self
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
        return cell
    }
}
