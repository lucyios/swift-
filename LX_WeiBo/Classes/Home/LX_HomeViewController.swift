

//
//  LX_HomeViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_HomeViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.判断是否登陆
//        if !login {
//            visitorView?.setUpVistorInfo(nil, title: "")
//            return
//        }
        
     //        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("friendBtnClick"))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("qrcodeBtnClick"))
        
        //设置导航条
        setUpNavgationBar()
        
       
    }

    // MARK - 内部控制方法
    private func setUpNavgationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("friendBtnClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("qrcodeBtnClick"))
        
        let titleButton = LX_TitleBtn()
        titleButton.addTarget(self, action: #selector(LX_HomeViewController.titleBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleButton

    }
    
    @objc private func titleBtnClick(titleButton: UIButton)
    {
        //1. 切换按钮状态
        titleButton.selected = !titleButton.selected
        
        //2.创建菜单
        let sb = UIStoryboard(name: "LX_PopoverViewController", bundle: nil)
        let popoverVC = sb.instantiateInitialViewController()!
        
        
        //2.1设置专场代理
        popoverVC.transitioningDelegate = self
        
        //2.2设置转场样式
        popoverVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        //3.显示菜单
        
        presentViewController(popoverVC, animated: true, completion: nil)
        
    }

    @objc private func friendBtnClick(){
    
        LXLog("pengyou")
    
    }
    
    @objc private func qrcodeBtnClick(){
        LXLog("扫一扫")
    }
 

 }

extension LX_HomeViewController:UIViewControllerTransitioningDelegate{
    /**
     告诉系统谁来负责自定义转场
     
     - parameter presented:  被展现的控制
     - parameter presenting: 发起的控制器
     - parameter source:     source description
     
     - returns: return value description
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return LX_PrsentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}
