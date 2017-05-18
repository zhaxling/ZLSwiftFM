//
//  AlertView.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/22.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit
import SnapKit

class AlertView: UIView {

    var contentLabel:UILabel! = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化
        self.backgroundColor = UIColor.black
        self.alpha = 0.8
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //  内容
        contentLabel.font = UIFont.systemFont(ofSize: WIDTH(15))
        contentLabel.textColor = UIColor.white
        contentLabel.textAlignment = NSTextAlignment.center
        contentLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail  //隐藏尾部并显示省略号
        contentLabel.sizeToFit()
        self.addSubview(contentLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        // 约束
        contentLabel.snp.makeConstraints { (make) in
            // 大坑：写成self.center 视图不显示
            make.center.equalTo(self)
        }
    }
}
