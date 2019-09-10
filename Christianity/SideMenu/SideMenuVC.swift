//
//  SideMenuVC.swift
//  BeatBox
//
//  Created by PC on 15/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class SideMenuTVC: UITableViewCell {
    
    @IBOutlet weak var lbl: Label!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var bottomImgView: UIImageView!
    
}


class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var emailLbl: Label!
    
    
    
  //  var lblArr = ["Home","Weekly Schedule","Notifications","Settings", "Rate Us","About Us","Log Out"]
    
    var lblArr = ["home".localizedStr(language: getDefaultLanguage()),
                  "weekly_schedule".localizedStr(language: getDefaultLanguage()),
                  "notifications".localizedStr(language: getDefaultLanguage()),
                  "settings".localizedStr(language: getDefaultLanguage()),
                  "rate_us".localizedStr(language: getDefaultLanguage()),
                  "about_us".localizedStr(language: getDefaultLanguage()),
                  "log_out".localizedStr(language: getDefaultLanguage())]

    
    var sideMenuImg = ["ic_home","ic_schedule","ic_notifications","ic_settings","ic_rate","ic_about_us","ic_logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppModel.shared.currentUser.email != "" {
            nameLbl.text = AppModel.shared.currentUser.name
            emailLbl.text = AppModel.shared.currentUser.email
        }
    }
 
   
    //MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lblArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath) as! SideMenuTVC
        cell.lbl.text = lblArr[indexPath.row]
        
        cell.imgBtn.setImage(UIImage(named: sideMenuImg[indexPath.row]), for: .normal)
        
        cell.bottomImgView.isHidden = indexPath.row == 5 ? false : true
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion(nil)
        if indexPath.row == 0 {
            
        }
        else if indexPath.row == 1
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleVC") as! ScheduleVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4
        {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleVC") as! ScheduleVC
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            AppDelegate().sharedDelegate().logout()
        }
        
       
    }

    

}
