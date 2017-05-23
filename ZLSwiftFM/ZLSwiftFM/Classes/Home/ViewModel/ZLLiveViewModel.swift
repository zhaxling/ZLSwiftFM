//
//  ZLLiveViewModel.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/18.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ZLLiveViewModel: NSObject {

    /// 位置
    var location:String?
    /// 分类
    var categories:Array<ZLLiveCategoryItem?> = []
    /// 本地广播
    var localRadios:Array<ZLRadioLive?> = []
    // top广播
    var topRadios:Array<ZLRadioLive?> = []
    // cell是否展开
    var isOpen:Bool = false
    
    
    
    // MARK:- 数据回调
    typealias AddClosure = ()->Void
    var updateClosure = AddClosure?()
    
}

// MARK:- 加载数据
extension ZLLiveViewModel{

    func refreshDataSource() {
        // url
        let url:String = "http://live.ximalaya.com/live-web/v4/homepage?device=iPhone"
        
        // 加载 直播数据（广播）数据
        HttpManager.share.getRequest(urlString: url, params: [:], success: { (result) in
            let json = JSON(result)
            
            self.location = json["data"]["location"].stringValue
            
            if let categories = JSONDeserializer<ZLLiveCategoryItem>.deserializeModelArrayFrom(json: json["data"]["categories"].description){
                self.categories = categories
            }
            
            if let localRadios = JSONDeserializer<ZLRadioLive>.deserializeModelArrayFrom(json: json["data"]["localRadios"].description) {
                self.localRadios = localRadios
            }
            
            if let topRadios = JSONDeserializer<ZLRadioLive>.deserializeModelArrayFrom(json: json["data"]["topRadios"].description) {
                self.topRadios = topRadios
            }
            
            // 更新tableView数据
            self.updateClosure?()
            
        }) { (error) in
            
        }
    }
}

// MARK:- 表格处理
extension ZLLiveViewModel{
    
    /// 行数
    func numberOfRowsIn(section:NSInteger) -> NSInteger {
        if section == 0 {
            return 1; // 电台
        }
        else if section == 1{
            return self.localRadios.count // 本地Section
        }
        else{
            // 榜单
            return topRadios.count < 3 ? 3 : topRadios.count
        }
    }
    
    /// 高度
    func heightForRowIn(indexPath:IndexPath) -> CGFloat {
        if indexPath.section == 0 { // 电台
            if isOpen {
                return 293
            } else {
                return 200
            }
        }
        else if indexPath.section == 1{
            return 85.0 // 本地Section
        }
        else{
            // 榜单
            return 85.0
        }
    }
    
    /// 头视图高度
    func heightForHeaderIn(section:NSInteger) -> CGFloat {
        if section == 0 {
            return 0.00001
        }
        else{
            return 40.0
        }
    }
    
    /// 脚视图高度
    func heightForFooterIn(section:NSInteger) -> CGFloat {
        return 10.0
    }
    
}
