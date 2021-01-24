//
//  ViewHome.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

protocol DelegateViewHome: NSObjectProtocol {
    
    func delegateLoadMore()
    func delegateOpenDetail(data: ModelMovie)
    func delegateOpenHistory()
    func delegateFilter(idGenre: Int)
}

class ViewHome: UIView {
    
    private var vwHome:UIView!
    //MARK: Outlets
    @IBOutlet weak var colProduct: UICollectionView!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var consPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    //MARK: Attributes
    weak var delHomeView: DelegateViewHome?
    var intGenre: Int = 18
    @IBOutlet weak var btnDonePicker: UIButton!
    
    @IBOutlet weak var btnFilter: UIButton!
    var arrProducts: [ModelMovie] = [ModelMovie]() {
        didSet {
            
            self.reloadUI()
        }
    }
    var modelSelected: ModelMovie?
    private var modelGenreSelected: ModelGenre?
    
    var arrGenre: [ModelGenre] = [ModelGenre]()
    var isFetching: Bool = false {
        didSet {
            
        }
    }
    var isCanLoadMore: Bool = true
    var intPage = 1
    
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.vwHome = self.loadViewFromNIB()
        self.colProduct.delegate = self
        self.colProduct.dataSource = self
        
        if let _ = self.vwHome {
            self.addSubview(self.vwHome)
        }
        self.colProduct.register(UINib(nibName: String(describing: ProductListCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductListCell.classForCoder()))
        
        self.colProduct.register(UINib(nibName: String(describing: BannerCell.classForCoder()), bundle: nil), forCellWithReuseIdentifier: String(describing: BannerCell.classForCoder()))
        self.flowlayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width / 2, height: self.colProduct.frame.size.height)
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.isHidden = true
        self.btnDonePicker.isHidden = true
    }
    
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: UI Methods
    @IBAction func doFilter(_ sender: Any) {
        self.picker.reloadAllComponents()
        self.showPicker(ishow: true)
    }
    
    @IBAction func doDonePicker(_ sender: Any) {
        self.showPicker(ishow: false)
        if let model = self.modelGenreSelected {
            self.intGenre = model.id
            self.intPage = 1
            self.arrProducts.removeAll()
            self.delHomeView?.delegateFilter(idGenre: model.id)
        }
        
    }
    func showPicker(ishow: Bool) {
        print("ShowPicker", ishow)
        if ishow {
            self.picker.isHidden = false
            self.consPickerHeight.constant = 165
        } else {
            self.btnDonePicker.isHidden = true
            self.consPickerHeight.constant = 0
            self.picker.isHidden = true
        }
       
        UIView.animate(withDuration: 0.5, animations: {
            self.vwHome.layoutIfNeeded()
        }, completion: {_ in
            if !ishow {
                self.picker.isHidden = true
                
            } else {
                self.btnDonePicker.isHidden = false
            }
        })
    }
    
    func stopAnimationLoad() {
        //self.colProduct.infiniteScrollingView?.stopAnimating()
    }
    
    //MARK: Data Methods
    func reloadUI() {
        self.colProduct.reloadData()
        self.stopAnimationLoad()
    }
  
    
    
}

extension ViewHome: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.modelSelected = self.arrProducts[indexPath.row]
        self.delHomeView?.delegateOpenDetail(data: self.arrProducts[indexPath.row])
         
    }
}

extension ViewHome: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell: ProductListCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductListCell.classForCoder()), for: indexPath) as! ProductListCell
        productCell.setProductUI(withData: self.arrProducts[indexPath.row])
    
        
        return productCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let floatWidthCell:CGFloat = UIScreen.main.bounds.size.width / 2
        let floatHeightCell:CGFloat = floatWidthCell + 120
        
        return CGSize(width: floatWidthCell, height: floatHeightCell)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height)
        {
            print("Load")
            self.delHomeView?.delegateLoadMore()
        }
    }
}

extension ViewHome: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        if self.arrGenre.count > 0 {
            return self.arrGenre.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var str = ""
        if self.arrGenre.count > 0 {
            str = arrGenre[row].name
        }
        self.btnFilter.setTitle(str, for: .normal)
        self.modelGenreSelected = arrGenre[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       var str = ""
        if self.arrGenre.count > 0 {
            str = arrGenre[row].name
        }
        return str
    }
    
}
