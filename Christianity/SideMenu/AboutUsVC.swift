//
//  AboutUsVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit


class AboutTVC: UITableViewCell {
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var lbl: UILabel!
}


class AboutUsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    
//    var aboutArr = ["Call Us","Mail Us","Visit our Websites","Facebook","YouTube"]
    
    var aboutArr = ["call_us".localizedStr(language: getDefaultLanguage()),
                    "mail_us".localizedStr(language: getDefaultLanguage()),
                    "visit_our_website".localizedStr(language: getDefaultLanguage()),
                    "facebook".localizedStr(language: getDefaultLanguage()),
                    "youtube".localizedStr(language: getDefaultLanguage())]
    
    var dataArrImg = ["phone","email","website","facebook","youtube"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - TableView delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "AboutTVC", for: indexPath) as! AboutTVC
        
        cell.lbl.text = aboutArr[indexPath.row]
        cell.imgBtn.setImage(UIImage(named: dataArrImg[indexPath.row]), for: .normal)
        
        return cell
    }

}
