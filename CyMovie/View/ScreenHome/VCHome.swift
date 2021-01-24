//
//  VCHome.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

class VCHome: UIViewController {

    var filter: Filter = Filter.init(jsonData: "")
    @IBOutlet var vwHome: ViewHome!
    var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwHome.delHomeView = self
        self.callApi(genre: self.vwHome.intGenre)
        self.callAPIGenre()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if !self.isLogin {
//            self.isLogin = true
//            self.performSegue(withIdentifier: "openLogin", sender: self)
//        }
        
    }
    //MARK: - SERVICES
    func callApi(genre: Int) {
        self.isLoading = true
        self.filter.intStart = self.vwHome.intPage
        debugPrint("Start From", self.vwHome.intPage)
        ServiceProducts.getMovieList(page: self.vwHome.intPage, genreId: genre, onsuccess: { (product) in
            if product.count > 0 {
                self.vwHome.arrProducts += product
                self.vwHome.intPage = self.vwHome.intPage + 1
                self.vwHome.reloadUI()
            } else {
                self.vwHome.isFetching = false
            }
            self.vwHome.stopAnimationLoad()
            self.isLoading = false
        }) { (error) in
            self.vwHome.isFetching = false
            self.vwHome.stopAnimationLoad()
            self.isLoading = false
        }
    }
    
    func callAPIGenre() {
      
        ServiceProducts.getGenre(sortBy: filter, onsuccess: { (product) in
            if product.count > 0 {
                self.vwHome.colProduct.isHidden = false
                self.vwHome.arrGenre = product
                self.vwHome.reloadUI()
            } else {
                self.vwHome.colProduct.isHidden = true
                
            }
        }) { (error) in
        }
    }

    
}

extension VCHome: DelegateViewHome {
    
    func delegateOpenDetail(data: ModelMovie) {
        
         self.performSegue(withIdentifier: "openFilter", sender: self)
    }
    
    func delegateLoadMore() {
        if !self.isLoading {
            self.callApi(genre: self.vwHome.intGenre)
        }
    }
    
    func delegateOpenHistory() {
        //self.performSegue(withIdentifier: "openHistory", sender: self)
    }
    
    func delegateFilter(idGenre: Int) {
        self.callApi(genre: self.vwHome.intGenre)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VCFilter {
            vc.data = self.vwHome.modelSelected
        }
    
    }
}
