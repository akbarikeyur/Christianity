    
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire
import AlamofireJsonToObjects

//Development
struct API {
    
    static let BASE_URL = "https://christianity-f2f6c.appspot.com/api/"
    
    
    static let LOGIN_USER       =       BASE_URL + "userLogin"
    static let USER_REGISTER    =       BASE_URL + "userRegister"
    static let GET_CATEGORY     =       BASE_URL + "getCategories"
    static let GET_ALL_HYMNS    =       BASE_URL + "allHymns"
    
    static let SELECTED_SCHEDULE    =       BASE_URL + "selectedSchedule"
    static let NOTIFIACTION_LIST    =       BASE_URL + "getAllNotifications"
}


public class APIManager {
    
    static let shared = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func getJsonHeader() -> [String:String] {
        return ["Content-Type":"application/x-www-form-urlencoded", "Accept" : "application/json"]
    }
    
    func getMultipartHeader() -> [String:String]{
        return ["Content-Type":"multipart/form-data", "Accept" : "application/json"]
    }
    
    func getJsonHeaderWithToken() -> [String:String] {
        return ["Content-Type":"application/json", "Accept" : "application/json", "Authorization": getAccessToken()]
    }
    
    func getMultipartHeaderWithToken() -> [String:String] {
        return ["Content-Type":"multipart/form-data", "Accept" : "application/json", "Authorization": getAccessToken()]
    }
    
    func networkErrorMsg()
    {
        removeLoader()
        showAlert("Christianity", message: "You are not connected to the internet") {
            
        }
    }
    
    func convertToJson(_ dict:[String:Any]) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
    
//    func isServiceError(_ code: Int?) -> Bool {
//        if(code == 401    )
//        {
//            //AppDelegate().sharedDelegate().logoutApp()
//            return true
//        }
//        return false
//    }

    
    
    func serviceCallToUserRegister(_ param : [String : Any],_ completion: @escaping () -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        showLoader()

        let headerParams :[String : String] = getJsonHeader()


        Alamofire.request(API.USER_REGISTER, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in

            removeLoader()
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                
                    if let token : String = result["token"] as? String
                    {
                        setAccessToken(token)
                    }
                    if let userDict : [String : Any] = result["user"] as? [String : Any] {
                        AppModel.shared.currentUser = UserModel.init()
                        AppModel.shared.currentUser = UserModel.init(dict: userDict)
                        setIsUserLogin(isUserLogin: true)
                        setLoginUserData(userDict)
                        completion()
                        return
                    }
                    
                }
            
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func serviceCallToLoginUser(_ param : [String : Any],_ completion: @escaping () -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        showLoader()

        let headerParams :[String : String] = getJsonHeader()
        print(param)
        Alamofire.request(API.LOGIN_USER, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in

            removeLoader()
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                   
                    if let token : String = result["token"] as? String
                    {
                        setAccessToken(token)
                    }
                    if let userDict : [String : Any] = result["user"] as? [String : Any] {
                        AppModel.shared.currentUser = UserModel.init()
                        AppModel.shared.currentUser = UserModel.init(dict: userDict)
                        setIsUserLogin(isUserLogin: true)
                        setLoginUserData(userDict)
                        completion()
                        return
                    }
                    
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func serviceCallToGetCategory(_ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        showLoader()
        
        let headerParams :[String : String] = getJsonHeader()
        
        
        Alamofire.request(API.GET_CATEGORY, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerParams).responseJSON { (response) in
            
            removeLoader()
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                    if let data : [[String : Any]] = result["data"] as? [[String : Any]]  {
                       completion(data)
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func serviceCallToGetAllHymns(_ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        showLoader()
        
        let headerParams :[String : String] = getJsonHeader()
        
        
        Alamofire.request(API.GET_ALL_HYMNS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerParams).responseJSON { (response) in
            
            removeLoader()
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                    if let data : [[String : Any]] = result["data"] as? [[String : Any]] {
                        completion(data)
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func serviceCallToGetSelectedShedule(_ selectedDate : String,_ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        showLoader()
        
        let headerParams :[String : String] = getJsonHeader()
        
        var param : [String : Any] = [String : Any]()
        param["selectdate"] = selectedDate
        
        Alamofire.request(API.SELECTED_SCHEDULE, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            removeLoader()
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                    if let data : [[String : Any]] = result["data"] as? [[String : Any]] {
                        completion(data)
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func serviceCallToGetTrackData(_ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
       
        
        let headerParams :[String : String] = getJsonHeader()
        
        
        Alamofire.request("https://eu1.fastcast4u.com/recentfeed/afreeapo/json/", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                    if let data : [[String : Any]] = result["items"] as? [[String : Any]] {
                        completion(data)
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func serviceCallToGetNotificationList(_ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        showLoader()
        
        let headerParams :[String : String] = getJsonHeader()
        
        
        Alamofire.request(API.NOTIFIACTION_LIST, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerParams).responseJSON { (response) in
            
            removeLoader()
            switch response.result {
            case .success:
                print(response.result.value!)
                if let result = response.result.value as? [String:Any] {
                    if let data : [[String : Any]] = result["data"] as? [[String : Any]] {
                        completion(data)
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

}
