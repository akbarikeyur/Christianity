//
//  DisplayHymnsVC.swift
//  Christianity
//
//  Created by PC on 22/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit


class DisplayHymnsVC: UIViewController {

    var selectedHymns : HymnsModel = HymnsModel()
    
    @IBOutlet weak var outerScrollView: UIScrollView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var poemLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLbl.text = selectedHymns.title
        let str = "<font size=5>" + selectedHymns.body + "</font>"
        poemLbl.attributedText = str.html2AttributedString
        poemLbl.textAlignment = .center
    }
    
    @IBAction func clicKToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
