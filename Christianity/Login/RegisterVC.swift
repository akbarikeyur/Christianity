//
//  RegisterVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var nameTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    
    //MARK: - BUTTON ACTION
    @IBAction func ClickToRegister(_ sender: Any) {
        self.view.endEditing(true)
        if nameTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_name", comment: ""))
        }
        else if emailTxt.text?.trimmed.count == 0
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
            param["name"] = nameTxt.text
            param["device_token"] = getPushToken()
            
            APIManager.shared.serviceCallToUserRegister(param) {
                AppDelegate().sharedDelegate().navigateToDashBoard()
            }

        }
        
    
        
    }
    
    @IBAction func clickToLogin(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

}
