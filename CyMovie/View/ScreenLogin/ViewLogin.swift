//
//  ViewLogin.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import UIKit
protocol DelegateViewLogin: NSObjectProtocol {
  func delegateDoSignup()
  func delegateForgotPass()
  func delegateDoTapButtonLogin(type:String)
}

class ViewLogin: UIView {

  private var vwLogin:UIView!
  
  
  //MARK: Outlets
  
  @IBOutlet weak private var imgvwIcon: UIImageView!
  @IBOutlet weak private var imgvwEmail: UIImageView!
  @IBOutlet weak private var imgvwPass: UIImageView!
  
  @IBOutlet weak private var lblTitle: UILabel!
  @IBOutlet weak private var lblForgotPass: UILabel!
  
  @IBOutlet weak fileprivate var txtEmail: UITextField!
  
  @IBOutlet weak fileprivate var scrollview: UIScrollView!
  @IBOutlet weak fileprivate var txtPass: UITextField!
  @IBOutlet private var  vwParent: UIView!
  @IBOutlet weak private var vwContainerInput: UIView!
  @IBOutlet weak private var vwEmail: UIView!
  @IBOutlet weak private var vwPassword: UIView!
  @IBOutlet weak private var vwLinePassTop: UIView!
  
  @IBOutlet weak fileprivate var btnLogin: UIButton!
  @IBOutlet weak fileprivate var btnSignup: UIButton!
  @IBOutlet weak fileprivate var btnFb: UIButton!
  @IBOutlet weak fileprivate var btnGoogle: UIButton!
  
  //MARK: Layout
  @IBOutlet weak var consVwLinePassTopHeight: NSLayoutConstraint!
  @IBOutlet weak var consImgEmailWidth: NSLayoutConstraint!
  @IBOutlet weak var consImgEmailHeight: NSLayoutConstraint!
  
  @IBOutlet weak var consTxtEmailHeight: NSLayoutConstraint!
  @IBOutlet weak var consTxtPassHeight: NSLayoutConstraint!
  @IBOutlet weak var consImgPassWidth: NSLayoutConstraint!
  @IBOutlet weak var consImgPassHeight: NSLayoutConstraint!
  
  @IBOutlet weak var consBtnLoginHeight: NSLayoutConstraint!
  @IBOutlet weak var consBtnSignUpHeight: NSLayoutConstraint!
  
  
  //MARK: Attributes
  weak var delLoginView: DelegateViewLogin?
  
  private var gestureTapForgotPass: UITapGestureRecognizer!
  
//  var chart: LineChartView!
//  var dataSet: LineChartDataSet!
  
  //MARK: Initialization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    self.vwLogin = self.loadViewFromNIB()
    if let _ = self.vwLogin {
      self.addSubview(self.vwLogin)
    }
  }
  
  //MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    self.vwLogin.setNeedsLayout()
    self.prepareUI()
   
  }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollview.frame = self.scrollview.bounds
    }
  //MARK: - UI Methods
  
  func prepareUI() {
    self.btnSignup.layer.cornerRadius = 20
    self.btnLogin.layer.cornerRadius = 20
    self.scrollview.showsHorizontalScrollIndicator = false
    self.scrollview.showsVerticalScrollIndicator = false
    
    self.vwContainerInput.backgroundColor = UIColor.white
    self.vwEmail.backgroundColor = UIColor.white
    self.vwPassword.backgroundColor = UIColor.white
    self.vwLinePassTop.backgroundColor = UIColor.gray
  
    self.lblTitle.backgroundColor = UIColor.clear
    self.lblForgotPass.backgroundColor = UIColor.clear
    
    self.vwContainerInput.layer.cornerRadius = 10
    self.vwContainerInput.layer.shadowColor = UIColor.gray.cgColor
    self.vwContainerInput.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)

    self.vwContainerInput.layer.shadowRadius = 2
    self.vwContainerInput.layer.shadowOpacity = 0.4
    //self.vwContainerInput.layer.shadowPath = UIBezierPath(rect: self.vwContainerInput.bounds).cgPath
    self.vwContainerInput.layer.shouldRasterize = true
    self.consVwLinePassTopHeight.constant = 0.5
    
   
    self.txtPass.backgroundColor = UIColor.white
    self.txtEmail.backgroundColor = UIColor.white
    
    self.btnSignup.backgroundColor = UIColor.white
  
    self.txtEmail.keyboardType = UIKeyboardType.emailAddress
    self.txtPass.isSecureTextEntry = true
    self.txtPass.returnKeyType = UIReturnKeyType.done
    self.txtEmail.returnKeyType = UIReturnKeyType.next
    self.txtEmail.delegate = self
    self.txtPass.delegate = self
  
    self.gestureTapForgotPass = UITapGestureRecognizer(target: self, action:#selector(self.gestureTapAction(_:)))
    self.gestureTapForgotPass.numberOfTapsRequired = 1
    self.lblForgotPass.addGestureRecognizer(self.gestureTapForgotPass)
    
    self.lblForgotPass.isUserInteractionEnabled = true
    
  }
  
  //MARK: - Data Methods
  
  
  //MARK: - ButtonAction

  @IBAction func doTapButton(_ sender: Any) {
    self.delLoginView?.delegateDoSignup()
   
  }
  
    @objc func gestureTapAction(_ sender: UITapGestureRecognizer) {
    
  }
 }

extension ViewLogin: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
   
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == self.txtEmail {
      self.txtPass.becomeFirstResponder()
      
    } else if textField == self.txtPass {
      
      self.txtPass.resignFirstResponder()
      if (self.txtPass.text?.count)! > 0 && (self.txtEmail.text?.count)! > 0 {
      
      }
    } else {
      
      
    }
    return true
  }
}

