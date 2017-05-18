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
    
    
    // MARK:- 数据回调
    typealias AddClosure = ()->Void
    var updateClosure = AddClosure?()
    
}

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
