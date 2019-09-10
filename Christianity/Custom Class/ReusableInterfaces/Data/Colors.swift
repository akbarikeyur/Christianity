//
//  Colors.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var DarkGrayColor : UIColor = colorFromHex(hex: "222222") //2
var LightGrayColor : UIColor = colorFromHex(hex: "9A9A9A") //3
var ExtraLightGrayColor : UIColor = colorFromHex(hex: "B2B0B0") //4
var BlackColor : UIColor = UIColor.black   //5


var DarkGreenColor : UIColor = colorFromHex(hex: "219BD6") //6
var LightGreenColor : UIColor = colorFromHex(hex: "8EC0E6") //7

var AppColor : UIColor = colorFromHex(hex: "1D8BF1") //8

var RedColor : UIColor = colorFromHex(hex: "F01B1E") //9
var OrangeColor : UIColor = colorFromHex(hex: "E77500") //10

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case DarkGray = 2
    case LightGray = 3
    case ExtraLightGray = 4
    case Black = 5
    
    case DarkGreen = 6
    case LightGreen = 7
    
    case App = 8
    
    case red = 9
    case Orange = 10
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
            case .Clear: //0
                return ClearColor
            case .White: //1
                return WhiteColor
            case .DarkGray: //2
                return DarkGrayColor
            case .LightGray: //3
                return LightGrayColor
            case .ExtraLightGray: //4
                return ExtraLightGrayColor
            case .Black: //5
                return BlackColor
                
                
            case .DarkGreen: //6
                return DarkGreenColor
            case .LightGreen: //7
                return LightGreenColor
                
            case .App: //8
                return AppColor
                
            case .red: //9
                return RedColor
            case .Orange: //10
                return OrangeColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case App = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    DarkGreenColor.cgColor,
                    LightGreenColor.cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}


//enum GradientColorTypeForView : Int32 {
//    case Clear = 0
//    case App = 1
//}
//
//
//extension GradientColorTypeForView {
//    var layer : GradientLayer {
//        get {
//            let gradient = GradientLayer()
//            switch self {
//            case .Clear: //0
//                gradient.frame = CGRect.zero
//            case .App: //1
//                gradient.colors = [
//                    WhiteColor.cgColor,
//                    SkyColor.cgColor
//                ]
//                gradient.locations = [0, 1]
//                gradient.startPoint = CGPoint(x: 0.8, y: 1.0)
//                gradient.endPoint = CGPoint(x: 0.8, y: 0.0)
//
//            }
//
//            return gradient
//        }
//    }
//}

