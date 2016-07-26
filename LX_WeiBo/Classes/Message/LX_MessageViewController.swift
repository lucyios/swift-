
//
//  LX_MessageViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_MessageViewController: LX_BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !login
        {
            visitorView?.setUpVistorInfo("visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            return
        }

    }

  
    
}
