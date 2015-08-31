//
//  MiscController.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/16.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit

class MiscController: UIViewController {

    var webView:UIWebView?
    override func viewDidLoad() {
        self.webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView!)
        super.viewDidLoad()

        var req = NSURLRequest(URL: NSURL(string: "http://zhangbenbao.cn/2W3E4R5T/salesReport/chartsList")!)
        self.webView?.loadRequest(req)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
