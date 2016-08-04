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
    
    

    //打开相册
    @IBAction func photoBtnClick(sender: AnyObject) {
        //0.判断是否可以可以打开相册
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) else{
            return
        }
        
        //1.创建图片选择器
        let pickerVc = UIImagePickerController()
        pickerVc.delegate = self
        //2.弹出图片选择控制器
        presentViewController(pickerVc, animated: true, completion: nil)
        
        
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
        
        //添加二维码边线图层
        view.layer.insertSublayer(drawLayer, above: previewLayer)
        
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
//    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //创建输出,指定扫描范围
    private lazy var output: AVCaptureMetadataOutput = {
       let out = AVCaptureMetadataOutput()
        
        let rect = self.view.frame
        //容器视图的frame
        let containerRect = self.customContainerView.frame
        out.rectOfInterest = CGRect(x: containerRect.origin.y / rect.size.height, y: containerRect.origin.x / rect.size.width, width: containerRect.size.height / rect.size.height, height: containerRect.size.width / rect.size.width)
        
        return out
    }()
    
    ///创建会话
    private lazy var session: AVCaptureSession =  AVCaptureSession()
    ///创建预览图层
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
       let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = self.view.bounds
        return layer
    }()
    
    ///创建保存二维码边线的图层
    private lazy var drawLayer:CALayer = {
        let layer = CALayer()
        layer.frame = self.view.bounds
        return layer
        
    }()
    
}


// MARK: - UIImagePickerControllerDelegate

extension LX_QRCodeViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    /// 只要选中一张图片,就会调用这个代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
        // 1.取出当前选中的图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            LXLog("没有拿到图片")
            return
        }
        // 2.从图片中识别二维码数据
        // 2.1创建一个CIImage
        let ciImage = CIImage(image: image)!
        
        // 2.2创建一个探测器
        let dict = [CIDetectorAccuracy : CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: dict)
        
        // 2.3利用探测器检测结果
        let features = detector.featuresInImage(ciImage)
        
        for objc in features
        {
            resultLable.text = (objc as! CIQRCodeFeature).messageString
        }
        
        // 3.关闭图片选择器
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
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
        
        //每次扫描前清除之前的边线记录
        clearLines()
        
        // 1.遍历结果集
        for objc in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            
            //2.讲结果集中的对象中保存的corners坐标,转换为识别的坐标
            let res = previewLayer.transformedMetadataObjectForMetadataObject(objc)
            
            //3.绘制二维码边线
            drawLines(res as! AVMetadataMachineReadableCodeObject)
            
        }
    }
    
    private func drawLines(cornersObjc: AVMetadataMachineReadableCodeObject){
        
        //3.0 践行安全检验
        guard let corners = cornersObjc.corners else{
            LXLog("没有数据")
            return
        }
        
        //3.1创建CAShapeLayer
        let  shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.greenColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 4
        
        //3.2创建路径
        let path = UIBezierPath()
        
        //定义变量保存从corners取出来的结果
        var point: CGPoint = CGPointZero
        //定义变量,记录索引
        var index = 0
        
        //3.2.1移动到起点
        CGPointMakeWithDictionaryRepresentation((corners[index++] as! CFDictionary), &point)
        path.moveToPoint(point)
        
        //3.2.2连接到其他点
        while index < corners.count {
            CGPointMakeWithDictionaryRepresentation((corners[index++] as! CFDictionary), &point)
      
            path.addLineToPoint(point)
        }
        
        path.closePath()
        
        shapeLayer.path = path.CGPath
        
        //3.2.3将绘制好的图层添加到drawlayer
        drawLayer.addSublayer(shapeLayer)

    }
    
    /**
     清除二维码边线
     */
    private func clearLines(){
        //1.检查有没有子图层
        guard let subLayers = drawLayer.sublayers else{
            LXLog("没有自图层")
            return
        }
        
        //2.删除zi图层
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
        
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








