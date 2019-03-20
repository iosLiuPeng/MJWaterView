//
//  MJWaterView.h
//  MJWaterView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//  水波视图

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MJWaterView : UIView
@property (nonatomic, assign) IBInspectable CGFloat height;     ///< 浪高
@property (nonatomic, assign) IBInspectable CGFloat topSpace;   ///< 波浪距顶部间隙

/*
 周期长度模式:
 NO: 通用的180个点为一个周期的长度（不论当前多宽，都是180个点长度为一整个周期）
 YES: 以当前视图的宽度为一个周期长度（始终都是以当前视图的宽度为一整个周期）
 
 这个值会影响后面的三个与周期相关的属性
 */
@property (nonatomic, assign) IBInspectable BOOL widthOneCycle; ///< 周期长度模式

@property (nonatomic, assign) IBInspectable CGFloat cycle;      ///< 周期 (显示几个周期，1为1个周期）
@property (nonatomic, assign) IBInspectable CGFloat earlyCycle; ///< 初相（初始偏移周期距离，1为1个周期）
@property (nonatomic, assign) IBInspectable CGFloat speed;      ///< 速度 (4秒内移动的周期数，1为1个周期）

@property (nonatomic, strong) IBInspectable UIColor *fillColor; ///< 填充色（水波颜色）

/// 开始、继续（默认自动开始）
- (void)startAnimation;

/// 暂停
- (void)pauseAnimation;
@end
