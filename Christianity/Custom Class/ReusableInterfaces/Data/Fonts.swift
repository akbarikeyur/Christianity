//
//  Fonts.swift
//  Cozy Up
//
//  Created by Amisha on 22/05/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation

import UIKit

let APP_REGULAR = "Avenir-Book"
let APP_BOLD = "Avenir-Heavy"



enum FontType : String {
    case Clear = ""
    case ARegular = "ar"
    case ABold = "ab"
   
}


extension FontType {
    var value: String {
        get {
            switch self {
            case .Clear:
                return APP_REGULAR
            
            case .ARegular:
                return APP_REGULAR
            case .ABold:
                return APP_BOLD
            
            }
        }
    }
}

