//
//  GlobalConstant.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation
import UIKit


let DEVICE_ID = UIDevice.current.identifierForVendor?.uuidString

struct SCREEN
{
    static var WIDTH = UIScreen.main.bounds.size.width
    static var HEIGHT = UIScreen.main.bounds.size.height
}

struct DATE_FORMAT {
    static var SERVER_DATE_FORMAT = "YYYY-MM-dd"
    static var SERVER_TIME_FORMAT = "HH:mm"
    static var SERVER_DATE_TIME_FORMAT = "yyyy-MM-dd" //HH:mm:ss"
    static var DISPLAY_DATE_FORMAT = "dd/MM/yyyy"
    static var DISPLAY_DATE_FORMAT1 = "MM/dd/yyyy"
    static var DISPLAY_TIME_FORMAT = "hh:mm a"
    static var DISPLAY_DATE_TIME_FORMAT = "YYYY-MM-dd HH:mm:ss"
}

struct CONSTANT{
    static var DP_IMAGE_WIDTH     =  1000
    static var DP_IMAGE_HEIGHT    =  1000
    
    static let MAX_EMAIL_CHAR = 254
    static let MAX_PREFER_NAME_CHAR = 40
    static let MIN_PWD_CHAR = 8
    static let MAX_PWD_CHAR = 16
    static let MAX_FIRST_NAME_CHAR = 40
    static let MAX_MIDDLE_NAME_CHAR = 40
    static let MAX_LAST_NAME_CHAR = 40
    
    static let DOB_CHAR = 8
    static let DOB_SPACE_CHAR = 4
    static let DOB_DATE_CHAR = 2
    static let DOB_MONTH_CHAR = 2
    static let DOB_YEAR_CHAR = 4
    
    static let MOBILE_NUMBER_CHAR = 8
    static let MOBILE_NUMBER_SPACE_CHAR = 2
    static let MOBILE_NUMBER_CODE = ""
    
    static let CARD_NUMBER_CHAR = 16
    static let CARD_NUMBER_DASH_CHAR = 3
    static let CARD_EXP_DATE_CHAR = 5
    static let CARD_CVV_CHAR = 3
    
    static let SMS_CODE_CHAR = 4
    static let SMS_CODE_SPACE_CHAR = 3
    
    static let IMAGE_QUALITY   =  1
    
    static let CURRENCY   =  "$"
    static let DIST_MEASURE   =  "km"
    static let TIME_ZONE = "Australia/Sydney"
    
    static let DEF_TAKE : Int = 24
    
    
}

struct STORYBOARD {
    static var MAIN = UIStoryboard(name: "Main", bundle: nil)
}

struct NOTIFICATION {
//    static var UPDATE_CURRENT_USER_DATA     =   "UPDATE_CURRENT_USER_DATA"
//    static var REDICT_TAB_BAR               =   "REDICT_TAB_BAR"
//    static var RESET_ADVANCE_SEARCH         =   "RESET_ADVANCE_SEARCH"
//    static var UPDATE_USER_DATA             =   "UPDATE_USER_DATA"
//    static var UPDATE_CARD_DATA             =   "UPDATE_CARD_DATA"
//    static var UPDATE_FEEDBACK_REQUEST_LIST =   "UPDATE_FEEDBACK_REQUEST_LIST"
//    static var TAG_RELOAD                   =   "TAG_RELOAD"
//    static var SELECTED_LISTENER            =   "SELECTED_LISTENER"
//    static let REDIRECT_SERCHFOR_LISNER     =   "REDIRECT_SERCHFOR_LISNER"
    
    
    static var UPDATE_PLAY_PAUSE            =   "UPDATE_PLAY_PAUSE"
    
}


struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

