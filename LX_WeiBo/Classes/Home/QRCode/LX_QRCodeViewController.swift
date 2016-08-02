//
//  LX_QRCodeViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/28.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit
import AVFoundation


class LX_QRCodeViewController: UIViewController {

    /// 结果lable
    @IBOutlet weak var resultLable: UILabel!
    /// 冲击波顶部距离
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
        
        //3.开始扫描
        startScan()
        
        
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
    
    // MARK: - 开始扫描二维码
    private func startScan(){
        //1.判断输入能添加到会话中
        if !session.canAddInput(input) {
            return
        }
        //2.判断输出能否添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        
        //3.添加输入和输出
        session.addInput(input)
        session.addOutput(output)
        
        //4.告诉系统输出可以解析的数据类型
        //注意点:设置可以解析数据类型一定要在输出会话对象添加到会话之后设置,否则就会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        //5.设置代理监听解析结果
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        //6.添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //7.开始扫描
        session.startRunning()
    }
    
    // MARK: - 懒加载
    ///创建输入
    private lazy var input: AVCaptureDeviceInput? = {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            return try AVCaptureDeviceInput(device: device)
        } catch {
            print(error)
            return nil
        }
    }()
    
    ///创建输出
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    ///创建会话
    private lazy var session: AVCaptureSession =  AVCaptureSession()
    ///创建预览图层
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
       let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = self.view.bounds
        return layer
    }()
    
    
}


// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension LX_QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
  
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        /**
         *  ?? 的含义: 如果前面的值是nil,那么就返回后面的值,如果不为nil,那么??后面不执行
         */
        for object in metadataObjects {
            print(object)
        }
        resultLable.text = metadataObjects.last?.stringValue ?? "将二维码/条形码放入框中即可扫描";
    }
}

// MARK: - UITabBarDelegate
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








