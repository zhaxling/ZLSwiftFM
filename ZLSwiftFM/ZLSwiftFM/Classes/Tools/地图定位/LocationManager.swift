//
//  LocationManager.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/28.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    class func manager() -> LocationManager {
        return LocationManager()
    }
    
    var locationSuccess: ((_ location:CLLocation) -> ())? = nil
    var locationGeoSuccess: (([CLPlacemark]) -> ())? = nil
    
    
    // 地理编码
    lazy var coder: CLGeocoder = {
        let coder = CLGeocoder()
        return coder
    }()
    
    
    // 定位
    lazy var locManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    /// 获取用户地址
    func getUserLocation(success:@escaping (_ location:CLLocation) -> ()) {
        let statu = CLLocationManager.authorizationStatus()
        if !CLLocationManager.locationServicesEnabled() {
            customLog("定位服务当前可能尚未打开，请设置打开！")
            return
        }
        
        if statu == CLAuthorizationStatus.notDetermined ||
            statu == CLAuthorizationStatus.restricted ||
            statu == CLAuthorizationStatus.denied{
            customLog("定位权限： --- \(statu)")
            self.locManager.requestWhenInUseAuthorization()
        }else{
            
            self.locationSuccess = success
            
            self.locManager.startUpdatingLocation()
        }
    }
    
    func getUserGeoLocation(success:@escaping (_ location:CLLocation) -> () ,geoSuccess: @escaping ([CLPlacemark]) -> ()) {
        let statu = CLLocationManager.authorizationStatus()
        if !CLLocationManager.locationServicesEnabled() {
            customLog("定位服务当前可能尚未打开，请设置打开！")
            return
        }
        
        if statu == CLAuthorizationStatus.notDetermined ||
            statu == CLAuthorizationStatus.restricted ||
            statu == CLAuthorizationStatus.denied{
            customLog("定位权限： --- \(statu)")
            self.locManager.requestWhenInUseAuthorization()
        }else{
            
            self.locationSuccess = success
            self.locationGeoSuccess = geoSuccess
            
            self.locManager.startUpdatingLocation()
        }
    }
}


// @noescape 非逃逸闭包  函数结束后，这个闭包的生命周期也将结束
// @escaping 逃逸闭包
// @autoclosure 自动闭包

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        customLog("定位成功: --- \(locations)")
        if (self.locationSuccess != nil) {
            self.locationSuccess!(locations.last!)
        }
        self.locManager.stopUpdatingLocation()
        // 编码
        self.coder.reverseGeocodeLocation(locations.first!) { (placeMarks, error) in
            if (placeMarks?.first?.location?.coordinate) != nil{
                if self.locationGeoSuccess != nil{
                    self.locationGeoSuccess!(placeMarks!)
                }
                self.locManager.stopUpdatingLocation()
                
                //取得最后一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
//                let placemark:CLPlacemark = (placeMarks?.first)!
//                let location = placemark.location;//位置
//                let region = placemark.region;//区域
//                let addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
//                let name=placemark.name;//地名
//                let thoroughfare=placemark.thoroughfare;//街道
//                let subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
//                let locality=placemark.locality; // 城市
//                let subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
//                let administrativeArea=placemark.administrativeArea; // 州
//                let subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
//                let postalCode=placemark.postalCode; //邮编
//                let ISOcountryCode=placemark.isoCountryCode; //国家编码
//                let country=placemark.country; //国家
//                let inlandWater=placemark.inlandWater; //水源、湖泊
//                let ocean=placemark.ocean; // 海洋
//                let areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
//                print(location,region,addressDic)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        customLog("定位失败")
    }
}
