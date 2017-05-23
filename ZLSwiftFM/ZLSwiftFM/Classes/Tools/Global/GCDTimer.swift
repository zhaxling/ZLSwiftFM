//
//  GCDTimer.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/22.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

class GCDTimer: NSObject {
    
    // 计时频率 默认一秒
    let timerSeconds:Int = 1
    
    // 类方法创建对象
    class func timer() -> GCDTimer {
        return GCDTimer()
    }
    
    // 计时器：时间结束触发回调
    func calculateTime(seconds:Int,completion: @escaping(() -> ())) {
        // 定时需要计时的时间
        var timeCount = seconds
        
        // 创建计时器
        let codeTimer = createTimer()
        
        // 设定时间源的触发事件
        codeTimer.setEventHandler { 
            // 每秒计时一次
            timeCount = timeCount - self.timerSeconds
            // 时间到了取消时间源
            if timeCount <= 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    // 返回主线程处理一些事件
                    completion()
                }
            }
        }
    }
    
    /// 创建计时器
    private func createTimer() -> DispatchSourceTimer{
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(), queue: DispatchQueue.global())
        // 每秒执行
        codeTimer.scheduleRepeating(deadline: .now(), interval: .seconds(timerSeconds))
        return codeTimer
    }
    
    // 计时器：时间结束前每秒都有回调
    func calculateTimeBySeconds(seconds:Int,turnBack: @escaping((_ leftSeconds:Int) -> ())) {
        // 定时需要计时的时间
        var timeCount = seconds
        
        // 创建计时器
        let codeTimer = createTimer()
        
        // 设定时间源的触发事件
        codeTimer.setEventHandler {
            // 每秒计时一次
            timeCount = timeCount - self.timerSeconds
            // 时间到了取消时间源
            if timeCount <= 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    // 返回主线程处理一些事件
                    turnBack(0)
                }
            }
            else{
                
                DispatchQueue.main.async {
                    // 返回主线程处理一些事件
                    turnBack(timeCount)
                }
            }
        }
    }
}
