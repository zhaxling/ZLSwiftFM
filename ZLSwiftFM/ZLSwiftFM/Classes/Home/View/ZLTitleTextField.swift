//
//  ZLTitleTextField.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/16.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class ZLTitleTextField: UITextField {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // leftView
        leftView = leftImageView
        leftViewMode = .always
        borderStyle = .roundedRect // 圆角固定
        font = UIFont.systemFont(ofSize: WIDTH(14))
        contentVerticalAlignment = .center
        layer.borderColor = UIColor.white.cgColor
    }
    
    lazy var leftImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        imageView.image = UIImage(named: "search_btn_norm")
        return imageView
    }()
    
    // leftView
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 8
        return rect
    }
    
    // 文字和输入框距离
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        //CGRectInset(bounds, 28, 0);
        return bounds.insetBy(dx: 28, dy: 0)
    }
    
    // 控制文本的位置
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 28, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
