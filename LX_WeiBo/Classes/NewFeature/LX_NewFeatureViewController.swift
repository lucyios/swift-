//
//  LX_NewFeatureViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/6.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit
import SnapKit


class LX_NewFeatureViewController: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegate{

    let maxCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        // Do any additional setup after loading the view.
    }

  
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return maxCount
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewFeatureCellID", forIndexPath: indexPath) as! LXCollectionViewCell
        
        cell.index = indexPath.item
        
        cell.startButton.hidden = true
        return cell
        
    }
    
    // MARK - UICollectionViewDelegate
    /**
     * 当一个cell完全显示完就会调用
     */
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        //1.获取当前展现在眼前的cell对应的cell
        let path = collectionView.indexPathsForVisibleItems().last!
        
        //2.根据索引获取当前展现在眼前的cell 
        let cell = collectionView.cellForItemAtIndexPath(path) as! LXCollectionViewCell
        
        //3.判断是否是最后一页
        if path.item == maxCount - 1 {
            cell.startButton.hidden = false
            
            cell.startButton.userInteractionEnabled = false
            cell.startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
            
            //动画
            // usingSpringWithDamping 的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
            // initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快, 值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
            UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
                cell.startButton.transform = CGAffineTransformIdentity
                }, completion: { (_) in
                    cell.startButton.userInteractionEnabled = true
            })
        }
        
    }
    
    
}

class LXCollectionViewCell: UICollectionViewCell {
    
    //保存图片的索引
    var index: Int = 0
        {
        didSet{
            iconView.image = UIImage(named: "new_feature_\(index+1)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI(){
        //添加子控件
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        //布局子控件
//        iconView.translatesAutoresizingMaskIntoConstraints = false
//        
//        var cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[iconView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["iconView":iconView])
//        
//        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[iconView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["iconView": iconView])
//        contentView.addConstraints(cons)
        
        //框架
        iconView.snp_makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.top.equalTo(0)
//            make.bottom.equalTo(0)
            make.edges.equalTo(0)
        }
        
        startButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp_bottom).offset(-160)
        }
        
    }
    
    
    @objc private func startBtnClick(){
        LXLog("")
    }
    
    // MARK - 懒加载
    //大图容器
    private lazy var iconView = UIImageView()
    //开始按钮
    private lazy var startButton: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.addTarget(self, action: #selector(LXCollectionViewCell.startBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        
    }()
    
    
}

class LXFlowLayout: UICollectionViewFlowLayout {
    
    //准备布局
    override func prepareLayout() {
        super.prepareLayout()
        itemSize = collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        
    }
}


