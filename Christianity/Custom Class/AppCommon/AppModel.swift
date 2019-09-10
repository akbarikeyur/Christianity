//
//  AppModel.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//
import UIKit


class AppModel: NSObject {
    static let shared = AppModel()
    var currentUser : UserModel!
    
    
    
//    func getSentUserArrOfDictionary(arr:[UserModel]) -> [[String:Any]]{
//
//        let len:Int = arr.count
//        var retArr:[[String:Any]] =  [[String:Any]] ()
//        for i in 0..<len{
//            retArr.append(arr[i].dictionary())
//        }
//        return retArr
//    }

    func resetAllModel()
    {
        currentUser = UserModel.init()
       
    }
}



class UserModel : AppModel
{
    var uId : String!
    var name : String!
    var email : String!
    var v : Int!
    var device_token : String!
    
    
    override init(){
        uId = ""
        name = ""
        email = ""
        v = 0
        device_token = ""
      
        
    }
    
    init(dict : [String : Any])
    {
        uId = ""
        name = ""
        email = ""
        v = 0
        device_token = ""
        
        
        if let temp = dict["_id"] as? String {
            uId = temp
        }
        if let temp = dict["name"] as? String {
            name = temp
        }
        if let temp = dict["email"] as? String {
            email = temp
        }
        if let temp = dict["__v"] as? Int {
            v = temp
        }
        if let temp = dict["device_token"] as? String {
            device_token = temp
        }
       
    }
    
    func dictionary() -> [String:Any]  {
        return ["id":uId, "name":name, "email":email, "v":v , "device_token":device_token]
    }
    
    func toJson(_ dict:[String:Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
}
    
    class CategoryModel : AppModel
    {
        var id : String!
        var category : String!
        var categorygreece : String!
        var date : String!
        var v : Int!  // __v
        
        override init(){
            id = ""
            category = ""
            categorygreece = ""
            date = ""
            v = 0
        }
        
        init(dict : [String : Any])
        {
            id = ""
            category = ""
            categorygreece = ""
            date = ""
            v = 0
            
            
            if let temp = dict["_id"] as? String {
                id = temp
            }
            if let temp = dict["category"] as? String{
                category = temp
            }
            if let temp = dict["categorygreece"] as? String{
                categorygreece = temp
            }
            if let temp = dict["date"] as? String{
                date = temp
            }
            if let temp = dict["__v"] as? Int {
                v = temp
            }
            
        }
        
        func dictionary() -> [String:Any]  {
            return ["id":id, "category" : category, "categorygreece" : categorygreece, "date":date, "v" : v]
        }
    
}


class TrackModel : AppModel
{
    var date : String!
    var description1 : String!
    var link : String!
    var title : String!
  
    
    override init(){
        date = ""
        description1 = ""
        link = ""
        title = ""
       
    }
    
    init(dict : [String : Any])
    {
        date = ""
        description1 = ""
        link = ""
        title = ""
        
        
        if let temp = dict["description"] as? String {
            description1 = temp
        }
        if let temp = dict["link"] as? String {
            link = temp
        }
        if let temp = dict["title"] as? String {
            title = temp
        }
        if let temp = dict["date"] as? String {
            date = temp
        }
        
    }
    
    func dictionary() -> [String:Any]  {
        return ["description" : description1, "link" : link, "title" : title, "date" : date]
    }
    
}



class HymnsModel : AppModel
{
    var id : String!
    var cat : String!
    var title : String!
    var date : String!
    var v : Int!  // __v
    var body : String!
    var bodygreece : String!
    var catid : String!
    var number : String!
    
    
    
    override init(){
        id = ""
        cat = ""
        title = ""
        date = ""
        v = 0
        body = ""
        bodygreece = ""
        catid = ""
        number = ""
    }
    
    init(dict : [String : Any])
    {
        id = ""
        cat = ""
        title = ""
        date = ""
        v = 0
        body = ""
        bodygreece = ""
        catid = ""
        number = ""
        
        
        if let temp = dict["_id"] as? String {
            id = temp
        }
        if let temp = dict["cat"] as? String{
            cat = temp
        }
        if let temp = dict["title"] as? String{
            title = temp
        }
        if let temp = dict["date"] as? String{
            date = temp
        }
        if let temp = dict["__v"] as? Int {
            v = temp
        }
        if let temp = dict["body"] as? String{
            body = temp
        }
        if let temp = dict["bodygreece"] as? String{
            bodygreece = temp
        }
        if let temp = dict["catid"] as? String{
            catid = temp
        }
        if let temp = dict["number"] as? String {
            number = temp
        }
        
        
    }
    
    func dictionary() -> [String:Any]  {
        return ["id":id, "cat" : cat, "title" : title, "date":date, "v" : v, "body" : body, "bodygreece" : bodygreece, "catid":catid, "number" : number]
    }
    
}


class ScheduleModel : AppModel
{
    var id : String!
    var title : String!
    var body : String!
    var date : String!
    var person : String!
    var v : Int!  // __v
    var time : String!
    var formday : [String]!
    
    
    override init(){
        id = ""
        title = ""
        date = ""
        v = 0
        body = ""
        time = ""
        person = ""
        formday = [String]()
    }
    
    init(dict : [String : Any])
    {
        id = ""
        title = ""
        date = ""
        v = 0
        body = ""
        time = ""
        person = ""
        formday = [String]()
        
        
        if let temp = dict["_id"] as? String {
            id = temp
        }
        if let temp = dict["person"] as? String{
            person = temp
        }
        if let temp = dict["title"] as? String{
            title = temp
        }
        if let temp = dict["date"] as? String{
            date = temp
        }
        if let temp = dict["__v"] as? Int {
            v = temp
        }
        if let temp = dict["body"] as? String{
            body = temp
        }
        if let temp = dict["time"] as? String{
            time = temp
        }
        if let temp = dict["time"] as? String{
            time = temp
        }
        if let temp = dict["formday"] as? [String] {
            formday = temp
        }
        
        
    }
    
    func dictionary() -> [String:Any]  {
        return ["id":id, "person" : person, "title" : title, "date":date, "v" : v, "body" : body, "time" : time, "time":time, "formday" : formday]
    }
    
}


class NotificationModel : AppModel
{
    var id : String!
    var title : String!
    var body : String!
    var date : String!
    var v : Int!  // __v
    
    
    override init(){
        id = ""
        title = ""
        date = ""
        v = 0
        body = ""
        
    }
    
    init(dict : [String : Any])
    {
        id = ""
        title = ""
        date = ""
        v = 0
        body = ""
        
        
        if let temp = dict["_id"] as? String {
            id = temp
        }
        if let temp = dict["title"] as? String{
            title = temp
        }
        if let temp = dict["date"] as? String{
            date = temp
        }
        if let temp = dict["__v"] as? Int {
            v = temp
        }
        if let temp = dict["body"] as? String{
            body = temp
        }
    
        
    }
    
    func dictionary() -> [String:Any]  {
        return ["id":id, "title" : title, "date":date, "v" : v, "body" : body]
    }
    
}




