//
//  LX_NetWorkManger.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/5.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit
import AFNetworking


class LX_NetWorkManger: AFHTTPSessionManager {

    /**
     *  单例
     */
    static let shareInstance: LX_NetWorkManger = {
        // 注意: 指定BaseURL时一定要包含/
        let url = NSURL(string: "https://api.weibo.com/")
        let instance = LX_NetWorkManger(baseURL: url, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return instance
    }()
    
}
