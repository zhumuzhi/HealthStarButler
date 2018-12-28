//
//  FSGroupingCollectionCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/28.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSGroupingCollectionCell.h"

@implementation FSGroupingCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configUIWithFrame:frame];
    }
    return self;
}

- (void)configUIWithFrame:(CGRect)frame {
    CGFloat spaWidth = frame.size.width;
    CGFloat spaHeight = 50;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, spaWidth, spaHeight)];
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV.backgroundColor = [UIColor whiteColor];
    self.imageV = imageV;
    [self.contentView addSubview:self.imageV];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, spaHeight+15, spaWidth, 20)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel = title;
    [self.contentView addSubview:self.titleLabel];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(spaWidth - 30, 5, 30, 30)];
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete_image"] forState:UIControlStateNormal];
    self.deleteBtn.hidden = YES;
    self.deleteBtn = deleteBtn;
    [self.contentView addSubview:self.deleteBtn];
}

@end
