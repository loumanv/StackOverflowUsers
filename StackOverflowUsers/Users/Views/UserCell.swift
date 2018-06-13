//
//  UserCell.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

protocol UserCellDelegate: class {
    func followButtonTapped(for cell: UserCell)
    func blockButtonTapped(for cell: UserCell)
}

class UserCell: UITableViewCell {

    weak var delegate: UserCellDelegate?

    static let normalViewHeight: CGFloat = 80.0
    static let expandableViewHeight: CGFloat = 110

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var tickImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = #imageLiteral(resourceName: "placeholderImage")
        tickImageView.image = nil
    }

    @IBAction func followButtonTapped(_ sender: UIButton) {
        delegate?.followButtonTapped(for: self)
    }

    @IBAction func blockButtonTapped(_ sender: UIButton) {
        delegate?.blockButtonTapped(for: self)
    }
}
