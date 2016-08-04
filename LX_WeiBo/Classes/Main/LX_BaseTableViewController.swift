
//
//  LX_BaseTableViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/17.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_BaseTableViewController: UITableViewController {
    
    
    /**
     记录用户是否登录
     */
     var login: Bool = false
    
    //访客视图
    var visitorView: LX_VistorView?
    
    
    
    override func loadView() {
        super.loadView()
        login ? super.loadView() : setUpVisitorView()
    }

    //MARK - 内部控制方法
    private func setUpVisitorView(){
        
        //1添加访客视图
        visitorView = LX_VistorView.visitorView()
        view = visitorView
        
        //2监听按钮的点击事件
        visitorView?.registerButton.addTarget(self, action: #selector(LX_BaseTableViewController.registerBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        visitorView?.loginButton.addTarget(self, action: #selector(LX_BaseTableViewController.loginBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
       
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //3.添加导航条按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LX_BaseTableViewController.registerBtnClick));
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LX_BaseTableViewController.loginBtnClick))
        
        

    }
    
    @objc private func registerBtnClick(){
        LXLog("注册")
        
        //创建登陆界面
        let sb = UIStoryboard.init(name: "LX_OAuthViewController", bundle: nil)
        
        let outhVc = sb.instantiateInitialViewController()!
        
        presentViewController(outhVc, animated: true, completion: nil)
        
    }
    
    @objc private func loginBtnClick(){
        LXLog("登陆")
    }

}
