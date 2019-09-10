//
//  ScheduleVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import HMSegmentedControl

class ScheduleVC: UIViewController, UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate {

    @IBOutlet weak var segmentControl: HMSegmentedControl!
    @IBOutlet weak var outerScrollView: UIScrollView!
    
    @IBOutlet var firstScheduleBackView: UIView!
    @IBOutlet weak var firstScheduleTblView: UITableView!
    
    @IBOutlet var secondScheduleBackView: UIView!
    @IBOutlet weak var secondScheduleTblView: UITableView!
    
    @IBOutlet var thirdScheduleBackView: UIView!
    @IBOutlet weak var thirdScheduleTblView: UITableView!
    
    @IBOutlet var fourthScheduleBackView: UIView!
    @IBOutlet weak var fourthScheduleTblView: UITableView!
    
    @IBOutlet var fifthScheduleBackView: UIView!
    @IBOutlet weak var fifthScheduleTblView: UITableView!
    
    @IBOutlet var sixscheduleBackView: UIView!
    @IBOutlet weak var sixthScheduleTblView: UITableView!
    
    @IBOutlet var sevenSchedulrBackView: UIView!
    @IBOutlet weak var sevenScheduleTblView: UITableView!
    
    
    var dateArr : [String] = [String]()
    var scheduleArr : [ScheduleModel] = [ScheduleModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        secondScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        thirdScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        fourthScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        fifthScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        sixthScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        sevenScheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        
        
        headerSetup()
    
       self.serviceCallToGetSchedule(getDateStringFromDate(date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!, format: "MM-dd-yyyy"), firstScheduleTblView)
        
    }
    
    func serviceCallToGetSchedule(_ date : String, _ tblView : UITableView) {
        APIManager.shared.serviceCallToGetSelectedShedule(date) { (data) in
            self.scheduleArr = [ScheduleModel]()
            for item in data {
                self.scheduleArr.append(ScheduleModel.init(dict: item))
            }
            tblView.reloadData()
        }
    }
    
    func headerSetup() {
        for i in 0...6 {
            let date = Calendar.current.date(byAdding: .day, value: i, to: Date())
            let date1 = "  " + getTodayDateFromCurrentDate(date!) + "  "
            dateArr.append(date1)
        }
        
        segmentControl?.sectionTitles = dateArr
        segmentControl?.selectedSegmentIndex = 0
        segmentControl?.backgroundColor = AppColor
        
        let font = UIFont(name: APP_REGULAR, size: 15)//.systemFont(ofSize: 15)
        segmentControl?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: WhiteColor.withAlphaComponent(0.6), NSAttributedString.Key.font: font]
        segmentControl?.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControl?.selectionIndicatorColor = UIColor.white
        segmentControl?.selectionIndicatorHeight = 3.0
        segmentControl?.selectionStyle = HMSegmentedControlSelectionStyle.box
        segmentControl?.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl?.selectionIndicatorBoxColor = AppColor
        
        segmentControl?.indexChangeBlock = {(_ index: Int) -> Void in
            print(index)
            
            self.outerScrollView!.scrollRectToVisible(CGRect(x: (Int(SCREEN.WIDTH) * index), y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120)), animated: true)
        
            
            self.serviceCallToGetSchedule(getDateStringFromDate(date: Calendar.current.date(byAdding: .day, value: index, to: Date())!, format: "MM-dd-yyyy"), self.selectTableView(index))
            
        }
        
        outerScrollView.alwaysBounceHorizontal = true
        
        outerScrollView?.contentSize = CGSize(width: SCREEN.WIDTH * 7, height: SCREEN.HEIGHT - 120)
        outerScrollView?.delegate = self
        
        firstScheduleBackView.frame = CGRect(x: 0, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(firstScheduleBackView)
        
        secondScheduleBackView.frame = CGRect(x: Int(SCREEN.WIDTH), y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(secondScheduleBackView)
        
        thirdScheduleBackView.frame = CGRect(x: Int(SCREEN.WIDTH) * 2, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(thirdScheduleBackView)
        
        fourthScheduleBackView.frame = CGRect(x: Int(SCREEN.WIDTH) * 3, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(fourthScheduleBackView)
        
        fifthScheduleBackView.frame = CGRect(x: Int(SCREEN.WIDTH) * 4, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(fifthScheduleBackView)
        
        sixscheduleBackView.frame = CGRect(x: Int(SCREEN.WIDTH) * 5, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(sixscheduleBackView)
        
        sevenSchedulrBackView.frame = CGRect(x: Int(SCREEN.WIDTH) * 6, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(sevenSchedulrBackView)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollview: UIScrollView) {
        if scrollview == outerScrollView {
            let pageWidth : CGFloat = scrollview.frame.size.width;
            let page = scrollview.contentOffset.x / pageWidth;
            
            print(pageWidth)
            print(page)
            
            segmentControl?.selectedSegmentIndex = Int(page)
            
            self.serviceCallToGetSchedule(getDateStringFromDate(date: Calendar.current.date(byAdding: .day, value: Int(page), to: Date())!, format: "MM-dd-yyyy"), self.selectTableView(Int(page)))
        }
        
    //    selectTableView(Int(page)).scrollToRow(at: IndexPath(item: 0, section: 0), at: UITableView.ScrollPosition.top, animated: false)
    }
    
    func selectTableView(_ page : Int) -> UITableView {
        var tblView : UITableView = UITableView()
        switch page {
        case 0:
            tblView = firstScheduleTblView
            break
        case 1:
            tblView = secondScheduleTblView
            break
        case 2:
            tblView = thirdScheduleTblView
            break
        case 3:
            tblView = fourthScheduleTblView
            break
        case 4:
            tblView = fifthScheduleTblView
            break
        case 5:
            tblView = sixthScheduleTblView
            break
        default :
            tblView = firstScheduleTblView
        }
        return tblView
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Tableview delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstScheduleTblView {
            return scheduleArr.count
        }
        else if tableView == secondScheduleTblView {
            return scheduleArr.count
        }
        else if tableView == thirdScheduleTblView {
            return scheduleArr.count
        }
        else if tableView == fourthScheduleTblView {
            return scheduleArr.count
        }
        else if tableView == fifthScheduleTblView {
            return scheduleArr.count
        }
        else if tableView == sixthScheduleTblView {
            return scheduleArr.count
        }
        else  {
            return scheduleArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstScheduleTblView {
            let cell = firstScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)            
            return cell
        }
        else if tableView == secondScheduleTblView {
            let cell = secondScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            return cell
        }
        else if tableView == thirdScheduleTblView {
            let cell = thirdScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            return cell
        }
        else if tableView == fourthScheduleTblView {
            let cell = fourthScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            return cell
        }
        else if tableView == fifthScheduleTblView {
            let cell = fifthScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            return cell
        }
        else if tableView == sixthScheduleTblView {
            let cell = sixthScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            return cell
        }
        else  {
            let cell = sevenScheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            return cell
        }
        
    }

}
