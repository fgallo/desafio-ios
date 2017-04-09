//
//  PullRequestTableViewCell.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var viewModel: PullRequestCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
    }
    
    func configure() {
        usernameLabel.text = viewModel.username
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        userImageView.image = UIImage(named: "placeholder-user")
        
        if let userImageURL = viewModel.userImageURL {
            userImageView.imageFromURL(userImageURL)
        }
    }
    
}
