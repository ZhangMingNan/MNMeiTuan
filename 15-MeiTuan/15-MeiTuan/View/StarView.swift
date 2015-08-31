//
//  StarView.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/23.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit

class StarView: UIView {

    var starImageList = [UIImageView]()

    var score:Float = 0.0{
        didSet{

            for starImage in self.starImageList {
                starImage.image = UIImage(named: "icon_merchant_rating_star_not_picked")
            }


            if score % 1 == 0.5 {
                var picked = Int(score - 0.5)
                for i in 0..<picked  {
                    self.starImageList[i].image = UIImage(named: "icon_merchant_rating_star_picked")
                }
                self.starImageList[picked].image = UIImage(named: "icon_merchant_rating_star_half")
            }else if score % 1 == 0 {
                for i in 0..<Int(score)  {
                    self.starImageList[i].image = UIImage(named: "icon_merchant_rating_star_picked")
                }
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        for i in 0..<self.subviews.count {
            var star = self.subviews[i] as! UIImageView
            star.frame = CGRectMake(CGFloat(i) * 12, 0, 12, 12)
        }
    }
    class func startView()->StarView{
        var with:CGFloat = 5 * 24 + 3 * 4
        var view = StarView(frame: CGRectMake(0, 0, with, 12))
        return view
    }
    override  init(frame: CGRect) {
        super.init(frame: frame)
        //frame是固定的宽度
        for i in 0..<5 {
            var star = UIImageView(image: UIImage(named: "icon_merchant_rating_star_not_picked"))
            self.addSubview(star)
            self.starImageList.append(star)
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
