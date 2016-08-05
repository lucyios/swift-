//
//  String+Extentiton.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/5.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit


extension String{
    
    /**
     *  快速返回一个文档目录路径
     */
    func docDir() -> String {
        let docPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        return (docPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
    }
    
    /**
     *  快速返回一个缓存目录的路径
     */
    func cacheDir() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        
        return (cachePath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
        
    }
    
    /**
     *  快速返回临时目录的路劲
     */
    func tmpDir() -> String {
        let temPath = NSTemporaryDirectory()
        return (temPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
        
    }
    
    
}