//
//  AppDelegate.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

import AFNetworking

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //统一设置外观
        UITabBar.appearance().tintColor = UIColor.orangeColor()
//
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
     
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = LX_MainViewController()
        window?.makeKeyAndVisible()
        
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        window?.backgroundColor = UIColor.whiteColor()
//        let sb = UIStoryboard(name: "LX_WelcomeViewController", bundle: nil)
//        let newFeatureVC = sb.instantiateInitialViewController()!
//        
//        window?.rootViewController = newFeatureVC
//        window?.makeKeyAndVisible()
        
        return true
    }

  
}

/*
 自定义LOG的目的:
 在开发阶段自动显示LOG
 在发布阶段自动屏蔽LOG
 
 print(__FUNCTION__)  // 打印所在的方法
 print(__LINE__)     // 打印所在的行
 print(__FILE__)     // 打印所在文件的路径
 
 方法名称[行数]: 输出内容
 */
func LXLog<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(str)\(methodName)[\(lineNumber)]:\(message)")
    #endif
}


