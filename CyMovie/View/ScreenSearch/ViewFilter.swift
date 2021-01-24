//
//  ViewFilter.swift
//  SimpleApps
//
//  Created by lucy on 14/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//


import UIKit
import WebKit

protocol DelegateViewFilter: NSObjectProtocol {
  
  func delegateApplyFilter(data: Filter)
  func delegateDismissFilter()
}

class ViewFilter: UIView {

  private var vwFilter:UIView!
  
    @IBOutlet weak var labelNoVideo: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var vwActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var labelVoteAvg: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
   
  
    @IBOutlet weak var colProduct: UICollectionView!
    weak var delVwFilter: DelegateViewFilter?
    

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


  }
  
  //MARK: - UI Methods
    func loadVideo(isLoading: Bool) {
        if isLoading {
            self.vwActivity.startAnimating()
            self.vwActivity.isHidden = true
        } else {
            self.vwActivity.stopAnimating()
            self.vwActivity.isHidden = true
        }
        
    }
    
    func playVideo(url strURL: String) {
        let url = URL(string: "https://www.youtube.com/watch?v=\(strURL)")
        self.webview.load(URLRequest(url: url!))
    }
    
    func prepareUI(data movie: ModelMovie) {
        self.labelNoVideo.isHidden = true
        self.labelTitle.text = movie.strName
        self.labelVoteAvg.text = movie.strVoteAvg
        self.labelOverview.text = movie.strSummary
        self.imageMovie.setImage(source: movie.strImageItemUrl, type: .general, contentMode: .scaleAspectFill)
    }
      
    
}

