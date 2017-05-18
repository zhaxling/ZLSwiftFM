//
//  XLTextView.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/21.
//  Copyright © 2017年 zxl. All rights reserved.
//  输入中文时限制字符长度

import UIKit

class XLTextView: UITextView {

}

extension XLTextView: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let toBeString = textView.text
        // 获取输入法
        let lang = textView.textInputMode?.primaryLanguage
        // 如果输入法为中文
        if lang == "zh-Hans" {
            // 这个range就是指输入的拼音还没有转化成中文是的range
            // 如果没有，就表示已经转成中文
            let selectedRange = textView.markedTextRange
            if selectedRange == nil && (toBeString?.characters.count)! > 5 {
                // 截取前5个字符
                let index = toBeString?.index((toBeString?.startIndex)!, offsetBy: 5)
                textView.text = toBeString?.substring(to: index!)
            }
        }
        else if (toBeString?.characters.count)! > 5{
            // 截取前5个字符
            let index = toBeString?.index((toBeString?.startIndex)!, offsetBy: 5)
            textView.text = toBeString?.substring(to: index!)
        }
    }
}
