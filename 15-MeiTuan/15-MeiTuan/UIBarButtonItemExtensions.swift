//
//  UITabBarExtensions.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/16.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    class func initItem(target:NSObject, action:Selector,imageName:String)->UIBarButtonItem{
        var button = UIButton()
        button.setBackgroundImage(UIImage(named:imageName), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.frame.size = button.currentBackgroundImage!.size
        return UIBarButtonItem(customView: button)
    }
}
