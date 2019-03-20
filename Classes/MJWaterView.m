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
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;///< 计时器
@end

@implementation MJWaterView
#pragma mark - Life Circle
+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWave)];
    [self startAnimation];
}

- (void)dealloc {
    [_waveDisplaylink invalidate];
    [_waveDisplaylink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Public
/// 开始、继续
- (void)startAnimation {
    if (_waveDisplaylink.paused == YES) {
        [_waveDisplaylink setPaused:NO];
    } else {
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

/// 暂停
- (void)pauseAnimation {
    [_waveDisplaylink setPaused:YES];
}

#pragma mark - Private
/// 绘制波浪
- (void)drawWave
{
    CGFloat width = self.bounds.size.width;     // 整体宽
    CGFloat height = self.bounds.size.height;   // 整体高
    
    // 周期常数(1个单位，代表一整个周期)
    CGFloat cycleConstant = (M_PI / 180.0) * 2;
    
    // 周期
    CGFloat cycle = _cycle * cycleConstant;
    // 初始偏移
    CGFloat earlyOffset = _earlyCycle * cycleConstant * width;
    // 计算偏移
    _offset += _speed * cycleConstant;
 
    // 路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    
    CGFloat y = 0.0f;
    // 计算每个点，加到路径中
    for (CGFloat x = 0; x <= width; x++) {
        y = _height * sinf(cycle * x + earlyOffset + _offset) + self.topSpace;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, width, height);
    CGPathAddLineToPoint(path, nil, 0, height);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *layer = (CAShapeLayer *)self.layer;
    layer.fillColor = _fillColor.CGColor;
    layer.path = path;
    CGPathRelease(path);
}

#pragma mark - Get & Set
/// 填充色
- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self drawWave];
}

- (void)setHeight:(CGFloat)height
{
    _height = height;
    [self drawWave];
}

- (void)setTopSpace:(CGFloat)topSpace
{
    _topSpace = topSpace;
    [self drawWave];
}

- (void)setCycle:(CGFloat)cycle
{
    _cycle = cycle;
    [self drawWave];
}

- (void)setEarlyCycle:(CGFloat)earlyCycle
{
    _earlyCycle = earlyCycle;
    [self drawWave];
}

- (void)setSpeed:(CGFloat)speed
{
    _speed = speed;
    [self drawWave];
}

@end
