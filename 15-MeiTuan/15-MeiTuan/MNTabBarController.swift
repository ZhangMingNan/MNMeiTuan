//
//  MNTabBarController.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/16.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
let mainColor = UIColor(red: 53/255, green: 182/255, blue: 158/255, alpha: 1)
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height
class MNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       // var homePage = HomePageController()
       // settingController(homePage, title: "团购", imageName: "homepage")
        var merchant  = MerchantController()
        settingController(merchant, title: "商家", imageName: "merchant")
        var mine = MineController()
        settingController(mine, title: "我的", imageName: "mine")
        var misc = MiscController()
        settingController(misc, title: "更多", imageName: "misc")


    }

    func settingController(controller:UIViewController,title:String,imageName:String){
        var item = UITabBarItem(title:title, image: UIImage(named: "icon_tabbar_\(imageName)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage:UIImage(named: "icon_tabbar_\(imageName)_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        var textAttrs = [NSForegroundColorAttributeName:UIColor.grayColor(),NSFontAttributeName:UIFont.systemFontOfSize(9.5)]
        var selectTextAttrs = [NSForegroundColorAttributeName:mainColor,NSFontAttributeName:UIFont.systemFontOfSize(9.5)]
        item.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
        item.setTitleTextAttributes(selectTextAttrs, forState: UIControlState.Selected)
        item.setTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -3))
        controller.tabBarItem = item
        self.addChildViewController(MTNavigationController(rootViewController: controller))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
