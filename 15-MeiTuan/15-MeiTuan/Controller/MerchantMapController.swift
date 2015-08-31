//
//  MerchantMapController.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/25.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
import MapKit
class MerchantMapController: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate {

 
    var bmkView :BMKMapView!
    var locationService:BMKLocationService!

    /// 地理位置编码
    var geocodeSearch: BMKGeoCodeSearch!

    override func viewDidLoad() {
        super.viewDidLoad()

        //获取详细地址相关
        self.geocodeSearch = BMKGeoCodeSearch()
        self.geocodeSearch.delegate = self

        self.bmkView = BMKMapView(frame: self.view.bounds)
        self.bmkView.zoomLevel = 16
        self.view = bmkView
        //self.bmkView.mapType = UInt(BMKMapTypeSatellite)
        self.locationService = BMKLocationService()
        self.locationService.delegate = self
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyNearestTenMeters)
        BMKLocationService.setLocationDistanceFilter(100)
        self.locationService.startUserLocationService()
    }

    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
            println(">>")
            var district = result.addressDetail.district
            var streetName = result.addressDetail.streetName
            println("\(district)\(streetName)")
    }

    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        self.bmkView.centerCoordinate = userLocation.location.coordinate
        self.bmkView.showsUserLocation = false  //先关闭显示的定位图层
        self.bmkView.userTrackingMode = BMKUserTrackingModeNone  //设置定位的状态
        self.bmkView.showsUserLocation = true //显示定位图层
        self.bmkView.scrollEnabled = true  // 允许用户移动地图
        self.bmkView.updateLocationData(userLocation)  // 更新当前位置信息，强制刷新定位图层
        println(userLocation.location)

        //获取位置后进行反编码
       var lat =  userLocation.location.coordinate.latitude
        var lon =  userLocation.location.coordinate.longitude
        var point = CLLocationCoordinate2DMake(lat , lon)
        var unGeocodeSearchOption = BMKReverseGeoCodeOption()
        unGeocodeSearchOption.reverseGeoPoint = point
        var flag = geocodeSearch.reverseGeoCode(unGeocodeSearchOption)
        if flag {
            println("反 geo 检索发送成功")
        }else {
            println("反 geo 检索发送失败")
        }

    }
    override func viewDidAppear(animated: Bool) {
        // 添加一个PointAnnotation
        var annotation = BMKPointAnnotation()

    }

    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        // 生成重用标识 ID
        var annotationViewID = "'xidanMark"

        // 检查是否有重用的缓存
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationViewID)

        // 如果缓存没有命中，则自行构建一个标注
        if annotationView == nil {
            annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            (annotationView as! BMKPinAnnotationView).pinColor = UInt(BMKPinAnnotationColorGreen)
            // 设置从天上掉下来的效果
            (annotationView as! BMKPinAnnotationView).animatesDrop = false
            annotationView.image = UIImage(named: "icon_map_cateid_1")
        }
        // 设置位置
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5))
        annotationView.annotation = annotation
        // 单击弹出气泡，弹出气泡的前提是标注必须要实现 title 属性
        annotationView.canShowCallout = false
        // 设置是否可以拖拽
        annotationView.draggable = false

        return annotationView
    }

    override func viewWillAppear(animated: Bool) {
        self.bmkView.viewWillAppear()
        self.bmkView.delegate = self

    }
    override func viewWillDisappear(animated: Bool) {
        self.bmkView.viewWillDisappear()
        self.bmkView.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
