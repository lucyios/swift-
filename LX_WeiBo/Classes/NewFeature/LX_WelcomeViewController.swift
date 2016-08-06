//
//  LX_WelcomeViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/6.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_WelcomeViewController: UIViewController {

    @IBOutlet weak var headImgConsBottom: NSLayoutConstraint!
    @IBOutlet weak var welcomeLable: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let offset = view.bounds.height - headImgConsBottom.constant
        headImgConsBottom.constant =  offset
        
        LXLog(offset)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }) { (_) -> Void in
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.welcomeLable.alpha = 1.0
            })
        }
    }
   
}
