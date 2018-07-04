//
//  FSCustomButton.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/4.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCustomButton.h"

@implementation FSCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#define scale 0.6

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    switch (self.imageType) {
        case FSButtonImaegTypeLeft:
        {
//            CGFloat imageX = scale;
//            CGFloat imageY = scale;
//            CGFloat imageW = scale;
//            CGFloat imageH = scale;
        }
            break;
        case FSButtonImaegTypeRight:
        {

        }
            break;
        case FSButtonImaegTypeUp:
        {

        }
            break;
        case FSButtonImaegTypeDown:
        {

        }
            break;
    }
    
    self.imageView.frame = CGRectMake(0, 0, btnW, btnW);
    self.titleLabel.frame = CGRectMake(0, btnW, btnW, btnH - btnW);
}

#pragma mark 计算标题内容宽度
- (CGFloat)widthForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat width = MAX(size.width, 30);
        CGFloat imageW = [self imageForState:UIControlStateNormal].size.width;
        
        if (width+imageW > CGRectGetWidth(contentRect)) { // 当标题和图片宽度超过按钮宽度时不能越界
            return  CGRectGetWidth(contentRect) - imageW;
        }
        return width+10;
    }
    else {
        return CGRectGetWidth(contentRect)/2;
    }
}

#pragma mark 计算标题文字内容的高度
- (CGFloat)heightForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat height = MAX(size.height, 5);
        
        if (height > CGRectGetHeight(contentRect)/2) { // 当标题高度超过按钮1/2宽度时
            return  CGRectGetHeight(contentRect)/2 ;
        }
        return height;
    }
    else {
        return CGRectGetHeight(contentRect)/2;
    }
}



@end
