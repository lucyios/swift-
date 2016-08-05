
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


extension LX_OAuthViewController:UIWebViewDelegate{
    /**
     webview每次请求一个新的地址都会调用该方法,返回true,代表允许访问,否则不允许访问
     
     - parameter webView:        webView description
     - parameter request:        request description
     - parameter navigationType: navigationType description
     
     - returns: return value description
     */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
       
        LXLog(request.URL)

        //1.判断是否是授权回调地址,如果不是,就允许继续跳转
        guard let urlStr = request.URL?.absoluteString where urlStr.hasPrefix(WB_REDIRECT_URI) else{
            
            LXLog("api.weibo.com")
            return true
        }
        
        //2.判断授权是否成功
        let code = "code="
        guard urlStr.containsString(code) else{
            LXLog("error_url")
            return false
        }
 
        //3.授权成功
        if let temp = request.URL?.query {
            //截取code=后面的字符串
            let codeStr  = temp.substringFromIndex(code.endIndex)
            LXLog("授权成功"+codeStr)
            
            //利用requestoken换取Accesstoken
            loadAccesstoken(codeStr)
        }
        
        return false

    }
    
    private func loadAccesstoken(codeStr: String){
        let path = "oauth2/access_token"
        let parameters = ["client_id": WB_APP_KEY, "client_secret": WB_APP_SECRET, "grant_type": "authorization_code", "code": codeStr, "redirect_uri": WB_REDIRECT_URI]
       
        LX_NetWorkManger.shareInstance.POST(path, parameters: parameters, success: { (task, objc) in
            
            /**
             *  LX_OAuthViewController.loadAccesstoken[102]:Optional({
             "access_token" = "2.00AN9m8G0Zra8Jf93d6d77e48u_OZB";
             "expires_in" = 150493;
             "remind_in" = 150493;
             uid = 5907306246;
             })
             */
            LXLog(objc)
            }) { (task, error) in
                LXLog(error)
        }
    }
}
