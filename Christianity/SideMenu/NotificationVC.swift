//
//  NotificationVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    var notificationArr : [NotificationModel] = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "NotificationTVC", bundle: nil), forCellReuseIdentifier: "NotificationTVC")
        serviceCallToNotificationList()
    }
    
    func serviceCallToNotificationList()  {
        APIManager.shared.serviceCallToGetNotificationList { (data) in
            for item in data {
                self.notificationArr.append(NotificationModel.init(dict: item))
            }
            self.tblView.reloadData()
        }
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
        return notificationArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as! NotificationTVC
        
        let dict : NotificationModel = notificationArr[indexPath.row]
        
        cell.descriptionLbl.text = dict.body
        cell.titleLbl.text = dict.title
        
        cell.dateLbl.text = getDateFromDateString1(strDate: dict.date)
        
        return cell
    }
    
    
    

}
