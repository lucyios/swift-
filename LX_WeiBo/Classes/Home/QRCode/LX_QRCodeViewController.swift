//
//  LX_QRCodeViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/28.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_QRCodeViewController: UIViewController {

    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    @IBOutlet weak var customTababr: UITabBar!
    @IBOutlet weak var customContainerView: UIView!
    @IBOutlet weak var scanLine: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1设置tabar默认选中
        customTababr.selectedItem = customTababr.items![0]
        customTababr.delegate = self
        //2执行冲击波动画
        startAnimation()
        
           }

    // MARK - 内部控制方法
    @IBAction func closeBtnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 冲击波动画
    private func startAnimation(){
        //让冲击波初始化到顶部
        scanLineCons.constant = -containerHeightCons.constant
        view.layoutIfNeeded()
        
        //重复执行
        
     UIView.animateWithDuration(1.0) { () -> Void in 
        UIView.setAnimationRepeatCount(MAXFLOAT)
        self.scanLineCons.constant = self.containerHeightCons.constant
        self.view.layoutIfNeeded()
        }
    }

}


extension LX_QRCodeViewController:UITabBarDelegate{
   
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //修改容器的高度
        containerHeightCons.constant = (item.tag == 0) ? 300 : 150
        
        view.layoutIfNeeded()
        
        //2.停止动画
        scanLine.layer.removeAllAnimations()
        
        //3重新开启动画
        startAnimation()
    }
}








