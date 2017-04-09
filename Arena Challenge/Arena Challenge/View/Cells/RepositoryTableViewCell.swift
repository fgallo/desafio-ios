//
//  RepositoryTableViewCell.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var viewModel: RepositoryCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
    }

    func configure() {
        usernameLabel.text = viewModel.username
        repositoryNameLabel.text = viewModel.name
        repositoryDescriptionLabel.text = viewModel.description
        forksLabel.text = "\(viewModel.numberOfForks)"
        starsLabel.text = "\(viewModel.numberOfStars)"
        userImageView.image = UIImage(named: "placeholder-user")
        
        if let userImageURL = viewModel.userImageURL {
            userImageView.imageFromURL(userImageURL)
        }
    }
    
}
