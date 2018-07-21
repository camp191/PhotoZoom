//
//  ImageTableViewCell.swift
//  PhotoZoom
//
//  Created by Thanapat Sorralump on 21/7/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivPic: UIImageView!
    
    func configure(pic: UIImage)  {
        ivPic.image = pic
        layoutIfNeeded()
    }
}
