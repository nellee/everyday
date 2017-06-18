//
//  MoviesTableViewCell.swift
//  EverydayApp
//
//  Created by Danijel on 12/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesTableViewCell"
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOriginalTitleLabel: UILabel!
    
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    @IBOutlet weak var movieScoreLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviePosterImageView.isHidden = true
        
        movieTitleLabel.text = ""
        movieScoreLabel.text = ""
        movieOriginalTitleLabel.text = ""
        movieOverviewTextView.text = ""
        
        contentView.backgroundColor = UIColor.white
        movieOverviewTextView.backgroundColor = UIColor.white
        loadingIndicator.isHidden = false
    }
    
}
