//
//  String+Extension.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/17.
//  Copyright © 2017年 zl. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 判断手机号是否合法
    static func isValidmobile(_ string: String) -> Bool {
        // 判断是否是手机号
        let patternString = "^1[3|4|5|7|8][0-9]\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", patternString)
        return predicate.evaluate(with: string)
    }
    
    /// 判断密码是否合法
    static func isValidPasswod(_ string: String) -> Bool {
        // 验证密码是 6 - 16 位字母或数字
        let patternString = "^[0-9A-Za-z]{6,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", patternString)
        return predicate.evaluate(with: string)
    }
    
    // MARK:- 获取字符串的CGSize
    func getSize(with fontSize: CGFloat) -> CGSize {
        let str = self as NSString
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    
}
