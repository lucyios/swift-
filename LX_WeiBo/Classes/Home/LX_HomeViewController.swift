

//
//  LX_HomeViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_HomeViewController: LX_BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.判断是否登陆
        if !login {
            visitorView?.setUpVistorInfo(nil, title: "")
            return
        }
    
        //设置导航条
        setUpNavgationBar()
        
        let titleButton = LX_TitleBtn()
        titleButton.addTarget(self, action: #selector(LX_HomeViewController.titleBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleButton

        
    }
    
    // MARK - 内部控制方法
    private func setUpNavgationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("friendBtnClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("qrcodeBtnClick"))
    }
    
    @objc private func titleBtnClick(titleButton: UIButton)
    {
        // 切换按钮状态
        titleButton.selected = !titleButton.selected
    }

    @objc private func friendBtnClick(){
    
        LXLog("pengyou")
    
    }
    
    @objc private func qrcodeBtnClick(){
        LXLog("扫一扫")
    }
    
    
    

 }
