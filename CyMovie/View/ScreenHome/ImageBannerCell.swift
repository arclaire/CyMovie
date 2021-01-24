//
//  ImageBannerCell.swift
//  SimpleApps
//
//  Created by lucy on 14/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

class ImageBannerCell: UICollectionViewCell {

    @IBOutlet weak var imageBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        debugPrint("CELLBANNERIMAGE")
    }

}
