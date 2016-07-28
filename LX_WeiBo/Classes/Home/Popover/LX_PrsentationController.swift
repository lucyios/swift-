//
//  LX_PrsentationController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/27.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_PrsentationController: UIPresentationController {

    
    //记录菜单的尺寸
    var presenttedFrame = CGRectZero
    
    //布局被弹出的控制器
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        //containerView 容器视图(所有被展现的内容,都在容器视图上)
        //presentView   被展现的视图(当前就是弹出菜单控制器的view)

        
        //1.添加蒙版
        containerView?.insertSubview(cover, atIndex: 0)
        cover.frame = (containerView!.bounds)
        
        //2.修改被展现视图的尺寸
        presentedView()?.frame = presenttedFrame
        
        
    }
    
    //     MARK - 内部控制方法
    @objc private func coverClick(){
        //关闭菜单
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //  MARK - 懒加载
    private lazy var cover: UIView = {
        //创建蒙版
        let otherView = UIView()
        otherView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        
        //添加手势控制器
        let tap = UITapGestureRecognizer(target: self, action: Selector("coverClick"))
        otherView.addGestureRecognizer(tap)
        
        return otherView
        
        
    }()
}
