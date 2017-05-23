////
////  ZXLAttributeLabel.swift
////  ZLSwiftFM
////
////  Created by ZXL on 2017/5/23.
////  Copyright © 2017年 zl. All rights reserved.
////
//
//import UIKit
//
//class ZXLAttributeLabel: UILabel {
//
//    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        
//        // 获取上下文 翻转坐标系
//        let context:CGContext = UIGraphicsGetCurrentContext()!
//        context.textMatrix = CGAffineTransform.identity
//        context.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: self.frame.size.height))
//        let content:NSMutableAttributedString = attributeDic()
//        
//        // 创建CFFrameSetterRef CTFrameRef
//        let frameSetter = CTFramesetterCreateWithAttributedString(content)
//        let paths = CGMutablePath()
//        paths.addRect(self.bounds)
//        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: content.length), paths, nil)
//        CTFrameDraw(frame, context)
//        
//        // 遍历 文本行 以及CTRunRef 将表情文本对应的表情图片绘制到图形上下文
//        let lines = CTFrameGetLines(frame)
//        var lineOrigins:[CGPoint]
//        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
//        for index in 0..<CFArrayGetCount(lines) {
//            let line = CFArrayGetValueAtIndex(lines, index)
//            let lineOrigin = lineOrigins[index]
//            
//            let runs = CTLineGetGlyphRuns(line as! CTLine)
//            
//            // 遍历字符数组
//            for index in 0..<CFArrayGetCount(runs) {
//                var runAscent:CGFloat
//                var runDescent:CGFloat
//                
//                let lineOrigin = lineOrigins[index]
//
//                let run = CFArrayGetValueAtIndex(runs, index)
//                var runRect:CGRect
//                runRect.size.width = CTRun<#T##leading: UnsafeMutablePointer<CGFloat>?##UnsafeMutablePointer<CGFloat>?#>GetTypographicBounds(<#T##run: CTRun##CTRun#>, <#T##range: CFRange##CFRange#>, <#T##ascent: UnsafeMutablePointer<CGFloat>?##UnsafeMutablePointer<CGFloat>?#>, <#T##descent: UnsafeMutablePointer<CGFloat>?##UnsafeMutablePointer<CGFloat>?#>, )
//                
//                
//                
//                
//            }
//            
//        }
//        
//        
//        
//        
//        
//        
//        
//    }
//    
//    
//    func attributeDic() -> NSMutableAttributedString {
//        
//        
//        return nil
//    }
//}
