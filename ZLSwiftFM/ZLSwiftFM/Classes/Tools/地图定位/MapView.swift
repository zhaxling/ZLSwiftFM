//
//  MapView.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/28.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit
import MapKit

class MapView: MKMapView {

    var MERCATOR_OFFSET:Double {
        return 268435456.0
    }
    var MERCATOR_RADIUS:Double {
        return 85445659.44705395
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initial()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initial()
        fatalError("init(coder:) has not been implemented")
    }
    
    func initial() {
        self.showsUserLocation = true
        if #available(iOS 9.0, *) {
            self.showsScale = true
            self.showsCompass = true
            self.showsTraffic = false
        } else {
            // Fallback on earlier versions
        }
        
        self.mapType = .standard
        self.isZoomEnabled = true
    }
    
    // 设置地图中心 和 级别
    public func setCenterCoordinateLevel(centerCoordinate:CLLocationCoordinate2D, zoomLevel:Double,animated:Bool) {
        //设置最小缩放级别
        var zoomLevel = zoomLevel
        zoomLevel  = min(zoomLevel, 22)
        
        let span   = self.coordinateSpanWithMapView(mapView: self, centerCoordinate: centerCoordinate, zoomLevel: zoomLevel);
        let region = MKCoordinateRegionMake(centerCoordinate, span);
        
        self.setRegion(region, animated: animated)
        
    }
    
    func longitudeToPixelSpaceX(longitude:Double) ->Double {
        return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * Double.pi / 180.0)
    }
    
    func latitudeToPixelSpaceY(latitude:Double) ->Double {
        return round(MERCATOR_OFFSET - MERCATOR_RADIUS * log((1 + sin(latitude * Double.pi / 180.0)) / (1 - sin(latitude * Double.pi / 180.0))) / 2.0)
    }
    
    func pixelSpaceXToLongitude(pixelX:Double) ->Double {
        return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / Double.pi
    }
    
    func pixelSpaceYToLatitude(pixelY:Double) ->Double {
        return (Double.pi / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / Double.pi
    }
    
    func coordinateSpanWithMapView(mapView:MKMapView,
                                   centerCoordinate:CLLocationCoordinate2D,
                                   zoomLevel:Double) -> MKCoordinateSpan
    {
        let centerPixelX = self.longitudeToPixelSpaceX(longitude: centerCoordinate.longitude)
        let centerPixelY = self.latitudeToPixelSpaceY(latitude: centerCoordinate.latitude)
        let zoomExponent = 20.0 - zoomLevel
        let zoomScale = pow(2.0, zoomExponent)
        
        let mapSizeInPixels = mapView.bounds.size
        let scaledMapWidth  = Double(mapSizeInPixels.width) * zoomScale
        let scaledMapHeight = Double(mapSizeInPixels.height) * zoomScale
        
        let topLeftPixelX = centerPixelX - (scaledMapWidth/2)
        let topLeftPixelY = centerPixelY - (scaledMapHeight/2)
        
        let minLng = self.pixelSpaceXToLongitude(pixelX: topLeftPixelX)
        let maxLng = self.pixelSpaceXToLongitude(pixelX: topLeftPixelX + scaledMapWidth)
        let longitudeDelta = maxLng - minLng
        
        let minLat = self.pixelSpaceYToLatitude(pixelY: topLeftPixelY);
        let maxLat = self.pixelSpaceYToLatitude(pixelY: topLeftPixelY + scaledMapHeight);
        let latitudeDelta = -1 * (maxLat - minLat);
        
        let span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        return span
    }

}
