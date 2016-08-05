//
//  LX_UserAccout.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/5.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_UserAccout: NSObject,NSCoding {

    /**
     *  用于调用access_token,接口获取授权后的access token
     */
    var access_token:String?
    /**
     *  access_token的生命周期,单位是 秒
     */
    var expires_in:NSNumber?
    {
        didSet{
            expires_Date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
        }
    }
    
    /// 过期时间
    var expires_Date: NSDate?
    
    /**
     *  当前授权用户的ID
     */
    var uid:String?
    /**
     *  当前账户
     */
    static var userAccout: LX_UserAccout?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let property = ["access_token","expires_in","uid"];
        let dict = dictionaryWithValuesForKeys(property)
        return "\(dict)"
    }
    
    
//    static let filePath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("userAccout.plist")
    
    //优化创建路径
    static let filePath = "userAccout.plist".cacheDir()
    /**
     *  MARK - 外部控制方法
     */
    /**
     *  保存授权模型到文件中
     */
    func saveAccout() {
        
        /*
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        
        let filePath = (path as NSString).stringByAppendingPathComponent("userAccout.plist")
        */
        NSKeyedArchiver.archiveRootObject(self, toFile: LX_UserAccout.filePath)
        
        
    }
    
    //从文件中中读取保存的授权模型
    class func loadUserAccount() -> LX_UserAccout? {
//        return NSKeyedUnarchiver.unarchiveObjectWithFile(LX_UserAccout.filePath) as? LX_UserAccout
        
        //1.判断是否已经加载过了
        if userAccout != nil {
            LXLog("已经加载过了,直接返回")
            return userAccout
        }
        
        //2.没有加载过,就从文件中加载
        LXLog("从文件中加载")
        
        userAccout = NSKeyedUnarchiver.unarchiveObjectWithFile(LX_UserAccout.filePath) as? LX_UserAccout
        
        //3.判断是否股过期
        guard let date = userAccout?.expires_Date where date.compare(NSDate()) == NSComparisonResult.OrderedDescending  else
        {
            LXLog("已经过期了")
            userAccout = nil
            return userAccout
        }
        
        LXLog("没有过期\(userAccout)")
        
        return userAccout
    }
    
    //判断是否登陆
    class func login() -> Bool{
        return LX_UserAccout.loadUserAccount() != nil
    }
    
    
    /**
     *  MARK - NSCoding
     */
    //解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
        
    }
    
    //归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token,forKey: "access_token")
        aCoder.encodeObject(expires_in,forKey: "expires_in")
        aCoder.encodeObject(uid,forKey: "uid")
        aCoder.encodeObject(expires_Date,forKey: "expires_Date")
    }

    
}
