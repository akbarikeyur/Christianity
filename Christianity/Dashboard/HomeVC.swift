//
//  HomeVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import HMSegmentedControl
import DropDown


class HomeVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var segmentControl: HMSegmentedControl!
    @IBOutlet weak var outerScrollView: UIScrollView!
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    
    @IBOutlet var radioBackView: UIView!
    
    @IBOutlet var hymnsBackView: UIView!
    @IBOutlet weak var hymnsTblView: UITableView!
    @IBOutlet weak var hymnsCategoryLbl: UILabel!
    
    @IBOutlet var scheduleBackView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var scheduleTblView: UITableView!
    
    @IBOutlet weak var syncLbl: UILabel!
    
    @IBOutlet weak var radioLbl: UILabel!
    @IBOutlet weak var trackTblView: UITableView!
    @IBOutlet weak var playBtn: UIButton!
    
    var selectedDate : Date!
    var lastContentOffset : CGFloat = 0.0
    
    var categoryDataArr : [CategoryModel] = [CategoryModel]()
    var categoryArr : [String] = ["All"]
    
    var categoryHymnsArr : [HymnsModel] = [HymnsModel]()
    var allHymnsArr : [HymnsModel] = [HymnsModel]()
    var searchHymnsArr : [HymnsModel] = [HymnsModel]()
    var trackArr : [TrackModel] = [TrackModel]()
    var selectedTrack : TrackModel = TrackModel.init()
    var scheduleArr : [ScheduleModel] = [ScheduleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayPauseState), name: NSNotification.Name.init(NOTIFICATION.UPDATE_PLAY_PAUSE), object: nil)
        
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        scheduleTblView.register(UINib(nibName: "SchedulesTVC", bundle: nil), forCellReuseIdentifier: "SchedulesTVC")
        hymnsTblView.register(UINib(nibName: "HymnsTVC", bundle: nil), forCellReuseIdentifier: "HymnsTVC")
        trackTblView.register(UINib(nibName: "TrackVC", bundle: nil), forCellReuseIdentifier: "TrackVC")
        headerTabdesign()
        searchBtn.isHidden = true
    }
    
    func headerTabdesign()  {
        segmentControl?.sectionTitles = ["radio".localizedStr(language: getDefaultLanguage()),
                                         "hymns".localizedStr(language: getDefaultLanguage()),
                                         "schedule".localizedStr(language: getDefaultLanguage())]
        
        segmentControl?.selectedSegmentIndex = 0
        segmentControl?.backgroundColor = AppColor
        
        let font = UIFont(name: APP_BOLD, size: 16)//.systemFont(ofSize: 15)
        segmentControl?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: WhiteColor.withAlphaComponent(0.6), NSAttributedString.Key.font: font as Any]
        segmentControl?.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControl?.selectionIndicatorColor = UIColor.white
        segmentControl?.selectionIndicatorHeight = 3.0
        segmentControl?.selectionStyle = HMSegmentedControlSelectionStyle.box
        segmentControl?.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl?.selectionIndicatorBoxColor = AppColor
        
        segmentControl?.indexChangeBlock = {(_ index: Int) -> Void in
            print(index)
            self.outerScrollView!.scrollRectToVisible(CGRect(x: (Int(SCREEN.WIDTH) * index), y: 0, width: Int(SCREEN.WIDTH), height: 200), animated: true)
            self.searchBtn.isHidden = !(index == 1)
        }
        
        outerScrollView.alwaysBounceHorizontal = true
        
        outerScrollView?.contentSize = CGSize(width: SCREEN.WIDTH * 3, height: SCREEN.HEIGHT - 120)
        outerScrollView?.delegate = self

        radioBackView.frame = CGRect(x: 0, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(radioBackView)

        hymnsBackView.frame = CGRect(x: Int(SCREEN.WIDTH), y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 114))
        outerScrollView?.addSubview(hymnsBackView)

        scheduleBackView.frame = CGRect(x: Int(SCREEN.WIDTH) * 2, y: 0, width: Int(SCREEN.WIDTH), height: Int(SCREEN.HEIGHT - 120))
        outerScrollView?.addSubview(scheduleBackView)
        
        hymnsCategoryLbl.text = NSLocalizedString("category_lbl", comment: "") + "All"
        timeLbl.text = NSLocalizedString("schedule_lbl", comment: "") + getDateStringFromDate(date: Date(), format: "dd MMM")
        
        serviceCallToGetSchedule(getDateStringFromDate(date: Date(), format: "MM-dd-yyyy"))
        
        if getCategortyList().count == 0 {
            serviceCallToGetAllCategory()
        }
        else {
            for item in getCategortyList() {
                self.categoryDataArr.append(CategoryModel.init(dict: item))
                self.categoryArr.append(item["category"] as! String)
            }
            self.syncLbl.text = NSLocalizedString("last_sync_lbl", comment: "") + getSyncTime()
        }
        
        if getHymnsList().count == 0 {
            serviceCallToGetAllHymns()
        }
        else {
            for item in getHymnsList() {
                self.allHymnsArr.append(HymnsModel.init(dict: item))
            }
            self.categoryHymnsArr = self.allHymnsArr
            self.hymnsTblView.reloadData()
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        serviceCallToGetTrackData()
    }
    
    func serviceCallToGetTrackData()  {
        APIManager.shared.serviceCallToGetTrackData { (data) in
            self.trackArr = [TrackModel]()
            for item in data {
                self.trackArr.append(TrackModel.init(dict: item))
            }
            if self.selectedTrack.title == "" && self.trackArr.count > 0
            {
                self.selectedTrack = self.trackArr[0]
            }
            self.trackTblView.reloadData()
        }
    }
    
    func serviceCallToGetAllCategory() {
        APIManager.shared.serviceCallToGetCategory { (data) in
            setCategoryList(arrValue: data)
            
            let timeStamp = getDateStringFromDate(date: Date())
            setSyncTime(timeStamp)
            self.syncLbl.text = NSLocalizedString("last_sync_lbl", comment: "") + timeStamp
            
            for item in data {
                self.categoryDataArr.append(CategoryModel.init(dict: item))
                self.categoryArr.append(item["category"] as! String)
            }
          
        }
    }
    
    func serviceCallToGetAllHymns() {
        APIManager.shared.serviceCallToGetAllHymns { (data) in
            setHymnsList(arrValue: data)
            self.allHymnsArr = [HymnsModel]()
            
            for item in data {
                self.allHymnsArr.append(HymnsModel.init(dict: item))
            }
            self.categoryHymnsArr = self.allHymnsArr
            self.hymnsTblView.reloadData()
        }
    }
    
    func serviceCallToGetSchedule(_ date : String) {
        APIManager.shared.serviceCallToGetSelectedShedule(date) { (data) in
            self.scheduleArr = [ScheduleModel]()
            for item in data {
                self.scheduleArr.append(ScheduleModel.init(dict: item))
            }
            self.scheduleTblView.reloadData()
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollview: UIScrollView) {
        if scrollview == outerScrollView {
            self.lastContentOffset = outerScrollView.contentOffset.x;
            
            let pageWidth : CGFloat = scrollview.frame.size.width;
            let page = scrollview.contentOffset.x / pageWidth;
            
            print(pageWidth)
            print(page)
            
            segmentControl?.selectedSegmentIndex = Int(page)
        }
    }
 
    
    //MARK: - Button Click
    @IBAction func clickToSidemenu(_ sender: Any) {
        self.view.endEditing(true)
        self.menuContainerViewController.toggleLeftSideMenuCompletion({
            
        })
    }
    
    @IBAction func clickToSearch(_ sender: Any) {
        searchTxt.text = ""
        searchView.isHidden = false
        searchTxt.becomeFirstResponder()
    }
    @IBAction func clickToCloseSearch(_ sender: Any) {
        self.view.endEditing(true)
        searchTxt.text = ""
        searchView.isHidden = true
        hymnsTblView.reloadData()
    }
    
    @IBAction func clickToSelectSchedule(_ sender: Any) {
        self.view.endEditing(true)
        if selectedDate == nil
        {
            selectedDate = Date()
        }
   //     let maxDate : Date = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        DatePickerManager.shared.showPicker(title: "select_dob", selected: selectedDate, min: Date(), max: nil) { (date, cancel) in
            if !cancel && date != nil {
                self.selectedDate = date!
                self.timeLbl.text = NSLocalizedString("schedule_lbl", comment: "") + getDateStringFromDate(date: self.selectedDate, format: "dd MMM")
                
                self.serviceCallToGetSchedule(getDateStringFromDate(date: self.selectedDate, format: "MM-dd-yyyy"))
            }
        }
    }
    
    @IBAction func clickToSelectCategory(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = categoryArr
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.hymnsCategoryLbl.text = NSLocalizedString("category_lbl", comment: "") + self.categoryArr[index]
            if index == 0 {
                self.categoryHymnsArr = [HymnsModel]()
                self.categoryHymnsArr = self.allHymnsArr
                self.hymnsTblView.reloadData()
            }
            else {
                self.categoryHymnsArr = [HymnsModel]()
                for item in self.allHymnsArr {
                    if item.cat == self.categoryArr[index] {
                        self.categoryHymnsArr.append(item)
                    }
                }
                self.hymnsTblView.reloadData()
            }
        }
        dropDown.show()
    }
    
    @IBAction func clickToSyncNow(_ sender: Any) {
        serviceCallToGetAllCategory()
        serviceCallToGetAllHymns()
    }
    
    @IBAction func clickToPlay(_ sender: Any) {
        if (MusicHandle.shared.player.rate) != 0 {
            MusicHandle.shared.pauseMusic()
            playBtn.isSelected = false
        } else {
            MusicHandle.shared.selectedTrack = selectedTrack
            MusicHandle.shared.prepareToPlayTrack(selectedTrack.link)
            radioLbl.text = selectedTrack.title
            playBtn.isSelected = true
        }
    }
    
    @objc func updatePlayPauseState(){
        if (MusicHandle.shared.player.rate) != 0 {
            playBtn.isSelected = true
        }else{
            playBtn.isSelected = false
        }
    }
    
    @IBAction func clickToSocialShare(_ sender: UIButton) {
        if sender.tag == 1 {
            openUrlInSafari(strUrl: "https://www.facebook.com/christianity.radio")
        }
        else if sender.tag == 2 {
            openUrlInSafari(strUrl: "https://www.youtube.com/channel/UCJafx_vYZBEILdTebZCK1xw")
        }
        else {
            openUrlInSafari(strUrl: "https://www.christianity.gr/")
        }
    }
    
    @IBAction func clickToCancelShare(_ sender: UIButton) {
        
    }
    
    //MARK: - Tableview delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == hymnsTblView {
            return searchTxt.text != "" ? searchHymnsArr.count : categoryHymnsArr.count
        }
        else if tableView == trackTblView {
            return trackArr.count
        }
        else {
            return scheduleArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hymnsTblView {
            let cell = hymnsTblView.dequeueReusableCell(withIdentifier: "HymnsTVC", for: indexPath) as! HymnsTVC
            let dict : HymnsModel = (searchTxt.text != "" ? searchHymnsArr : categoryHymnsArr)[indexPath.row]
            
            cell.headerLbl.text = dict.number + " " + dict.title
            
            let str = "<font size=5>" + dict.body + "</font>"
            cell.subLbl.attributedText = str.html2AttributedString
            cell.subLbl.textAlignment = .center
            return cell
        }
        else if tableView == trackTblView {
            let cell = trackTblView.dequeueReusableCell(withIdentifier: "TrackVC", for: indexPath) as! TrackVC
            let dict : TrackModel = trackArr[indexPath.row]
            
            cell.headerLbl.text = dict.title.components(separatedBy: " - ").first
            cell.subLbl.text = dict.title.components(separatedBy: " - ").last
            return cell
        }
        else
        {
            let cell = scheduleTblView.dequeueReusableCell(withIdentifier: "SchedulesTVC", for: indexPath) as! SchedulesTVC
            let dict : ScheduleModel = scheduleArr[indexPath.row]
            cell.titleLbl.text = dict.title
            cell.personLbl.text = dict.person
            cell.descLbl.text = dict.body
            cell.imgBtn.setTitle(dict.time, for: .normal)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == hymnsTblView {
            let dict : HymnsModel = (searchTxt.text != "" ? searchHymnsArr : categoryHymnsArr)[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DisplayHymnsVC") as! DisplayHymnsVC
            vc.selectedHymns = dict
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if tableView == trackTblView {
            selectedTrack = trackArr[indexPath.row]
            MusicHandle.shared.selectedTrack = selectedTrack
            MusicHandle.shared.prepareToPlayTrack(selectedTrack.link)
            radioLbl.text = selectedTrack.title
            playBtn.isSelected = true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        searchHymnsArr = [HymnsModel]()
        searchHymnsArr = categoryHymnsArr.filter({ (result) -> Bool in
            let nameTxt: NSString = result.title! as NSString
            return (nameTxt.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        hymnsTblView.reloadData()
    }
    
}


extension NSMutableAttributedString {
    @discardableResult
    func setFont(_ font: UIFont, range: NSRange? = nil)-> NSMutableAttributedString {
        let range = range ?? NSMakeRange(0, self.length)
        self.addAttributes([.font: font], range: range)
        return self
    }
}
