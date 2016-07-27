//
//  LX_TitleBtn.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/27.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_TitleBtn: UIButton {
    
    //通过代码创建会调用
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        adjustsImageWhenHighlighted = false
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        setTitle("lucy", forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        sizeToFit()
    }
    
    
    //通过SB或者xib会调用
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    
    override func layoutSubviews() {
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width
        
    }
    

}
