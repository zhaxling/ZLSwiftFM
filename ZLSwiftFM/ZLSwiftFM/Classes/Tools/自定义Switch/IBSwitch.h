//
//  IBSwitch.h
//  TodayNews
//
//  Created by ZXL on 2017/2/23.
//  Copyright © 2017年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE的宏的功能就是让XCode动态渲染出该类图形化界面
// 这里可以利用key Path设置圆角,即可动态刷新我们的自定义View
IB_DESIGNABLE @interface IBSwitch : UIView

///IBInspectable就可以可视化显示相关的属性

/** 可视化设置边框宽度 */
@property (nonatomic ,assign) IBInspectable CGFloat borderWidth;

@end
