//
//  MEDScoreButton.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/27.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDScoreButton.h"

#define FOUR_BUTTON_IMAGE   25
#define IMAGE_SEPEACE       12.5
#define IMAGE_TITLE_SEPACE  15

@implementation MEDScoreButton

- (void)initWithImage:(NSString *)image andTitle:(NSString *)title
{
    if (!_btnImage) {
        _btnImage = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGE_SEPEACE, IMAGE_SEPEACE, FOUR_BUTTON_IMAGE,CGRectGetHeight(self.frame) - IMAGE_SEPEACE * 2 - 1)];
        
    }
    _btnImage.image = [UIImage imageNamed:image];
    [self addSubview:_btnImage];
    if (!_btnTitle) {
        _btnTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxY(_btnImage.frame) + IMAGE_TITLE_SEPACE, 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(_btnImage.frame) - 10, CGRectGetHeight(self.frame)-1)];
    }
    
    _btnTitle.text = title;
    _btnTitle.font = [UIFont systemFontOfSize:12];
    // _btnTitle.font = [MEDResource getNormalFont];
    
    [self addSubview:_btnTitle];
    
    //  UILabel *bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5)];
    //  bottomLine.backgroundColor = [MEDResource getLineColor];
    // [self addSubview:bottomLine];
    
}


@end
