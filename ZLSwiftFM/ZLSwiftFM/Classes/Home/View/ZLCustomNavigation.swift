//
//  ZLCustomNavigation.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/17.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

let kNavHeight:CGFloat = 38


class ZLCustomNavigation: UIView {
    
    // 标题
    var titles:[String]?
    
    // 闭包用于回调事件
    var btnClickClosure:((_ index:Int)-> Void)?
    
    // 当前选择的按钮下标
    private var selectedIndex:Int = -1
    
    
    init(frame: CGRect, titles:[String], closure:@escaping (_ index:Int)->Void) {
        
        let rect = CGRect(x: 0.0, y: 64.0, width: kScreenWidth, height: kNavHeight)
        super.init(frame: rect)
        
        backgroundColor = UIColor.colorWithHexString(hex: "f6f6f6")
        //创建按钮
        self.titles = titles
        btnClickClosure = closure
        setupUI()
    }
    
    private func setupUI()  {
        
        customLog(NSStringFromCGRect(frame))
        
        let btnWidth = frame.size.width / CGFloat((titles?.count)!)
        
        for (index , title) in titles!.enumerated() {
            let btn = UIButton()
            btn.frame = CGRect(x: btnWidth * CGFloat(index) , y: 0.0, width: btnWidth, height: kNavHeight - 3)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.colorWithHexString(hex: "373737"), for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: WIDTH(14))
            btn.tag = index + 10
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            addSubview(btn)
        }
        
        // 添加线条
        addSubview(line)
        // 默认选择第一个按钮
        btnClick(viewWithTag(10) as! UIButton)
    }
    
    /// MARK:- 设置当前选中的标题
    func setTitleIndex(index:Int) {
        
        if selectedIndex == -1 {
            selectedIndex = 10
        }
        let selectedBtn = viewWithTag(selectedIndex) as! UIButton
        selectedBtn.setTitleColor(UIColor.colorWithHexString(hex: "373737"), for: .normal)
        selectedIndex = index + 10
        let btn = viewWithTag(10 + index) as! UIButton
        btn.setTitleColor(UIColor.red, for: .normal)
        
        //移动横线
        UIView.animate(withDuration: 0.4) {
            self.line.centerX = btn.centerX
        }
    }
    
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: kNavHeight - 3, width: 36, height: 3))
        line.backgroundColor = UIColor.red
        return line
    }()
    
    @objc private func btnClick(_ btn:UIButton) {
        customLog(btn.tag)
        
        // 如果点击的是选择的按钮
        if selectedIndex == btn.tag {
            return
        }
        
        if selectedIndex == -1 {
            selectedIndex = 10
        }
        
        let selectedBtn = viewWithTag(selectedIndex) as! UIButton
        selectedBtn.setTitleColor(UIColor.colorWithHexString(hex: "373737"), for: .normal)
        selectedIndex = btn.tag
        btn.setTitleColor(UIColor.red, for: .normal)
        
        //移动横线
        UIView.animate(withDuration: 0.4) {
            self.line.centerX = btn.centerX
        }
        
        if self.btnClickClosure != nil {
            self.btnClickClosure!(btn.tag - 10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
