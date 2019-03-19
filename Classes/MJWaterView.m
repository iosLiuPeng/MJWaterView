//
//  MJWaterView.m
//  MJWaterView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//

#import "MJWaterView.h"

@interface MJWaterView ()
@property (nonatomic, assign) CGFloat offset;   ///< 偏移

@property (nonatomic, strong) CAShapeLayer *waveLayer;  ///< layer
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;///< 计时器
@end

@implementation MJWaterView
#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self startAnimation];
    }
    return self;
}

#pragma mark - Get & Set
/// 填充色
- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    
    self.waveLayer.fillColor = fillColor.CGColor;
}

/// 图层
- (CAShapeLayer *)waveLayer {
    if (!_waveLayer) {
        _waveLayer =  [CAShapeLayer layer];
        [self.layer addSublayer:_waveLayer];
    }
    return _waveLayer;
}

/// 计时器
- (CADisplayLink *)waveDisplaylink {
    if (!_waveDisplaylink) {
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWave)];
    }
    return _waveDisplaylink;
}

#pragma mark - Life Circle


- (void)dealloc {
    [self.waveDisplaylink invalidate];
    [self.waveDisplaylink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Public
/// 开始、继续
- (void)startAnimation {
    if (_waveDisplaylink) {
        [self.waveDisplaylink setPaused:NO];
    } else {
        [self.waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

/// 暂停
- (void)pauseAnimation {
    [self.waveDisplaylink setPaused:YES];
}

#pragma mark - Private
/// 绘制波浪
- (void)drawWave
{
    CGFloat width = self.bounds.size.width;     //整体宽
    CGFloat height = self.bounds.size.height;   //整体高
    
    //计算偏移
    _offset += _speed * (M_PI / 180.0);
    // 初始偏移
    CGFloat earlyOffset = _earlyCycle * (M_PI / 180.0) * width;
    // 周期
    CGFloat cycle = _cycle * (M_PI / 180.0);
    
    //路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    
    CGFloat y = 0.0f;
    
    //计算每个点，加到路径中
    for (CGFloat x = 0; x <= width; x++) {
        y = _height * sinf(cycle * x + _offset + earlyOffset) + self.topSpace;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, width, height);
    CGPathAddLineToPoint(path, nil, 0, height);
    CGPathCloseSubpath(path);
    
    self.waveLayer.path = path;
    CGPathRelease(path);
}

@end
