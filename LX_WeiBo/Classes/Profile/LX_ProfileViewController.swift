
//
//  LX_ProfileViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_ProfileViewController: LX_BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if !login
        {
            visitorView?.setUpVistorInfo("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }

    }

    
}
