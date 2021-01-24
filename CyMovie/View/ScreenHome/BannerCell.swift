//
//  BannerCell.swift
//  SimpleApps
//
//  Created by lucy on 14/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet weak var colBanner: UICollectionView!
    
    var arrBanner:[String] = ["banner1","banner2","banner3","banner4"]
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.colBanner.delegate = self
        self.colBanner.dataSource = self
        
        self.colBanner.register(UINib(nibName: String(describing: ImageBannerCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: ImageBannerCell.classForCoder()))
        
    }

    
}


extension BannerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

extension BannerCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell: ImageBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageBannerCell.classForCoder()), for: indexPath) as! ImageBannerCell
        imageCell.imageBanner.image = UIImage(named: self.arrBanner[indexPath.row])
        debugPrint("CELLBANNER",imageCell.imageBanner.image)
        return imageCell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let floatWidthCell:CGFloat = UIScreen.main.bounds.size.width
        let floatHeightCell:CGFloat = 120
      
        return CGSize(width: floatWidthCell, height: floatHeightCell)
    }
}
