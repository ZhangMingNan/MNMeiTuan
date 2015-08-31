//
//  MerchantHeaderView.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/28.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit

class MerchantHeaderView: UIButton {

    var addressLabel:UILabel!
    var refreshBut:UIButton!

    var updataing = false{
        didSet{
            if updataing {
                self.setTitle("正在定位", forState:UIControlState.Normal)
            }
        }
    }
    var address:String?{
        didSet{
            if let address = address {
                var str = "当前: " + address
                self.setTitle(str, forState: UIControlState.Normal)
            }
        }
    }

    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.setBackgroundImage(UIImage.resizableImageWithName("bg_deallist_locate"), forState: UIControlState.Normal)
        self.setImage(UIImage(named: "icon_dellist_locate_refresh"), forState: UIControlState.Normal)
        self.titleLabel?.font =  UIFont.systemFontOfSize(12)
        self.setTitleColor( UIColor.grayColor(), forState: UIControlState.Normal)
    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(screenWidth - 16 - 9, 9, 16, 16)
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {

        return CGRectMake(9, 0,screenWidth,self.frame.size.height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
