

//
//  LX_HomeViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_HomeViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.判断是否登陆
//        if !login {
//            visitorView?.setUpVistorInfo(nil, title: "")
//            return
//        }
        
        //2.设置导航条
        setUpNavgationBar()
        
        // 3.注册监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("titleBtnChange"), name: LXPopoverControllerShowClick, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("titleBtnChange"), name: LXPopoverControllerDismissClick, object: nil)
        
       
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK - 内部控制方法
    private func setUpNavgationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("friendBtnClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("qrcodeBtnClick"))
        
            navigationItem.titleView = titleButton

    }
    
    /// 控制标题按钮箭头的方向
    @objc private func titleBtnChange()
    {
        titleButton.selected = !titleButton.selected
    }

    
    /**
     监听标题按钮的点击
     */
    @objc private func titleBtnClick(titleButton: UIButton)
    {
        //1. 切换按钮状态
//        titleButton.selected = !titleButton.selected
        
        //2.创建菜单
        let sb = UIStoryboard(name: "LX_PopoverViewController", bundle: nil)
        let popoverVC = sb.instantiateInitialViewController()!
        
        
        //2.1设置专场代理
        popoverVC.transitioningDelegate = popoverManger
        
        //2.2设置转场样式
        popoverVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        //3.显示菜单
        
        presentViewController(popoverVC, animated: true, completion: nil)
        
    }

    @objc private func friendBtnClick(){
    
        LXLog("pengyou")
    
    }
    
    @objc private func qrcodeBtnClick(){
        LXLog("扫一扫")
    }
 

    // MARK - LAZY懒加载
    private lazy var titleButton: LX_TitleBtn = {
        let titleButton = LX_TitleBtn()
        titleButton.addTarget(self, action: #selector(LX_HomeViewController.titleBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return titleButton
    
    }()
    
    private lazy var popoverManger: LX_PopoverAnimationManget = {
       
        let manger = LX_PopoverAnimationManget()
        manger.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 400)
        return manger
        
    }()
    
    /// 记录当前是否是展现
//    private var isPresent = false
 }


//let LXPopoverControllerShowClick = "LXPopoverControllerShowClick"
//let LXPopoverControllerDismissClick = "LXPopoverControllerDismissClick"


//extension LX_HomeViewController:UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
//    /**
//     告诉系统谁来负责自定义转场
//     
//     - parameter presented:  被展现的控制
//     - parameter presenting: 发起的控制器
//     - parameter source:     source description
//     
//     - returns: return value description
//     */
//    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
//        
//        return LX_PrsentationController(presentedViewController: presented, presentingViewController: presenting)
//    }
//    
//    //告诉系统谁来负责展示样式
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresent = true
//        
//        NSNotificationCenter.defaultCenter().postNotificationName(LXPopoverControllerShowClick, object: self)
//        return self
//    }
//    /// 告诉系统谁来负责消失的样式
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
//        isPresent = false
//        NSNotificationCenter.defaultCenter().postNotificationName(LXPopoverControllerDismissClick, object: self)
//        return self
//    }
//
//    // MARK: - UIViewControllerAnimatedTransitioning
//    /// 该方法用于告诉系统展现或者消失动画的时长
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
//        return 0.5
//    }
//    /// 无论是展现还是消失都会调用这个方法
//    /// 我们需要在这个方法中告诉系统, 菜单如何展现
//    /// 注意点: 只要实现了这个方法, 那么系统就不会再管控制器如何弹出和消失了, 所有的操作都需要我们自己做
//    // transitionContext: 里面就包含了我们所有需要的参数
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
//        // 1.拿到菜单, 将菜单添加到容器视图上
//        if isPresent{
//            // 展现
//            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
//            transitionContext.containerView()?.addSubview(toView!)
//            
//            // 2.执行动画
//            toView?.transform = CGAffineTransformMakeScale(1.0, 0.0)
//            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                toView?.transform = CGAffineTransformIdentity
//            }) { (_) -> Void in
//                // 注意: 如果自定义转场动画, 那么必须告诉系统动画是否完成
//                transitionContext.completeTransition(true)
//            }
//        }else{
//            // 消失
//            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
//            // 注意: 以后如果使用CGFloat之后发现运行的结果和我们预期的结果不一致, 那么可以尝试修改CGFloat的值为一个很小的值
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.0000001)
//                }, completion: { (_) -> Void in
//                    // 注意: 如果自定义转场动画, 那么必须告诉系统动画是否完成
//                    transitionContext.completeTransition(true)
//            })
//            
//        }
//    }
//
//    
//    
//}
