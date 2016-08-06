//
//  LX_NewFeatureViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/6.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_NewFeatureViewController: UIViewController, UICollectionViewDataSource {

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
        return cell
        
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
        //布局子控件
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        var cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[iconView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["iconView":iconView])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[iconView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["iconView": iconView])
        contentView.addConstraints(cons)
        
    }
    
    // MARK - 懒加载
    private lazy var iconView = UIImageView()
    
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












