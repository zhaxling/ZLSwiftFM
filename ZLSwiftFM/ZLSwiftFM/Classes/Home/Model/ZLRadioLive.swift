//
//  ZLRadioLive.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/18.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit
import HandyJSON

class ZLRadioLive: HandyJSON {

    var playUrl:ZLRadioPlayurl?
    
    var coverSmall:String?
    
    var programName: String?
    
    var ID: Int = 0
    
    var programScheduleId: Int = 0
    
    var playCount: Int = 0
    
    var coverLarge: String?
    
    var fmUid: Int = 0
    
    var name: String?
    
    var programId: Int = 0
    
    
    // 必须写 init 方法
    required init() {}
}
