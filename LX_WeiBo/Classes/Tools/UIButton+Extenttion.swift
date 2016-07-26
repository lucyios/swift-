//
//  UIButton+Extenttion.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/17.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

extension UIButton{
    
    
    //func  ---->  OC 对象方法
    //class func ---->  OC 类方法
    
    /*
    //垃圾代码
    class func creatButton(norImage:String,backImage:String) -> UIButton{
        let btn = UIButton()
        btn.setImage(UIImage(named:norImage), forState: UIControlState.Normal)
        btn.setImage(UIImage(named:norImage+"_hightlighted"), forState: UIControlState.Selected)

        btn.setBackgroundImage(UIImage(named:backImage), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named:backImage+"_highlighted"), forState: UIControlState.Selected)

        return btn
    }
 */
    
    // 只要在构造方法前面加上convenience单词, 那么这就是一个便利构造方法
    // 便利构造方法: 仅仅是对原有构造方法的扩充, 主要是为了方便创建对象
    /*
     指定构造方法: init(xxx:xxx)
     1.必须调用"父类"super.init()初始化
     2.默认情况下系统会自动帮调用(编译器隐式的帮我们自动添加了一行super.init())
     便利构造方法: convenience init(xxx:xxx)
     1.必须调用"当前类"的指定构造方法
     2.不能调用super.init()
     3.也可以调用其他的便利构造方法, 但是其它构造方法中必须调用本类的指定构造方法
     */

    convenience init(norImg: String,backImg: String){
        self.init()
        setImage(UIImage(named: norImg), forState: UIControlState.Normal)
        setImage(UIImage(named: norImg+"_heightlighted"), forState: UIControlState.Selected)
        setBackgroundImage(UIImage(named: backImg), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backImg+"_highlighted"), forState: UIControlState.Selected)
        sizeToFit()
            
    }
}
