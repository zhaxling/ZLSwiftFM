//
//  GradientSwitch.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/23.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

func colorFromRGBAlpha(rgb:Int,a:CGFloat) -> UIColor {
    return UIColor(red: ((CGFloat)((rgb >> 16) & 0xFF) / 255.0),
                   green: ((CGFloat)((rgb >> 8) & 0xFF) / 255.0),
                   blue: ((CGFloat)((rgb)&0xFF) / 255.0) ,
                   alpha: a)
}
func borderColor() -> UIColor {
    return colorFromRGBAlpha(rgb: 0x183937, a: 0.8)
}

//边距
fileprivate let Margin:CGFloat = 12
//Frame
fileprivate let SelfWidth:CGFloat = 80
fileprivate let SelfHeight:CGFloat = 38
fileprivate let KobMargin:CGFloat = SelfHeight / 12

fileprivate let kTickToDotAnimationKey = "kTickToDotAnimationKey"
fileprivate let kDotToTickAnimationKey = "kDotToTickAnimationKey"
fileprivate let kCrossToDotAnimationKey = "kCrossToDotAnimationKey"
fileprivate let kDotToCrossAnimationKey = "kDotToCrossAnimationKey"

//@IBDesignable 可在IB中使用
@IBDesignable class GradientSwitch: UIView {

    /// 设置开关状态
    var on:Bool = true {
        willSet (newOn) {
        
            let w:CGFloat = self.frame.size.height - KobMargin * 2
            let h:CGFloat = self.frame.size.height
            
            self.setKnob(isOn: newOn)
            
            if newOn {
                kobView.frame = CGRect(x: KobMargin, y: KobMargin, width: self.frame.size.width * 3, height: h)
                gradientView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width * 3, height: h)
            }
            else{
                kobView.frame = CGRect(x: self.frame.size.width - KobMargin - w, y: KobMargin, width: w, height: w)
                gradientView.frame = CGRect(x: -self.frame.size.width * 2, y: 0, width: self.frame.size.width * 3, height: h)
            }
        }
    }
    var isOn:Bool {
        // 只读属性(计算型属性)
        get {
            return on
        }
    }
    
    var action: ((Bool) -> ())? = nil
    
    //  边框
    let borderWidth:CGFloat = SelfHeight / 7
    lazy var borderLayer: CAShapeLayer = {
        let layer:CAShapeLayer = CAShapeLayer()
        
        let borderPath = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height),
                                           cornerRadius: self.frame.size.height * 0.5)
        layer.path = borderPath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = borderColor().cgColor
        layer.lineWidth = self.borderWidth
        
        return layer
    }()
    
    // 私有属性
    fileprivate let animationManager = SwitchAnimation()
    fileprivate var isAnimating = false

    ///初始化方法
    override init(frame: CGRect) {
        var myFrame = frame
        myFrame.size = CGSize(width: SelfWidth, height: SelfHeight)
        super.init(frame: myFrame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initialize(){
        //圆角
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height * 0.5
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(self.borderLayer)// 边框
        self.setupGradientView()
        
        // kob
        self.addSubview(self.kobView)
        
        // 动画
        let kobMargin = self.frame.size.height / 12
        animationManager.rect = CGRect(x: kobMargin, y: kobMargin, width: self.frame.size.height - kobMargin * 2, height: self.frame.size.height - kobMargin * 2)
    }
    
    // Kob
    lazy var kobView: KobView = {
        let w = self.frame.size.height - KobMargin * 2
        let kobView = KobView(frame: CGRect(x: KobMargin, y: KobMargin, width: w, height: w))
        return kobView
    }()
    
    // GradientView
    var gradientView:UIView = UIView()
    private func setupGradientView() {
        
        let offColor1 = colorFromRGBAlpha(rgb: 0xef9c29, a: 1)
        let offColor2 = colorFromRGBAlpha(rgb: 0xe76b39, a: 1)
        
        let onColor1 = colorFromRGBAlpha(rgb: 0x08ded6, a: 1)
        let onColor2 = colorFromRGBAlpha(rgb: 0x18deb9, a: 1)
        
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width * 3, height: self.frame.size.height))
        gradientView.backgroundColor = UIColor.clear
        let gradientLayer = self.setupGradientLayer(colors: [onColor1.cgColor,onColor2.cgColor,offColor1.cgColor,offColor2.cgColor],
                                                    toWidth: self.frame.size.width * 3)
        gradientView.layer.addSublayer(gradientLayer)
        self.gradientView = gradientView
        self.addSubview(gradientView)
    }
    
    func setupGradientLayer(colors:Array<Any>,toWidth:CGFloat) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0,0.33,0.63,1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: toWidth, height: self.frame.size.height)
        
        return gradientLayer
    }

    // 开关
    func set(on:Bool,animated:Bool) {
        // 相同状态不做处理
        if self.isOn == on { return}
        
        if animated {
            if on {
                // 打开动画
                self.onAnimation()
            }
            else{
                // 关闭动画
                self.offAnimation()
            }
        }else{
            self.on = on
        }
        
    }
    
    // ✔️ ❌
    func setKnob(isOn:Bool) {
        if isOn {
            self.kobView.tickShapeLayer.isHidden = false
            self.kobView.xShapeLayer1.isHidden = true
            self.kobView.xShapeLayer2.isHidden = true
        }
        else{
            self.kobView.tickShapeLayer.isHidden = true
            self.kobView.xShapeLayer1.isHidden = false
            self.kobView.xShapeLayer2.isHidden = false
        }
    }
    
    /// 打开动画
    private func onAnimation() {
        isAnimating = true
        
        self.setKnob(isOn: false)
        let w = self.frame.size.height - KobMargin * 2
        
        let tickAnimationGroup = self.animationManager.animationDotToTick(values: [self.kobView.dotPath.cgPath,self.kobView.tickPath.cgPath])
        tickAnimationGroup.delegate = self
        
        let crossAnimationGroup1 = self.animationManager.animationXToDot(values: [self.kobView.xPath1.cgPath,self.kobView.dotPath.cgPath], keyTimes: [0,0.3], duration: 0.5)
        
        let crossAnimationGroup2 = self.animationManager.animationXToDot(values: [self.kobView.xPath2.cgPath,self.kobView.dotPath.cgPath], keyTimes: [0.05,0.35], duration: 0.55)
        
        self.kobView.xShapeLayer1.add(crossAnimationGroup1, forKey: kCrossToDotAnimationKey)
        self.kobView.xShapeLayer2.add(crossAnimationGroup2, forKey: kCrossToDotAnimationKey)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.1, options: .calculationModePaced, animations: {
            self.kobView.frame = CGRect(x: KobMargin, y: KobMargin, width: w, height: w)
            self.gradientView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width * 3, height: self.frame.size.height)
        }) { (finished) in
            self.setKnob(isOn: true)
            self.kobView.tickShapeLayer.add(tickAnimationGroup, forKey: kDotToTickAnimationKey)
        }
        
        
    }
    
    /// 关闭动画
    private func offAnimation() {
        isAnimating = true
        
        self.setKnob(isOn: true)
        let w = self.frame.size.height - KobMargin * 2
        
        
        let tickAnimationGroup = animationManager.animationTickToDot(values: [kobView.tickPath.cgPath,kobView.dotPath.cgPath])
        
        let crossAnimationGroup1 = animationManager.animationDotToX(values: [kobView.dotPath.cgPath,kobView.xPath1.cgPath], keyTimes: [0.05,0.35], duration: 0.55)
        
        let crossAnimationGroup2 = animationManager.animationDotToX(values: [kobView.dotPath.cgPath,kobView.xPath2.cgPath], keyTimes: [0,0.3], duration: 0.5)
        
        crossAnimationGroup2.delegate = self
        
        self.kobView.tickShapeLayer.add(tickAnimationGroup, forKey: kTickToDotAnimationKey)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.1, options: .calculationModePaced, animations: {
            self.kobView.frame = CGRect(x: self.frame.size.width - KobMargin - w, y: KobMargin, width: w, height: w)
            self.gradientView.frame = CGRect(x: -self.frame.size.width * 2, y: 0, width: self.frame.size.width * 3, height: self.frame.size.height)
        }) { (finished) in
            self.setKnob(isOn: false)
            self.kobView.xShapeLayer1.add(crossAnimationGroup1, forKey: kDotToCrossAnimationKey)
            self.kobView.xShapeLayer2.add(crossAnimationGroup2, forKey: kDotToCrossAnimationKey)
        }
        
    }
    
    // 没有动画
    func setUnAnimation() {
        
    }
    
    // MARK: 触摸事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !isAnimating {
            if isOn {
               self.offAnimation()
            }
            else{
                self.onAnimation()
            }
        }
    }
    
}

extension GradientSwitch: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if (anim == self.kobView.xShapeLayer2.animation(forKey: kDotToCrossAnimationKey)) {
                isAnimating = false
                on = false
            }
            else if(anim == self.kobView.tickShapeLayer.animation(forKey: kDotToTickAnimationKey)){
                isAnimating = false
                on = true
            }
            if (self.action != nil) {
                self.action!(self.isOn)
            }
        }
    }
}
