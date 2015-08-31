//
//  EmptyPromptView.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/25.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit

class EmptyPromptView: UIView {

    var imageView:UIImageView?
    var textLabel:UILabel?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    class func emptyPromptView()->EmptyPromptView{
        var view = EmptyPromptView()
        return view
    }

    override  init(frame: CGRect) {
        super.init(frame: frame)
        var emptyInfoView = UIImageView(image: UIImage(named: "icon_deal_empty")!)

        self.imageView = emptyInfoView
        self.textLabel = UILabel()
        self.textLabel?.text = "暂无此类团购"
        self.textLabel?.textAlignment = NSTextAlignment.Center
        self.textLabel?.frame.size = CGSizeMake(screenWidth, 20)
        self.textLabel?.textColor =  detailLabelColor
        self.addSubview(self.imageView!)
        self.addSubview(self.textLabel!)


    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = self.superview!.bounds
        println(self.superview?.center)
        self.imageView?.frame.size = CGSizeMake(self.imageView!.image!.size.width * 0.5, self.imageView!.image!.size.height * 0.5)
        self.imageView?.center = CGPointMake(screenWidth * 0.5, screenWidth * 0.5 - 44)
        self.textLabel?.frame.origin = CGPointMake(0, CGRectGetMaxY(self.imageView!.frame))
    }
}
