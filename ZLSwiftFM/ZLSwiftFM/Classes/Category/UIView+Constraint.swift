//
//  UIView+Constraint.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/14.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

extension UIView {
    
    private func disableTranslatesAutoresizingMaskIntoConstraints() {
        //  系统默认会给autoresizing 约束  关闭autoresizing 不关闭否则程序崩溃
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 下 右 上 左 (子视图和父视图)
    func addBottomConstraintToSuperView(constraint:CGFloat) {
        self.addBottomConstraintToView(toView: superview!, constraint: constraint)
    }
    
    func addRightConstraintToSuperView(constraint:CGFloat) {
        self.addRightConstraintToView(toView: superview!, constraint: constraint)
    }
    
    func addTopConstraintToSuperView(constraint:CGFloat) {
        self.addTopConstraintToView(toView: superview!, constraint: constraint)
    }
    
    func addLeftConstraintToSuperView(constraint:CGFloat) {
        self.addLeftConstraintToView(toView: superview!, constraint: constraint)
    }
    
    // 宽 高
    func addWidthConstraint(constraint:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let width:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0.0, constant: constraint)
        self.addConstraint(width)
    }
    
    func addHeightConstraint(constraint:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let height:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0.0, constant: constraint)
        self.addConstraint(height)
    }
    
    func addSizeConstraint(width:CGFloat ,height:CGFloat) {
        self.addWidthConstraint(constraint: width)
        self.addHeightConstraint(constraint: height)
    }
    
    // 下 右 上 左(约束和其他视图的关系)
    func addBottomConstraintToView(toView:UIView ,constraint:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let bottom:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -constraint)
        toView.addConstraint(bottom)
    }
    
    func addRightConstraintToView(toView:UIView ,constraint:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let right:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -constraint)
        toView.addConstraint(right)
    }
    
    func addTopConstraintToView(toView:UIView ,constraint:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let top:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: constraint)
        toView.addConstraint(top)
    }
    
    func addLeftConstraintToView(toView:UIView ,constraint:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let left:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: constraint)
        toView.addConstraint(left)
    }
    
    func addCenterXConstraintToView(toView:UIView ,offset:CGFloat) {
        self.disableTranslatesAutoresizingMaskIntoConstraints()
        let centerX:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: offset)
        toView.addConstraint(centerX)
    }
}
