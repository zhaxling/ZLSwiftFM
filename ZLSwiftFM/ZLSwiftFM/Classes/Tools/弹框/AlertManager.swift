//
//  AlertManager.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/22.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

class AlertManager: NSObject {
    
    // 单例
    static let manager = AlertManager()
    
    // 是否弹出
    var isAlerted:Bool = false
    
    // 弹框 普通
    func alert(content:String) {
        // 创建视图
        let kW:CGFloat = WIDTH(189)
        let kH:CGFloat = HEIGHT(56)
        
        let alertView = AlertView(frame: CGRect(x: (kScreenWidth - kW) * 0.5, y: (kScreenHeight + kH) * 0.4, width: kW, height: kH))
        alertView.contentLabel?.text = content
        alertView.addSubview(alertView.contentLabel!)
        
        if !isAlerted {
            // 添加到窗口
            let window = UIApplication.shared.delegate?.window
            window??.addSubview(alertView)
            isAlerted = true
        }
        
        // 开启动画
        UIView.animate(withDuration: 1.6, animations: {
            alertView.alpha = alertView.alpha - 0.1
        }) { (finished) in
            if finished {
                self.isAlerted = false
                alertView.removeFromSuperview()
            }
        }
    }
}
