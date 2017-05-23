//
//  IBSwitch.m
//  TodayNews
//
//  Created by ZXL on 2017/2/23.
//  Copyright © 2017年 zxl. All rights reserved.
//

#import "IBSwitch.h"

@implementation IBSwitch

/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

@end
