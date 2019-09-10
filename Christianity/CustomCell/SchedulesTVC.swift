//
//  SchedulesTVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class SchedulesTVC: UITableViewCell {

    
    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var personLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
