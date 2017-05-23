//
//  ZLIconListView.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/19.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class ZLIconListView: UIView {
    
    var titles:Array = [String]()
    var icons:Array = [String]()
    
    init(frame:CGRect, titles:Array<String>, icons:Array<String>) {
        super.init(frame: frame)
        
        self.titles = titles
        self.icons = icons
        
        let width = frame.size.width / CGFloat(titles.count)
        for (index,value) in titles.enumerated() {
            let btn = UIButton(frame: CGRect(x: width * CGFloat(index), y: 8, width: width, height: 80))
            
            btn.setTitle(value, for: .normal)
            btn.setImage(UIImage(named:icons[index]), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: WIDTH(15))
            btn.setTitleColor(UIColor.black, for: .normal)
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 30, 0)
            btn.titleEdgeInsets = UIEdgeInsetsMake(35, -13, 0, 13)
            
            addSubview(btn)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
