//
//  LoginVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

var bundle: Bundle = Bundle() {
    didSet {
        
    }
}


class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - BUTTON ACTION
    @IBAction func ClickToLoginBtn(_ sender: Any) {
        self.view.endEditing(true)
        if emailTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_email", comment: ""))
        }
        else if emailTxt.text?.trimmed.isValidEmail == false
        {
            displayToast(NSLocalizedString("invalid_email", comment: ""))
        }
        else  if passwordTxt.text?.count == 0
        {
            displayToast(NSLocalizedString("enter_password", comment: ""))
        }
        else {
            var param :[String : Any] = [String : Any]()
            param["email"] = emailTxt.text
            param["password"] = passwordTxt.text
            param["device_token"] = getPushToken()
            
            APIManager.shared.serviceCallToLoginUser(param) {
                AppDelegate().sharedDelegate().navigateToDashBoard()
            }
        }
        
  //      AppDelegate().sharedDelegate().navigateToDashBoard()
        
    }
    
    @IBAction func clickToRegister(_ sender: Any) {
        self.view.endEditing(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
