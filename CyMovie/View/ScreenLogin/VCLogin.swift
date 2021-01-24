//
//  VCLogin.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {

  @IBOutlet var vcLogin: ViewLogin!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.isHidden = true
    self.vcLogin.delLoginView = self
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension VCLogin: DelegateViewLogin {
 
  func delegateForgotPass() {
    self.dismiss(animated: true, completion: nil)
    
   
  }
  
  func delegateDoTapButtonLogin(type: String) {
   self.dismiss(animated: true, completion: nil)
  }
  
  func delegateDoSignup() {
    self.dismiss(animated: true, completion: nil)
  }
 
}
