//
//  ViewProductHistory.swift
//  SimpleApps
//
//  Created by lucy on 15/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

class ViewProductHistory: UIView {

     private var vwFilter:UIView!
    
    
    
    @IBOutlet weak var colProduct: UICollectionView!
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.vwFilter = self.loadViewFromNIB()
        if let _ = self.vwFilter {
            self.addSubview(self.vwFilter)
        }
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colProduct.delegate = self
        self.colProduct.dataSource = self
        self.colProduct.register(UINib(nibName: String(describing: ProductHistoryCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductHistoryCell.classForCoder()))
        
    }
    
    
    
}


extension ViewProductHistory: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

extension ViewProductHistory: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell: ProductHistoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductHistoryCell.classForCoder()), for: indexPath) as! ProductHistoryCell
       
        return productCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var floatWidthCell:CGFloat = UIScreen.main.bounds.size.width
        var floatHeightCell:CGFloat = 200
        
        return CGSize(width: floatWidthCell, height: floatHeightCell)
    }
}

