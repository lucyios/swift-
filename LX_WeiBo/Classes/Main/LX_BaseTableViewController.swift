
//
//  LX_BaseTableViewController.swift
//  LX_WeiBo
//
//  Created by 李lucy on 16/7/17.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

import UIKit

class LX_BaseTableViewController: UITableViewController {
    
    
    /**
     记录用户是否登录
     */
     var login: Bool = false
    
    //访客视图
    var visitorView: LX_VistorView?
    
    
    override func loadView() {
        super.loadView()
        login ? super.loadView() : setUpVisitorView()
    }


    //MARK - 内部控制方法
    private func setUpVisitorView(){
        
        //添加访客视图
        visitorView = LX_VistorView.visitorView()
        view = visitorView
        
        //监听按钮的点击事件
        visitorView?.registerButton.addTarget(self, action: Selector("registerBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        
        visitorView?.loginButton.addTarget(self, action: Selector("loginBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    
    @objc private func registerBtnClick(){
        LXLog("注册")
    }
    
    @objc private func loginBtnClick(){
        LXLog("登陆")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
