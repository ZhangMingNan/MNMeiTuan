
//
//  MerchantCategory.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/17.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
enum CategoryType:Int{
    case Master = 0
    case Slave = 1
}

enum DropDownTableType:Int{
    case One
    case Two
}

class SearchParam {
    //显示在dropdownBar上按钮的标题
    var title:String?
    //使用数组保存多级查询条件
    var conditions = [String]()
    init(title:String){
        self.title = title
    }
}
class DropDownModel {
    //这个下拉列表是 二级的 还是一级的.
    var type = DropDownTableType.Two
    var categorys:[MerchantCategory]?
}

class MerchantCategory: NSObject {
    var icon:String?
    var name:String?
    var total:String = ""
    var type:CategoryType?
    var subcategories = [MerchantCategory]()
}
class  SlaveCategoryFrame {
    var nameFrame:CGRect = CGRectZero
    var countFrame:CGRect = CGRectZero
    var cat:MerchantCategory?{
        didSet{
            if let cat = cat {
                if let  name = cat.name {
                    var nameSize = name.size(catNameFont, maxSize: CGSizeMake(CGFloat.max, 13))
                    self.nameFrame = CGRectMake(24, 15, nameSize.width, nameSize.height)
                    var countSize = cat.total.size(catCountFont, maxSize: CGSizeMake(CGFloat.max, 9))
                    self.countFrame = CGRectMake(screenWidth * 0.5 - 24 - countSize.width, 17, countSize.width, countSize.height)
                }
            }
        }
    }
}
class  MastreCategoryFrame {
    var iconFrame:CGRect = CGRectMake(13, 14, 19, 19)
    var nameFrame:CGRect = CGRectZero
    var countFrame:CGRect = CGRectZero
    var cat:MerchantCategory?{
        didSet{
            if let cat = cat {
                if let  name = cat.name {
                    var nameSize = name.size(catNameFont, maxSize: CGSizeMake(CGFloat.max, 13))
                    self.nameFrame =  CGRectMake(CGRectGetMaxX(self.iconFrame) + 7, 16,nameSize.width,nameSize.height)
                    var countTextSize = cat.total.size(catCountFont, maxSize:CGSizeMake(CGFloat.max, 9))
                    var countButSize = CGSizeMake(countTextSize.width + 10, 13)
                    self.countFrame = CGRectMake(screenWidth * 0.5 - 8 - countButSize.width, 16, countButSize.width, countButSize.height)
                }
            }
        }
    }
}




















