//
//  PhotoEditorCollectionCell.swift
//  EverydayApp
//
//  Created by Danijel on 17/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class PhotoEditorCollectionCell: UICollectionViewCell {
    
    static let identifier = "PhotoEditorCollectionCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        
        titleLabel.text?.removeAll()
        imageView.image = nil
        
        super.prepareForReuse()
    }
    
}
