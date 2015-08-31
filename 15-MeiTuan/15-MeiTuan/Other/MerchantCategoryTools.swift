//
//  MerchantCategoryTools.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/17.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher 
let findDealsUrl = "http://api.dianping.com/v1/deal/find_deals"

//根据选择条件查询团购数据
func findDeals(page:Int,searchParams:[SearchParam],action:(deals:[MerchantDeal])->Void){
    //api.dianping.com/v1/deal/find_deals?appkey=0676434442&sign=5F65337D827369986FA09BB49EEF3A4851806966&city=郑州&region=二七区&category=美食&page=1
         UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    var params:[String:AnyObject] = [String:AnyObject]()

    if let city = searchParams[1].conditions.first {
        params["city"] = city
    }else {
        params["city"] = "郑州"
    }
    if let region = searchParams[1].conditions.last {
         params["region"] = region
    }
    if let category = searchParams[0].conditions.first {
        params["category"] = category
    }
    params["page"] = page

    var keys = params.keys.array.sorted { (a, b) -> Bool in
        return a < b
    }
    var temp = "0676434442"
    for key in keys {
        temp += "\(key)\(params[key]!)"
    }
    temp += "f3dae78972b348bb9fac27b80affd729"

    params["appkey"] = "0676434442"
    params["sign"] = NSString(string:temp.sha1()).uppercaseString
    Alamofire.request(.GET, findDealsUrl, parameters: params)
        .responseJSON{ request, response, data, error in
            if let data: AnyObject = data {
                let json = JSON(data)

                var deals = json["deals"].arrayValue
                var list = [MerchantDeal]()
                for deal in deals {
                    var d  = MerchantDeal()
                    d.deal_id = deal["deal_id"].stringValue
                    d.title = deal["title"].stringValue
                    d.desc = deal["description"].stringValue
                    d.list_price = deal["list_price"].numberValue
                    d.current_price =  "人均" + deal["current_price"].stringValue + "元"
                    d.purchase_count = String(deal["purchase_count"].intValue) + "已购"
                    d.image_url = deal["image_url"].stringValue
                    d.s_image_url = deal["s_image_url"].stringValue
                    d.publish_date = deal["publish_date"].stringValue
                    var categories = deal["categories"].arrayValue
                    d.categorie = categories.first?.stringValue
                    d.distance = String(arc4random() % 50) + "KM"
                    d.region = "郑州"
                    list.append(d)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                action(deals:list)
            }
    }
}



//获取第三级筛选数据
func load()->DropDownModel{
    var arr = [MerchantCategory]()
    var conditions = ["智能排序","好评优先","离我最近","人均最低"]
    for condition in conditions {
        var cat = MerchantCategory()
        cat.name = condition
        arr.append(cat)
    }
    var model = DropDownModel()
    model.type = DropDownTableType.One
    model.categorys = arr
    return model
}



//加载城市数据
func loadCityData()->DropDownModel{
    var arr = [MerchantCategory]()
    var data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("cities", ofType: "json")!)

    if let data = data {
        var json = JSON(data:data)
        let list = json["cities"].arrayValue
        for i in 0..<list.count {
            var districts = list[i]["districts"]
            for dis in districts {
                // var name = dis["district_name"].stringValue
                var disName = dis.1["district_name"].stringValue
                var cat = MerchantCategory()
                cat.name = disName
                arr.append(cat)
                for r in dis.1["neighborhoods"].arrayValue {

                    var sub  = MerchantCategory()
                    sub.name = r.stringValue
                    cat.subcategories.append(sub)
                }
            }
        }

    }
    var model = DropDownModel()
    model.categorys = arr
    return model
}



//从JSON文件中加载数据模型对象.
func loadMerchantCategoryData()->DropDownModel{
    var arr = [MerchantCategory]()
    var data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("cate", ofType: "json")!)!
    var json = JSON(data:data)
    let list = json["categories"].arrayValue
    for i in 0..<list.count {
        var categorie = list[i]
        var cat = MerchantCategory()
        cat.icon = "icon_cate_normal_\(i)"
        cat.name = categorie["category_name"].stringValue
        cat.total = String(categorie["subcategories"].arrayValue.count)
        cat.type = CategoryType.Master
        arr.append(cat)
        for subCategorie in categorie["subcategories"].arrayValue {
            var sub  = MerchantCategory()
            sub.name = subCategorie["category_name"].stringValue
            sub.total = String(subCategorie["subcategories"].arrayValue.count)
            sub.type = CategoryType.Slave
            cat.subcategories.append(sub)
        }
    }
    var model = DropDownModel()
    model.categorys = arr
    return model
}
