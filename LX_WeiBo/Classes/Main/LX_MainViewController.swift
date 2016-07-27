//
//  LX_MainViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_MainViewController: UITabBarController {

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //0.添加自定义加号到tabbar
        tabBar.addSubview(plusButton)
        
        //1.计算按钮宽度
        let width = tabBar.bounds.width/CGFloat(childViewControllers.count)
        let height = plusButton.bounds.height
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        

        plusButton.frame = CGRectOffset(rect, 2*width, 0)
       
//        plusButton.center.x = tabBar.center.x


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
//        let homeVc = LX_HomeViewController()
//        homeVc.tabBarItem.image = UIImage.init(named: "tabbar_home")
//        homeVc.tabBarItem.selectedImage = UIImage.init(named: "tabbar_home_highlighted")
//        homeVc.tabBarItem.title = "首页"
//        
//        //包装导航控制器
//        let nav = UINavigationController(rootViewController: homeVc)
//        
//        addChildViewController(nav)
        
//        addChildViewcontroller("LX_HomeViewController", norImage: "tabbar_home", selImage: "tabbar_home_highlighted", title: "首页")
//        addChildViewcontroller("LX_MessageViewController", norImage: "tabbar_message_center", selImage: "tabbar_message_center_highlighted", title: "消息")
//        addChildViewcontroller("LX_DiscoverViewController", norImage: "tabbar_discover", selImage: "tabbar_discover_highlighted", title: "广场")
//        addChildViewcontroller("LX_ProfileViewController", norImage: "tabbar_profile", selImage: "tabbar_profile_highlighted", title: "我的")
        
    
        
        
        //动态加载控制器
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)!
        let data = NSData(contentsOfFile: path)!
        
        // throws是XCode7最大的变化, 异常处理机制
        // do catch的作用: 一旦方法抛出异常, 那么就会执行catch后面{}中的内容, 如果没有抛出异常, 那么catch后面{}中的内容不执行
        // try : 正常处理异常, 一旦有异常就执行catch
        // try!: 强制处理异常(忽略异常),也就是说告诉系统一定不会发生异常, 如果真的发生了异常, 那么程序会崩溃
        // try?: 忽略异常, 告诉系统可能有异常也可能没有异常, 如果发生异常返回值就是nil, 如果没有发生异常, 会将返回值包装为一个可选类型的值
        // 开发中推举使用try? 和 try , 不推荐使用try!
        
        guard let objc = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) else {
            LXLog("json文件中没有数据")
            //如果没有数据,就写死
            addChildViewcontroller("LX_HomeViewController", norImage: "tabbar_home", selImage: "tabbar_home_highlighted", title: "首页")
            addChildViewcontroller("LX_MessageViewController", norImage: "tabbar_message_center", selImage: "tabbar_message_center_highlighted", title: "消息")
            
            
            addChildViewcontroller("LX_NullViewController", norImage: "te", selImage: "test", title: "")
            addChildViewcontroller("LX_DiscoverViewController", norImage: "tabbar_discover", selImage: "tabbar_discover_highlighted", title: "广场")
            addChildViewcontroller("LX_ProfileViewController", norImage: "tabbar_profile", selImage: "tabbar_profile_highlighted", title: "我的")
            return
        }
        
        //根据json返回的数据加载控制器

        for dict in objc as! [[String: AnyObject]] {
            
            addChildViewcontroller(dict["vcName"] as! String, norImage: dict["norImage"] as! String, selImage: dict["selImage"] as! String, title: dict["title"] as! String)
        }
        
        
        
    }

    
//    func addChildViewcontroller(childVc: UIViewController,norImage: String,selImage: String,title: String)
    
    func addChildViewcontroller(childVcName: String,norImage: String,selImage: String,title: String) {
        
      //获取命名空间
       guard let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else
       {
        LXLog("没有获取到命名空间")
        return
        }
        
        //1.通过一个字符串创建一个类
         // 在Swift中, 如果想通过一个字符串创建一个类, 那么该类名必须包含命名空间名称
        let cls: AnyClass? = NSClassFromString(nameSpace + "." + childVcName)
        
        //2.通过一个Class创建一个对象
        // 在Swift中如果向通过一个AnyClass来创建一个对象, 必须先明确这个类的类型
        guard let vcCls = cls as? UITableViewController.Type else{
            LXLog("anyclass没有值")
            return
        }
        let childVc = vcCls.init()
        childVc.tabBarItem.image = UIImage(named: norImage)
        childVc.tabBarItem.selectedImage = UIImage(named: selImage)
//        childVc.tabBarItem.title = title
        childVc.title = title;
        //包装导航控制器
        let nav = UINavigationController(rootViewController: childVc)
        
        addChildViewController(nav)
 
 

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   @objc private func plusBtnClick(){
        LXLog("点击了加号")
    }
    
    // MARK: - 懒加载
    private lazy var plusButton: UIButton = {
      
//        let btn = UIButton()
//        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
//        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Selected)
//        
//        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal)
//        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Selected)

//        let btn = UIButton.creatButton("tabbar_compose_icon_add", backImage: "tabbar_compose_button") 
        let btn = UIButton(norImg: "tabbar_compose_icon_add", backImg: "tabbar_compose_button")
        btn.addTarget(self, action: #selector(LX_MainViewController.plusBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        btn.sizeToFit()
        return btn;
        
    }()

}
