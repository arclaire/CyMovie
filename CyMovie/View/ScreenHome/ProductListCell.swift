//
//  ProductListCell.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//


import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var imgBadge: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductUI(withData _product: ModelMovie) {
        self.lblTitle.text = _product.strName
        
        self.imgProduct.setImage(source: _product.strImageItemUrl, type: .general, contentMode: .scaleAspectFill)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let preferredLayoutAttributes = layoutAttributes
        
        var fittingSize = UIView.layoutFittingCompressedSize
        fittingSize.width = UIScreen.main.bounds.size.width / 2
        fittingSize.height  = self.frame.size.height
        let size = systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        var adjustedFrame = preferredLayoutAttributes.frame
        adjustedFrame.size.height = ceil(size.height)
        preferredLayoutAttributes.frame = adjustedFrame
        
        return preferredLayoutAttributes
    }
    
}
