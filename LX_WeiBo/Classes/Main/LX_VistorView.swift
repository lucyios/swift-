//
//  LX_VistorView.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/17.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_VistorView: UIView {

    //转盘
    @IBOutlet weak var rotaionView: UIImageView!
    //标题
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    //大图标
    @IBOutlet weak var iconView: UIImageView!
    
    
    //MARK - 外部控制方法
    func setUpVistorInfo(imageName:String?,title: String?) {
        //首页
        guard let name = imageName else{
            startAnimation()
            return;
        }
        
        //其他界面
        iconView.image = UIImage(named: name)
        titleView.text = title
        rotaionView.hidden = true
        
    }
    
    /**
     *  快速创建方法
     */
    class func visitorView() -> LX_VistorView{
        return NSBundle.mainBundle().loadNibNamed("vistorView", owner: nil, options: nil).last as! LX_VistorView
    }
    
    /**
     *  动画背部控制方法
     */
    private func startAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 10.0
        anim.repeatCount = MAXFLOAT
        //告诉系统,不要随便移除动画,只有当控件销毁的时候,才需要移除
        anim.removedOnCompletion = false
        rotaionView.layer.addAnimation(anim, forKey: nil)
        
    }
}