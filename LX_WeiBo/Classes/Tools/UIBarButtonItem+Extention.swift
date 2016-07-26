//
//  UIBarButtonItem+Extention.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/27.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit


extension UIBarButtonItem
{
    convenience init(imageName: String, target: AnyObject, action: Selector) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
}

//extension UIBarButtonItem
//{
//    
//    convenience init(imageName:String,target:AnyObject,action:Selector)
//    {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
//        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
//        
//        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
//        btn.sizeToFit()
//      //什么意思
//        self.init(customView: btn)
//        
//    }
//    
//}