//
//  GGSwitch.m
//  GGSwitch
//
//  Created by __无邪_ on 15/4/29.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGSwitch.h"
#define degreesToRadians(degrees) ((degrees) * M_PI / 180.0)
#define PROGRESS_LINE_WIDTH 1 //弧线的宽度

static CGFloat kSwitchWidth  = 65.0; //宽
static CGFloat kSwitchHeight = 31.0; //高

@interface GGSwitch ()
@property (nonatomic, strong)CAShapeLayer *trackLayer;

@property (nonatomic, unsafe_unretained)BOOL stateisOn;
@end
@implementation GGSwitch{
    BOOL shouldAnimated;
    
    UIColor *onColor; //开时的背景色
    UIColor *offColor;//关时的背景色
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, kSwitchWidth, kSwitchHeight)];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        onColor = [UIColor colorWithRed:0.242 green:0.781 blue:0.126 alpha:1.000];
        offColor = [UIColor whiteColor];
        
        CGSize size = CGSizeMake(kSwitchWidth, kSwitchHeight);
        
        _trackLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_trackLayer];
        
        _trackLayer.frame = CGRectMake(0, 0, size.height, size.width);
        _trackLayer.fillColor = [[UIColor whiteColor] CGColor];
        //_trackLayer.strokeColor = [[UIColor greenColor] CGColor];//指定path的渲染颜色
        _trackLayer.opacity = 1;
        _trackLayer.lineCap = kCALineCapRound;
        _trackLayer.lineWidth = PROGRESS_LINE_WIDTH;
        _trackLayer.shadowColor = [UIColor grayColor].CGColor;
        _trackLayer.shadowOffset = CGSizeMake(0.5, 0);
        _trackLayer.shadowOpacity = 1.0;
        _trackLayer.shadowRadius = 1.0;
        
        self.stateisOn = NO;
        shouldAnimated = YES;
        
        [self addTapGesture];
        
    }
    return self;
}


#pragma mark - Missions

- (void)addTapGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchStateChanged)];
    [self addGestureRecognizer:tapGesture];
}

- (void)switchStateChanged{
    
    self.stateisOn = !self.stateisOn;
    
    CGSize size = CGSizeMake(kSwitchWidth, kSwitchHeight);
    CGRect newBounds;
    UIColor *color = nil;
    if (self.stateisOn) {
        newBounds = CGRectMake(size.width - size.height, 0, size.height, size.height);
        color = onColor;
    }
    else{
        newBounds = CGRectMake(0, 0, size.height, size.width);
        color = offColor;
    }
    
    if (shouldAnimated) {
        [CATransaction begin];
        [CATransaction setDisableActions:!YES];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [CATransaction setAnimationDuration:0.15];
        _trackLayer.frame = newBounds;
        [CATransaction commit];
    }
    else{
        _trackLayer.frame = newBounds;
    }
    
    if (self.tapBlock) {
        self.tapBlock(self.stateisOn);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(ggswitch:state:)]) {
        [self.delegate ggswitch:self state:self.stateisOn];
    }
    [self setNeedsDisplay];
}

#pragma mark - Size
-(void)setSwitchSize:(CGSize)switchSize{
    kSwitchWidth  = switchSize.width;
    kSwitchHeight = switchSize.height;
    
    CGRect oldFrame = self.frame;
    CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, kSwitchWidth, kSwitchHeight);
    
    [self setFrame:newFrame];
    [self setNeedsDisplay];
}

#pragma mark - Color
-(void)setTintColor:(UIColor *)tintColor{
    
}
-(void)setThumbTintColor:(UIColor *)thumbTintColor{
    _trackLayer.fillColor = [thumbTintColor CGColor];
}
-(void)setOnTintColor:(UIColor *)onTintColor{
    onColor = onTintColor;
    if (self.stateisOn) {
        [self setNeedsDisplay];
    }
}


#pragma mark - Public

-(BOOL)isOn{
    return self.stateisOn;
}

-(void)setOn:(BOOL)on animated:(BOOL)animated{
    shouldAnimated = YES;
    self.stateisOn = !on;
    
    [self switchStateChanged];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize size = CGSizeMake(kSwitchWidth, kSwitchHeight);
    CGFloat halfHeight = size.height / 2;
    CGFloat width      = size.width;
    CGFloat height     = size.height;
    
    UIBezierPath* pathLeft = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfHeight + 1, halfHeight)//圆弧中心
                                                         radius:halfHeight//半径
                                                     startAngle:degreesToRadians(90)//开始角度
                                                       endAngle:degreesToRadians(270)//结束角度
                                                      clockwise:YES];//是否顺时针
    pathLeft.lineWidth     = 1.0;
    pathLeft.lineCapStyle  = kCGLineCapRound;  //线条拐角
    pathLeft.lineJoinStyle = kCGLineCapRound; //终点处理
    [pathLeft addLineToPoint:CGPointMake(width - halfHeight, 0)];
    
    UIBezierPath *pathRight = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width - 1 - halfHeight, halfHeight)
                                                         radius:halfHeight
                                                     startAngle:degreesToRadians(270)
                                                       endAngle:degreesToRadians(90)
                                                      clockwise:YES];
    pathRight.lineWidth = 1.0;
    [pathLeft appendPath:pathRight];
    [pathLeft addLineToPoint:CGPointMake(halfHeight, height)];
//
    UIColor *fontColor = [UIColor whiteColor];//字体颜色
    if (self.stateisOn) {
        [onColor setStroke];
        [onColor setFill];
        fontColor = [UIColor whiteColor];
    }
    else{
        [[UIColor groupTableViewBackgroundColor] setStroke];
        [offColor setFill];
        fontColor = [UIColor darkGrayColor];
    }
    [pathLeft fill];
    [pathLeft stroke];
    
    
    UIBezierPath* pathCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfHeight, halfHeight)//圆弧中心
                                                            radius:halfHeight//半径
                                                        startAngle:degreesToRadians(0)//开始角度
                                                          endAngle:degreesToRadians(360)//结束角度
                                                         clockwise:YES];//是否顺时针
    pathCircle.lineWidth     = 1.0;
    pathCircle.lineCapStyle  = kCGLineCapRound; //线条拐角
    pathCircle.lineJoinStyle = kCGLineCapRound; //终点处理
    _trackLayer.path =[pathCircle CGPath];
    
    
    
    NSDictionary *attributes =@{
                                NSFontAttributeName:[UIFont systemFontOfSize:18],
                     NSForegroundColorAttributeName:fontColor
                                };
    
    if (self.onText && self.onText.length > 0) {
        
        CGSize size = [self.onText sizeWithAttributes:attributes];
        [self.onText drawInRect:CGRectMake((width/2 - size.width)/2, (height-size.height) / 2, width / 2, height) withAttributes:attributes];
    }
    
    if (self.offText && self.offText.length > 0) {
        
        CGSize size = [self.onText sizeWithAttributes:attributes];
        [self.offText drawInRect:CGRectMake(width/2 + (width/2 - size.width)/2, (height-size.height) / 2, width / 2, height) withAttributes:attributes];
    }
}


@end
