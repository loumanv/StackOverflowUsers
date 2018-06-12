//
//  UserCell.swift
//  StackOverflowUsers
//
//  Created by Vasileios Loumanis on 11/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = #imageLiteral(resourceName: "placeholderImage")
    }
}
