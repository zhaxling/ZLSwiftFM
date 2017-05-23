//
//  KobView.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/23.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

@IBDesignable class KobView: UIView {
    
    //默认Layer
    func defaultLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 2
        return layer
    }
    
    // 属性
    lazy var tickShapeLayer:CAShapeLayer = {
        let shapeLayer = self.defaultLayer()
        shapeLayer.path = self.tickPath.cgPath
        return shapeLayer
    }()
    lazy var xShapeLayer1:CAShapeLayer = {
        let shapeLayer = self.defaultLayer()
        shapeLayer.path = self.xPath1.cgPath
        return shapeLayer
    }()
    lazy var xShapeLayer2:CAShapeLayer = {
        let shapeLayer = self.defaultLayer()
        shapeLayer.path = self.xPath2.cgPath
        return shapeLayer
    }()
    
    lazy var dotPath:UIBezierPath = {
        let dotPath = UIBezierPath()
        dotPath.move(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.width/2))
        dotPath.addLine(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.width/2))
        return dotPath
    }()
    lazy var tickPath:UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.size.width/8 * 3, y: self.frame.size.width/2))
        path.addLine(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.width/8 * 5))
        path.addLine(to: CGPoint(x: self.frame.size.width/8 * 6, y: self.frame.size.width/8 * 3))
        return path
    }()
    lazy var xPath1:UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.size.width/9 * 6, y: self.frame.size.width/9 * 3))
        path.addLine(to: CGPoint(x: self.frame.size.width/9 * 3, y: self.frame.size.width/9 * 6))
        return path
    }()
    lazy var xPath2:UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.size.width/9 * 3, y: self.frame.size.width/9 * 3))
        path.addLine(to: CGPoint(x: self.frame.size.width/9 * 6, y: self.frame.size.width/9 * 6))
        return path
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化
    func initialize() {
        self.backgroundColor = UIColor.clear
        
        self.xShapeLayer1.isHidden = true
        self.xShapeLayer2.isHidden = true
        
        self.layer.addSublayer(self.tickShapeLayer)
        self.layer.addSublayer(self.xShapeLayer1)
        self.layer.addSublayer(self.xShapeLayer2)
        
    }
    
}
