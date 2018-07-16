//
//  FSCheckCodeView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/16.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCheckCodeView.h"

@implementation FSCheckCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置随机背景颜色
//        [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = MEDGrayColor(240).CGColor;
    }
    return self;
}

//根据服务器返回的或者自己设置的codeStr绘制图形验证码
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    //根据要显示的验证码字符串，根据长度，计算每个字符串显示的位置
    NSString *text = [NSString stringWithFormat:@"%@",_codeStr];

    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];

    int width = rect.size.width/text.length - cSize.width;
    int height = rect.size.height - cSize.height;

    CGPoint point;

    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX,pY;
    for ( int i = 0; i<text.length; i++)
    {
        pX = arc4random() % width + rect.size.width/text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);

        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];

        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Chalkduster" size:14.0f], NSForegroundColorAttributeName:MEDRGB(132, 153, 33)}];
    }

    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, 4.0);

//    //绘制干扰线
//    for (int i = 0; i < 2; i++)
//    {
//        UIColor *color=[UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
//        CGContextSetStrokeColorWithColor(context, color.CGColor);//设置线条填充色
//
//        //设置线的起点
//        pX = arc4random() % (int)rect.size.width;
//        pY = arc4random() % (int)rect.size.height;
//        CGContextMoveToPoint(context, pX, pY);
//        //设置线终点
//        pX = arc4random() % (int)rect.size.width;
//        pY = arc4random() % (int)rect.size.height;
//        CGContextAddLineToPoint(context, pX, pY);
//        //画线
//        CGContextStrokePath(context);
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_delegate&&[_delegate respondsToSelector:@selector(didTapFSCheckCodeView:)]) {
        [_delegate didTapFSCheckCodeView:self];
    }
    //setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

@end
