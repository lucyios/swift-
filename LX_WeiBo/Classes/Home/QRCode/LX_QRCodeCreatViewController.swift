//
//  LX_QRCodeCreatViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/4.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_QRCodeCreatViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.创建滤镜对象
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        //2.恢复默认设置
        filter.setDefaults()
        //3.设置二维码数据
        let data = "李露鑫".dataUsingEncoding(NSUTF8StringEncoding)
        filter.setValue(data, forKey: "inputMessage")
        //4.从滤镜中取出二维码
        let ciImage = filter.outputImage!
        
        
//        let image = UIImage(CIImage: ciImage)
        
//        cardImageView.image = image

        //5.生成高清图片,并设置到容器上
        cardImageView.image = creatNonInterpolatedUIImageFromCIImage(ciImage, size: 200)
        
    }

    
    private func creatNonInterpolatedUIImageFromCIImage(image: CIImage,size:CGFloat) -> UIImage {
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent),size/CGRectGetHeight(extent))
        
        //1.创建bitmap
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext()
         let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef, CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale)
        
        CGContextDrawImage(bitmapRef, extent, bitmapImage)
        
        //2.保存bitmap到图片
        let scaledImage:CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
