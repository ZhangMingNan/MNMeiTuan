//
//  UIImageExtensions.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/16.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
extension UIImage{
    class func resizableImageWithName(name:String)->UIImage?{

        var originImage = UIImage(named: name)
        if let oimg = originImage {
            var w = oimg.size.width * 0.5
            var h = oimg.size.height * 0.5
            var newImage = originImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(h, w, h, w), resizingMode: UIImageResizingMode.Stretch)
            return newImage!
        }
        return  nil
    }
}