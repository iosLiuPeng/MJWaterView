//
//  MJWaterView.h
//  MJWaterView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//  水波视图

#import <UIKit/UIKit.h>

@interface MJWaterView : UIView
@property (nonatomic, assign) IBInspectable CGFloat height;     ///< 浪高
@property (nonatomic, assign) IBInspectable CGFloat topSpace;   ///< 波浪距顶部间隙

@property (nonatomic, assign) IBInspectable CGFloat cycle;      ///< 周期 (显示几个周期，1为半个周期）
@property (nonatomic, assign) IBInspectable CGFloat earlyCycle; ///< 初相（初始偏移周期距离，1为半个周期）
@property (nonatomic, assign) IBInspectable CGFloat speed;      ///< 速度 (波浪移动的快慢，1为半个周期）

@property (nonatomic, strong) IBInspectable UIColor *fillColor; ///< 填充色（水波颜色）
@end
