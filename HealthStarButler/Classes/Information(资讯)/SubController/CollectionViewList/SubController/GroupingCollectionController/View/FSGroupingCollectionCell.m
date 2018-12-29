//
//  FSGroupingCollectionCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/28.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSGroupingCollectionCell.h"
#import "FSGroupingModel.h"

@interface FSGroupingCollectionCell ()

/** 图片 */
@property (nonatomic, weak) UIImageView *imageV;
/** 标题Label */
@property (nonatomic, weak) UILabel *titleLabel;
//* 删除按钮
//@property (nonatomic, weak) UIButton *deleteBtn;

@end

@implementation FSGroupingCollectionCell

#pragma mark - SetData
- (void)setRowModel:(FSGroupingModel *)rowModel {
    _rowModel = rowModel;
    self.titleLabel.text = rowModel.name;
    self.imageV.backgroundColor = [UIColor randomColor];
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self configUIWithFrame:frame];
    }
    return self;
}

#pragma mark - ConfigUI
- (void)configUIWithFrame:(CGRect)frame {
    CGFloat spaWidth = frame.size.width;
    CGFloat spaHeight = 50;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, spaWidth, spaHeight)];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV = imageV;
    [self.contentView addSubview:self.imageV];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, spaHeight+15, spaWidth, 20)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.titleLabel = title;
    [self.contentView addSubview:self.titleLabel];
}

@end
