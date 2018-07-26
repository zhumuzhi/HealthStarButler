//
//  FSAccountSetNormalCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSAccountSetNormalCell.h"
//#import "FSAccountSetMData.h"

@interface FSAccountSetNormalCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *quitTitle;

@end

@implementation FSAccountSetNormalCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];

        // 添加点击手势触发代理方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickNormal)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - Event
- (void)didClickNormal {
    if (self.delegate && [self.delegate respondsToSelector:@selector(accountSetNormalCell:dataModel:acountSetType:)]) {
        [self.delegate accountSetNormalCell:self dataModel:self.accoutSetMData acountSetType:self.accoutSetMData.cellType];
    }
}

#pragma mark - configUI

static CGFloat Margin = 10.0; //+ 10.0; //边距
static CGFloat arrowW = 6.0;  //指示View宽度

- (void)setupUI {

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // 标题
    CGFloat labelW = ((self.contentView.width-(Margin*3)-arrowW)*0.5);  //title宽度
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kAutoWithSize(Margin*2));
        //make.height.equalTo(@(kAutoWithSize(kMargin24)));
        make.width.equalTo(@(kAutoWithSize(labelW)));
    }];

    // 指示箭头
    [self.contentView addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kAutoWithSize(Margin*2));
        make.width.equalTo(@(kAutoWithSize(arrowW)));
        make.height.equalTo(@(kAutoHeightSize(Margin*2)));
    }];

    //线
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
        make.left.equalTo(self).offset(kAutoWithSize(Margin*2));
        make.right.equalTo(self).offset(-kAutoWithSize(Margin*2));
    }];

    //退出
    [self.contentView addSubview:self.quitTitle];
    [self.quitTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
    }];

}

#pragma mark - SetData
- (void)setAccoutSetMData:(FSAccountSetMData *)accoutSetMData {
    _accoutSetMData = accoutSetMData;
    self.title.text = accoutSetMData.title;
    if (accoutSetMData.cellType == FSAcountSetTypeQuit) {
        self.quitTitle.text = accoutSetMData.title;
        self.title.hidden = YES;
        self.arrow.hidden = YES;
        self.line.hidden = YES;
        self.quitTitle.hidden = NO;
    }
}

#pragma mark - LazyGet
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
    }
    return _title;
}

- (UIImageView *)arrow {
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"mine_cellArrow"];
        _arrow.contentMode = UIViewContentModeCenter;
    }
    return _arrow;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    }
    return _line;
}

- (UILabel *)quitTitle {
    if (_quitTitle == nil) {
        _quitTitle = [[UILabel alloc] init];
        _quitTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
        _quitTitle.textAlignment = NSTextAlignmentCenter;
        _quitTitle.hidden = YES;
    }
    return _quitTitle;
}


@end
