//
//  SettingsVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet var languageBackView: UIView!
    
//    var questionArr1 = ["Receive Notifications?","Play in background?","Select Language"]
    
    var questionArr = ["setting_question1".localizedStr(language: getDefaultLanguage()),
                       "setting_question2".localizedStr(language: getDefaultLanguage()),
                       "setting_question3".localizedStr(language: getDefaultLanguage())]
    
//    var dataArr = ["Turn this on receive important alerts and notifications about schedules and new hymn updates","Turn this on to continue playing hymns in background","English"]
    
    var dataArr = ["setting_ans1".localizedStr(language: getDefaultLanguage()),
                   "setting_ans2".localizedStr(language: getDefaultLanguage())]
    
    var bundle: Bundle = Bundle() {
        didSet{
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "SettingTVC", bundle: nil), forCellReuseIdentifier: "SettingTVC")
        
        languageBackView.isHidden = true
        
        print(questionArr)
    }
 
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToLanguageSelect(_ sender: UIButton) {
        if getDefaultLanguage() == "en" && sender.tag == 1 {
            return
        }
        else if getDefaultLanguage() == "el" && sender.tag == 2 {
            return
        }
        
        let myAlert = UIAlertController(title:"", message:"language_change_alert_title".localizedStr(language: getDefaultLanguage()), preferredStyle: UIAlertController.Style.alert)

        let rightBtn = UIAlertAction(title: "language_change_alert_yes".localizedStr(language: getDefaultLanguage()), style: UIAlertAction.Style.default, handler: { (action) in
            if sender.tag == 2 {
                setDefaultLanguage("el")
                LanguageManager.sharedInstance.setLocale("el")
                self.bundle = LanguageManager.sharedInstance.getCurrentBundle()
            }
            else {
                setDefaultLanguage("en")
                LanguageManager.sharedInstance.setLocale("en")
                self.bundle = LanguageManager.sharedInstance.getCurrentBundle()
            }
            delay(0.1, closure: {
                exit(0)
            })
        })
        let leftBtn = UIAlertAction(title: "language_change_alert_cancel".localizedStr(language: getDefaultLanguage()), style: UIAlertAction.Style.cancel, handler: { (action) in

        })
        myAlert.addAction(rightBtn)
        myAlert.addAction(leftBtn)
        self.present(myAlert, animated: true, completion: nil)
        
        languageBackView.isHidden = true
        
    }
    
    @IBAction func clickToHideLanguageView(_ sender: Any) {
        languageBackView.isHidden = true
    }
    
    
    //MARK: - TableView delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "SettingTVC", for: indexPath) as! SettingTVC
        
        cell.lbl.text = questionArr[indexPath.row]
        if indexPath.row == 2 {
            
            cell.subLbl.text = getDefaultLanguage() == "en" ? "English" : "Ελληνικά"
        }else {
            cell.subLbl.text = dataArr[indexPath.row]
        }
       
        
        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxBtn.addTarget(self, action: #selector(self.clickTocheckBox), for: .touchUpInside)
        
        cell.checkBoxBtn.isHidden = indexPath.row == 2 ? true : false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            languageBackView.isHidden = false
            displaySubViewtoParentView(self.view, subview: languageBackView)
        }
    }
    
    @objc func clickTocheckBox(sender : UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
