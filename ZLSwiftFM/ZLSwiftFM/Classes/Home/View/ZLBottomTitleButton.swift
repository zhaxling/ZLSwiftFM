//
//  ZLBottomTitleButton.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/19.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class ZLBottomTitleButton: UIButton {

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        imageEdgeInsets = UIEdgeInsetsMake(0, 25, 30, 0)
        titleEdgeInsets = UIEdgeInsetsMake(35, -13, 0, 13)
    }
}
