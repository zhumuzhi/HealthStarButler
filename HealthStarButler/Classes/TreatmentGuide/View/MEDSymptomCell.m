//
//  MEDSymptomCell.m
//  健康之星管家
//
//  Created by 朱慕之 on 2018/5/31.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDSymptomCell.h"

@implementation MEDSymptomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titlesLab];
        [self.contentView addSubview:self.delimgv];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(UILabel *)titlesLab
{
    if (!_titlesLab) {
        _titlesLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, (self.contentView.frame.size.width-10), self.contentView.frame.size.height)];
        _titlesLab.textAlignment = NSTextAlignmentCenter;
        _titlesLab.font = [UIFont systemFontOfSize:15.0];
        _titlesLab.layer.cornerRadius = 8;
        _titlesLab.layer.borderWidth = 1;
        _titlesLab.layer.borderColor = MEDGrayColor(240).CGColor;
    }
    return _titlesLab;
}

-(UIImageView *)delimgv
{
    if (!_delimgv) {
        _delimgv = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-15, 0, 15, 15)];
    }
    return _delimgv;
}


@end
