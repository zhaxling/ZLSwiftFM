//
//  SwitchAnimation.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/27.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

class SwitchAnimation: NSObject {

    var rect:CGRect? = nil
    
    
    // 点 -> 勾
    func animationDotToTick(values:Array<Any>) -> CAAnimationGroup{
        let lineAnimation = self.lineAnimation(keyTimes: [0,0.3], beginTime: 0, values: values)
        
        let scaleAnimation = self.transformAnimation()
        scaleAnimation.duration = 0.1
        scaleAnimation.beginTime = 0.2
        
        let lineGroup = CAAnimationGroup()
        lineGroup.animations = [lineAnimation,scaleAnimation]
        lineGroup.duration = 0.5
        lineGroup.repeatCount = 1
        lineGroup.isRemovedOnCompletion = false
        lineGroup.fillMode = kCAFillModeForwards
        lineGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return lineGroup
    }
    
    // 勾 -> 点
    func animationTickToDot(values:Array<Any>) -> CAAnimationGroup{
        let lineAnimation = self.lineAnimation(keyTimes: [0.1,0.4], beginTime: 0, values: values)
        
        let scaleAnimation = self.transformAnimation()
        scaleAnimation.duration = 0.05
        scaleAnimation.beginTime = 0
        
        let lineGroup = CAAnimationGroup()
        lineGroup.animations = [scaleAnimation,lineAnimation]
        lineGroup.duration = 0.5
        lineGroup.repeatCount = 1
        lineGroup.isRemovedOnCompletion = false
        lineGroup.fillMode = kCAFillModeForwards
        lineGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return lineGroup
    }
    
    // 点 -> X
    func animationDotToX(values:Array<Any> ,keyTimes:Array<NSNumber> ,duration:CGFloat) -> CAAnimationGroup{
        let lineAnimation = self.lineAnimation(keyTimes: keyTimes, beginTime: 0, values: values)
        lineAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let scaleAnimation = self.transformAnimation()
        scaleAnimation.duration = 0.1
        scaleAnimation.beginTime = (keyTimes.last as! CFTimeInterval) - 0.15
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let lineGroup = CAAnimationGroup()
        lineGroup.animations = [lineAnimation,scaleAnimation]
        lineGroup.duration = CFTimeInterval(duration)
        lineGroup.repeatCount = 1
        lineGroup.isRemovedOnCompletion = false
        lineGroup.fillMode = kCAFillModeForwards
        
        return lineGroup
    }
    
    // 点 -> X
    func animationXToDot(values:Array<Any> ,keyTimes:Array<NSNumber> ,duration:CGFloat) -> CAAnimationGroup{
        let lineAnimation = self.lineAnimation(keyTimes: keyTimes, beginTime: 0, values: values)
        lineAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let scaleAnimation = self.transformAnimation()
        scaleAnimation.duration = 0.1
        scaleAnimation.beginTime = 0
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let lineGroup = CAAnimationGroup()
        lineGroup.animations = [scaleAnimation,lineAnimation]
        lineGroup.duration = CFTimeInterval(duration)
        lineGroup.repeatCount = 1
        lineGroup.isRemovedOnCompletion = false
        lineGroup.fillMode = kCAFillModeForwards
        
        return lineGroup
    }
    
    func lineAnimation(keyTimes:Array<NSNumber>,beginTime:CGFloat,values:Array<Any>) -> CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.values = values
        animation.keyTimes = keyTimes as [NSNumber]?
        animation.beginTime = CFTimeInterval(beginTime)
        return animation
    }
    
    func transformAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform")
        
        var tr:CATransform3D = CATransform3DIdentity
        tr = CATransform3DTranslate(tr, (rect?.size.width)!/2, (rect?.size.height)!/2, 0)
        tr = CATransform3DScale(tr, 1.2, 1.2, 1)
        tr = CATransform3DTranslate(tr, -(rect?.size.width)!/2, -(rect?.size.height)!/2, 0)
        animation.toValue = NSValue(caTransform3D: tr)
        
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        return animation
    }
}
