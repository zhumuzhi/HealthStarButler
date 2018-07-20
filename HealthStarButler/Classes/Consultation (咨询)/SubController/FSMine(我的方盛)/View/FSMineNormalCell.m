//
//  FSMineNormalCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineNormalCell.h"
// Model
#import "FSMineMData.h"

@interface FSMineNormalCell ()

/** 标题*/
@property (nonatomic, strong) UILabel *title;
/** 箭头*/
@property (nonatomic, strong) UIImageView *arrow;
/** 线*/
@property (nonatomic, strong) UIView *line;
/** 右标题 */
@property (nonatomic, strong) UILabel *subTitle;


@end

@implementation FSMineNormalCell

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];
        //        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

static CGFloat Margin = 12.0; //边距
static CGFloat arrowW = 6.0;  //指示View宽度

#pragma mark - ConfigUI
- (void)configUI {
    CGFloat labelW = ((self.contentView.width-(Margin*3)-arrowW)*0.5);  //title宽度
    // 标题
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kAutoWithSize(Margin));
        //make.height.equalTo(@(kAutoWithSize(kMargin24)));
        make.width.equalTo(@(kAutoWithSize(labelW)));
    }];

    // 指示箭头
    [self.contentView addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(kAutoWithSize(arrowW)));
        make.height.equalTo(@(kAutoHeightSize(kMargin10)));
    }];

    // 线条
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kAutoWithSize(Margin));
        make.right.equalTo(self).offset(-kAutoWithSize(Margin));
        make.height.equalTo(@(kAutoHeightSize(0.5)));
        make.bottom.equalTo(self).offset(kAutoHeightSize(0.5));
    }];

    // 右边标题
    [self.contentView addSubview:self.subTitle];
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.arrow).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(kAutoWithSize(labelW)));
    }];

}

- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {
    _mineMData = mineMData;

    self.title.text = mineMData.title;
    //    if (mineMData.cellType == FSMineCellTypeServicePhone) {
    //        self.arrow.hidden = YES;
    //    }
    self.subTitle.text = mineMData.details;
}

#pragma mark - Event

#pragma mark - LazySet

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.font = [UIFont fontWithName:@"-apple-system" size:14.0];
    }
    return _title;
}

- (UIImageView *)arrow {
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"detail_good_right"];

    }
    return _arrow;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _line;
}

- (UILabel *)subTitle {
    if (_subTitle == nil) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.textColor = [UIColor colorWithHexString:@"#999999"];
        _subTitle.textAlignment = NSTextAlignmentRight;
        _subTitle.font = [UIFont fontWithName:@"-apple-system" size:12.0];
    }
    return _subTitle;
}


@end
