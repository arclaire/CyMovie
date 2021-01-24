//
//  VCFilter.swift
//  SimpleApps
//
//  Created by lucy on 14/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//


import UIKit

protocol DelegateVCFilter: NSObjectProtocol {
    func delegateFilter(data: Filter)
    
}


class VCFilter: UIViewController {
    
    @IBOutlet var vwFilter: ViewFilter!
    
    var data: ModelMovie?
    weak var delVcFilter: DelegateVCFilter?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.vwFilter.delVwFilter = self
        
        if let data = self.data {
            self.vwFilter.prepareUI(data: data)
            self.callApiGetVideo()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    private func callApiGetVideo() {
        if let data = self.data {
            let id = data.strId
            self.vwFilter.loadVideo(isLoading: true)
            ServiceProducts.getVideos(id: id, onsuccess: { (product) in
                if product.count > 0 {
                    if let data = product.first {
                        self.vwFilter.playVideo(url: data.key)
                    }
                    
                } else {
                    self.vwFilter.labelNoVideo.isHidden = false
                }
                self.vwFilter.loadVideo(isLoading: false)
            }) { (error) in
                self.vwFilter.loadVideo(isLoading: false)
                self.vwFilter.labelNoVideo.isHidden = false
            }
        }
    }
}

extension VCFilter: DelegateViewFilter {
    func delegateDismissFilter() {
        self.dismiss(animated: true) {
            
        }
    }
    
    func delegateApplyFilter(data: Filter) {
        self.delVcFilter?.delegateFilter(data: data)
        self.dismiss(animated: true)
    }
}
