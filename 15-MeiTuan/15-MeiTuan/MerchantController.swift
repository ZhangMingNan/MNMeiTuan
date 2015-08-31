//
//  MerchantController.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/16.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit

class MerchantController: UIViewController,MerchantSegmentedDelegate,DropDownBarDelegate,UITableViewDelegate,UITableViewDataSource ,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate{

   // var dataList = [MerchantDeal]()
    var dataList = [MerchantDealFrame]()
    var tableView:UITableView?

    var emptyView:EmptyPromptView?

    var locationService:BMKLocationService!

    /// 地理位置编码
    var geocodeSearch: BMKGeoCodeSearch!

    var headerView:MerchantHeaderView!


    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        var lat =  userLocation.location.coordinate.latitude
        var lon =  userLocation.location.coordinate.longitude
        var point = CLLocationCoordinate2DMake(lat , lon)
        var unGeocodeSearchOption = BMKReverseGeoCodeOption()
        unGeocodeSearchOption.reverseGeoPoint = point
        var flag = self.geocodeSearch.reverseGeoCode(unGeocodeSearchOption)
        if flag {
            println("反 geo 检索发送成功")
        }else {
            println("反 geo 检索发送失败")
        }
    }
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        println(">>")
        var district = result.addressDetail.district
        var streetName = result.addressDetail.streetName
        self.headerView.address = "\(district)\(streetName)"
        self.locationService.stopUserLocationService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

    self.navigationController?.navigationBar.setBackgroundImage(UIImage.resizableImageWithName("bg_navigationBar_white"), forBarMetrics: UIBarMetrics.Default)

        //设置左侧地图按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.initItem(self, action: "mapButClick:", imageName: "icon_map")
        //设置右侧放大镜
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.initItem(self, action: "searchButClick:", imageName: "icon_search")

        //设置中间的选项卡
        var seg = MerchantSegmented(frame: CGRectMake(0, 0, 164, 27))
        seg.butTitles = ("全部商家","优惠商家")
        seg.delegate = self
        self.navigationItem.titleView = seg
        //设置View不穿过导航控制器.
        self.navigationController?.navigationBar.translucent = false

        var dropDownBar = DropDownBar(frame: CGRectMake(0,0,screenWidth, 41))

        self.tableView = UITableView(frame:CGRectMake(0, CGRectGetMaxY(dropDownBar.frame), screenWidth,self.view.height() - CGRectGetMaxY(dropDownBar.frame)))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView?.rowHeight = 92

        self.view.addSubview(self.tableView!)
        //设置DropDownBar
        dropDownBar.delegate = self
        self.view.addSubview(dropDownBar)

        self.emptyView = EmptyPromptView.emptyPromptView()
        self.emptyView?.hidden = true
        self.tableView?.addSubview(self.emptyView!)


        self.headerView = MerchantHeaderView(frame: CGRectMake(0, 0, screenWidth, 34))
        self.tableView?.tableHeaderView = self.headerView

        self.geocodeSearch = BMKGeoCodeSearch()
        self.geocodeSearch.delegate = self
        self.locationService = BMKLocationService()
        self.locationService.delegate = self
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyNearestTenMeters)
        BMKLocationService.setLocationDistanceFilter(10)
        self.locationService.startUserLocationService()

        self.headerView.updataing = true

        self.headerView.addTarget(self, action: "refreshLocate", forControlEvents: UIControlEvents.TouchUpInside)




        var sp1 = SearchParam(title: "")
        sp1.conditions = ["郑州"]
        var sp0 = SearchParam(title: "")
        sp0.conditions = ["美食","川菜"]
        selectedCell([sp0,sp1])
    }

    func refreshLocate(){
        self.locationService.startUserLocationService()
        self.headerView.updataing = true
    }

    func switchButton(type: SelectType) {

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = MerchantDealCell.cellWithTableView(tableView)
        cell.dealFrame = self.dataList[indexPath.row]

        return cell
    }
    func selectedCell(searchParams: [SearchParam]) {
        findDeals(1,searchParams, { (deals) -> Void in
           // self.dataList = deals
            var  dealFrameList = [MerchantDealFrame]()
            for d in deals {
                var df = MerchantDealFrame()
                df.deal = d
               dealFrameList.append(df)
            }
            self.dataList = dealFrameList
            self.tableView?.reloadData()
            if self.dataList.count == 0 {
                self.emptyView?.hidden = false
            }else {
                self.emptyView?.hidden = true
            }
        })
    }

    func mapButClick(but:UIButton){
        self.presentViewController(MerchantMapController(), animated: true, completion: nil)
    }
    func searchButClick(but:UIButton){
        println(but)
    }
}
