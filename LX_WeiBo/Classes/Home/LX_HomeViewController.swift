

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
        
        if !login {
            visitorView?.setUpVistorInfo(nil, title: "")
            return
        }
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("friendBtnClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("qrcodeBtnClick"))

        
    }
    
    @objc private func friendBtnClick(){
    
        LXLog("pengyou")
    
    }
    
    @objc private func qrcodeBtnClick(){
        LXLog("扫一扫")
    }
    
    
    

 }
