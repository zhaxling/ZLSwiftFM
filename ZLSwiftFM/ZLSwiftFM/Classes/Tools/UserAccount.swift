//
//  UserAccount.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/17.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class User: NSObject {
    
    
    ///是否登录
    var isLogin:Bool{
        get{
            let fileName = UserDefaults.standard.object(forKey: LoginUserId) as? String
            return fileName == nil ? false : true
        }
    }
    
}

let LoginUserId = "LoginUserId"

class UserAccount: NSObject,NSCoding {
    
    ///用户id
    var id:String?
    
    ///电话号码
    var telNum:String?
    
    ///用户登录密码
    var password:String?
    
    ///昵称
    var nickName:String?
    
    ///图标地址
    var iconUrl:String?
    
    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(telNum, forKey: "telNum")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(iconUrl, forKey: "iconUrl")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        id = aDecoder.decodeObject(forKey: "id") as? String
        telNum = aDecoder.decodeObject(forKey: "telNum") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        nickName = aDecoder.decodeObject(forKey: "nickName") as? String
        iconUrl = aDecoder.decodeObject(forKey: "iconUrl") as? String
        
    }
    
    @discardableResult
    func storeUserAccount() -> Bool {
        
        guard id != nil else {
            customLog("用户信息为空")
            return false
        }
        
        // 当前存的UserAccount对象是当前登录的用户对象
        UserDefaults.standard.set(id! + ".plist", forKey: LoginUserId)
        
        return NSKeyedArchiver.archiveRootObject(self, toFile: String.documentPath(with: id! + ".plist"))
    }
    
    static func getUserAccount() -> UserAccount{
        
        let fileName = UserDefaults.standard.object(forKey: LoginUserId) as? String
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: String.documentPath(with: fileName!)) as! UserAccount
    }
}

