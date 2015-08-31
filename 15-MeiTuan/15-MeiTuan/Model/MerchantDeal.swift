//
//  MerchantDeal.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/21.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit

class MerchantDeal: NSObject {
    var deal_id:String?
    var title:String?
    var desc:String?
    var list_price:NSNumber = 0
    var current_price:String?
    var purchase_count:String?
    var image_url:String?
    var s_image_url:String?
    var publish_date:String?
    
    var categorie:String?
    var region:String?
    //距离
    var distance:String?
}

let dealTitleFont:CGFloat = 16
let startListWith:CGFloat = 75
let detailFont:CGFloat = 12
class MerchantDealFrame {
    let icon:CGRect = CGRectMake(10, 8, 90, 72)
    var title:CGRect = CGRectZero
    var cat:CGRect = CGRectZero
    var region:CGRect = CGRectZero
    var startView:CGRect = CGRectZero
    var purchaseCount:CGRect = CGRectZero
    var price:CGRect = CGRectZero
    var distance:CGRect = CGRectZero
    var deal:MerchantDeal?{
        didSet{
            if let deal = deal {
                var titleSize = deal.title!.size(UIFont.systemFontOfSize(dealTitleFont), maxSize: CGSizeMake(160, dealTitleFont))
                self.title = CGRectMake(CGRectGetMaxX(self.icon) + 10 , 13,titleSize.width, titleSize.height)
                self.startView = CGRectMake(self.title.origin.x, CGRectGetMaxY(self.title)+8, startListWith, 14)
                var purchaseSize = String(stringInterpolationSegment: deal.purchase_count).size(UIFont.systemFontOfSize(detailFont), maxSize: CGSizeMake(CGFloat.max, detailFont))
                self.purchaseCount = CGRectMake(CGRectGetMaxX(self.startView), self.startView.origin.y, purchaseSize.width, purchaseSize.height)
                var priceSize = deal.current_price!.size(UIFont.systemFontOfSize(detailFont), maxSize: CGSizeMake(CGFloat.max, detailFont))
                self.price = CGRectMake(screenWidth - 10 - priceSize.width,self.startView.origin.y, priceSize.width, priceSize.height)
                var catSize = deal.categorie?.size(UIFont.systemFontOfSize(detailFont), maxSize: CGSizeMake(CGFloat.max, detailFont))
                self.cat = CGRectMake(self.title.origin.x, CGRectGetMaxY(self.startView) + 8, catSize!.width, catSize!.height)
                var regionSize = deal.region?.size(UIFont.systemFontOfSize(detailFont), maxSize: CGSizeMake(CGFloat.max, detailFont))
                self.region = CGRectMake(CGRectGetMaxX(self.cat) + 5, self.cat.origin.y, regionSize!.width, regionSize!.height)
                var distanceSize = deal.distance?.size(UIFont.systemFontOfSize(detailFont), maxSize: CGSizeMake(CGFloat.max, detailFont))
                self.distance = CGRectMake(screenWidth - distanceSize!.width - 10, self.cat.origin.y, distanceSize!.width, distanceSize!.height)
            }
        }
    }
}