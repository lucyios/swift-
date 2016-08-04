
//
//  LX_OAuthViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/8/4.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_OAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.加载登录界面
        loadLoginPage()
       
    }

    /// MARK -内部控制方法
    @IBAction func blankInfoClick(sender: AnyObject) {
        
      //自定义填充账号密码
        let js = "document.getElementById('userId').value = '15229808502@qq.com';"
        webView.stringByEvaluatingJavaScriptFromString(js)
    }

    @IBAction func closeBtnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     *  MARK - 加载登陆界面
     */
    private func loadLoginPage(){
        let str = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APP_KEY)&redirect_uri=\(WB_REDIRECT_URI)"
        
        guard let url = NSURL(string: str) else{
            return
        }
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
        
    }
 
    
}
