//
//  NotificationTVC.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {

    
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var descriptionLbl: Label!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
