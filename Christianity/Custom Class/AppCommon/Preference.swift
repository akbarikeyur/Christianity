//
//  Preference.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class Preference: NSObject {

    static let sharedInstance = Preference()
    
    let IS_USER_LOGIN_KEY       =   "IS_USER_LOGIN"
    let USER_DATA_KEY           =   "USER_DATA"
    let USER_LATITUDE_KEY       =   "USER_LATITUDE"
    let USER_LONGITUDE_KEY      =   "USER_LONGITUDE"
    let USER_PIN               =   "USER_CARD_DETAIL"
    
    let USER_DEFAULT_LANGUAGE   =   "USER_DEFAULT_LANGUAGE"
    let USER_PARAMETER          =   "SYNC_TIME"
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    print(data)
    UserDefaults.standard.set(data, forKey: key)
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: key) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

//MARK: - Access Token
func setAccessToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "user_access_token")
}

func getAccessToken() -> String
{
    if let token : String = getDataFromPreference(key: "user_access_token") as? String
    {
        return token
    }
    return ""
}


func setRefreshToekn(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "user_refresh_token")
}

func getRefreshToekn() -> String
{
    if let token : String = getDataFromPreference(key: "user_refresh_token") as? String
    {
        return token
    }
    return ""
}

//MARK: - User login boolean
func setIsUserLogin(isUserLogin: Bool)
{
    setDataToPreference(data: isUserLogin as AnyObject, forKey: Preference.sharedInstance.IS_USER_LOGIN_KEY)
}

func isUserLogin() -> Bool
{
    let isUserLogin = getDataFromPreference(key: Preference.sharedInstance.IS_USER_LOGIN_KEY)
    return isUserLogin == nil ? false:(isUserLogin as! Bool)
}

func setLoginUserData(_ dictData: [String : Any])
{
    print(dictData)
    setDataToPreference(data: dictData as AnyObject, forKey: Preference.sharedInstance.USER_DATA_KEY)
    setIsUserLogin(isUserLogin: true)
}

func getLoginUserData() -> [String : Any]?
{
    if let data = getDataFromPreference(key: Preference.sharedInstance.USER_DATA_KEY)
    {
        return data as? [String : Any]
    }
    return nil
}

func setSyncTime(_ dictData: String)
{
    setDataToPreference(data: dictData as AnyObject, forKey: Preference.sharedInstance.USER_PARAMETER)
}

func getSyncTime() -> String
{
    if let data = getDataFromPreference(key: Preference.sharedInstance.USER_PARAMETER)
    {
        return (data as? String)!
    }
    return ""
}


func setDeviceToken(value: String)
{
    setDataToPreference(data: value as AnyObject, forKey: "push_device_token")
}

func getDeviceToken() -> String
{
    if let deviceToken = getDataFromPreference(key: "push_device_token")
    {
        return deviceToken as! String
    }
    return ""
}

func setUserLocation(_ latitude : Float, longitude : Float)
{
    setDataToPreference(data: latitude as AnyObject, forKey: Preference.sharedInstance.USER_LATITUDE_KEY)
    setDataToPreference(data: longitude as AnyObject, forKey: Preference.sharedInstance.USER_LONGITUDE_KEY)
}

func getUserLatitude() -> Float
{
    if let temp : Float = getDataFromPreference(key: Preference.sharedInstance.USER_LATITUDE_KEY) as? Float
    {
        return temp
    }
    return 0.0
}

func getUserLongitude() -> Float
{
    if let temp : Float = getDataFromPreference(key: Preference.sharedInstance.USER_LONGITUDE_KEY) as? Float
    {
        return temp
    }
    return 0.0
}

func setDefaultLanguage(_ lang: String)
{
    setDataToPreference(data: lang as AnyObject, forKey: Preference.sharedInstance.USER_DEFAULT_LANGUAGE)
}

func getDefaultLanguage() -> String
{
    if let lang : String = getDataFromPreference(key:  Preference.sharedInstance.USER_DEFAULT_LANGUAGE) as? String
    {
        return lang
    }
    return ""
}

func setCategoryList(arrValue : [[String : Any]])
{
    setDataToPreference(data: arrValue as AnyObject, forKey: "category_data")
}

func getCategortyList() -> [[String : Any]]
{
    if let data : [[String : Any]] = getDataFromPreference(key: "category_data") as? [[String : Any]]
    {
        return data
    }
    return [[String : Any]]()
}


func setHymnsList(arrValue : [[String : Any]])
{
    setDataToPreference(data: arrValue as AnyObject, forKey: "hymns_data")
}

func getHymnsList() -> [[String : Any]]
{
    if let data : [[String : Any]] = getDataFromPreference(key: "hymns_data") as? [[String : Any]]
    {
        return data
    }
    return [[String : Any]]()
}



func setFemaleOrganizationList(arrValue : [[String : Any]])
{
    setDataToPreference(data: arrValue as AnyObject, forKey: "organization_female_data")
}

func getFemaleOrganizationList() -> [[String : Any]]
{
    if let data : [[String : Any]] = getDataFromPreference(key: "organization_female_data") as? [[String : Any]]
    {
        return data
    }
    return [[String : Any]]()
}


//MARK: - Push notification device token
func setPushToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "PUSH_DEVICE_TOKEN")
}

func getPushToken() -> String
{
    if let token : String = getDataFromPreference(key: "PUSH_DEVICE_TOKEN") as? String
    {
        return token
    }
    return AppDelegate().sharedDelegate().getFCMToken()
}

