//
//  MerchantSegmented.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/16.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
enum SelectType:Int{
    case left = 0
    case right = 1
}
protocol MerchantSegmentedDelegate{
    func switchButton(type:SelectType)
}
class MerchantSegmented: UIView {

    var butW:CGFloat?
    var leftButton:UIButton?
    var rightButton:UIButton?
    var delegate:MerchantSegmentedDelegate?
    //0 选中左侧按钮, 1 选中右侧按钮
    var currentSelected:SelectType = SelectType.left{
        didSet{
            if currentSelected == .right {
                self.leftButton?.selected = false
                self.rightButton?.selected = true
                self.leftButton?.setTitleColor(mainColor, forState: UIControlState.Normal)
                self.rightButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            }else if currentSelected == .left {
        self.leftButton?.selected = true
        self.rightButton?.selected = false
        self.leftButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.rightButton?.setTitleColor(mainColor, forState: UIControlState.Normal)
        }
        }
    }
    var butTitles:(left:String,right:String)?{
        didSet{
            self.leftButton?.setTitle(butTitles!.left, forState: UIControlState.Normal)
            self.rightButton?.setTitle(butTitles!.right, forState: UIControlState.Normal)
        }
    }

    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.butW = self.width() * 0.5

        self.leftButton =  UIButton(frame: CGRectMake(0, 0,self.butW!, frame.height))
        self.rightButton = UIButton(frame: CGRectMake(self.butW!,0, self.butW!,  frame.height))
        self.leftButton?.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.rightButton?.titleLabel?.font =  UIFont.systemFontOfSize(13)
        self.leftButton?.userInteractionEnabled = false
        self.rightButton?.userInteractionEnabled = false
        self.leftButton!.setBackgroundImage(UIImage.resizableImageWithName("btn_segmentedcontrol_left_normal"), forState: UIControlState.Normal)
        self.leftButton!.setBackgroundImage(UIImage.resizableImageWithName("btn_segmentedcontrol_left_selected"), forState: UIControlState.Selected)
        self.rightButton!.setBackgroundImage(UIImage.resizableImageWithName("btn_segmentedcontrol_right_normal"), forState: UIControlState.Normal)
        self.rightButton!.setBackgroundImage(UIImage.resizableImageWithName("btn_segmentedcontrol_right_selected"), forState: UIControlState.Selected)
        self.addSubview(self.leftButton!)
        self.addSubview(self.rightButton!)

        self.leftButton?.selected = true
        self.rightButton?.setTitleColor(mainColor, forState: UIControlState.Normal)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapBut:"))

    }

    func tapBut(tap:UITapGestureRecognizer){
       var location =  tap.locationInView(self)
        if CGRectContainsPoint(leftButton!.frame, location){

            self.currentSelected = .left
        }else if CGRectContainsPoint(rightButton!.frame, location) {

            self.currentSelected = .right
        }
        //调用代理方法
        self.delegate?.switchButton(self.currentSelected)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
