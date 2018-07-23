//
//  FSMineNormalCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineNormalCell.h"
// Model
//#import "FSMineMData.h"

@interface FSMineNormalCell ()

/** 背景View */
@property (nonatomic, strong) UIView *backView;
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

static CGFloat kShadowW = 2.0;

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath withTable:(UITableView *)tableView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self configUI];
        [self configuration];
        [self cellViewMakeRadiusLayerWithTableView:tableView indexPath:indexPath];

        // 添加点击手势触犯代理方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickNormal)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - ConfigUI
static CGFloat Margin = 10.0; //+ 10.0; //边距
static CGFloat arrowW = 6.0;  //指示View宽度
static CGFloat Radius = 6.0; //圆角

- (void)configUI {
    //backView
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kAutoWithSize(Margin)+kShadowW);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin)-kShadowW);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];

    // 标题
    CGFloat labelW = ((self.contentView.width-(Margin*3)-arrowW)*0.5);  //title宽度
    [self.backView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.left.equalTo(self.backView).offset(kAutoWithSize(Margin));
        //make.height.equalTo(@(kAutoWithSize(kMargin24)));
        make.width.equalTo(@(kAutoWithSize(labelW)));
    }];

    // 指示箭头
    [self.backView addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.right.equalTo(self.backView).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(kAutoWithSize(arrowW)));
        make.height.equalTo(@(kAutoHeightSize(kMargin10)));
    }];

    // 右边标题
    [self.backView addSubview:self.subTitle];
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.right.equalTo(self.arrow).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(kAutoWithSize(labelW)));
    }];
}

- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/** 绘制圆角&&设置阴影 */
- (void)cellViewMakeRadiusLayerWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath {

    CGRect viewRect = CGRectMake(0, 0, kScreenWidth-(kAutoWithSize(Margin)*2)-(kShadowW*2), 50);
    CGPathRef path;
    if(indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        //根据cell设置Rect
        viewRect = CGRectMake(0, kShadowW, kScreenWidth-(kAutoWithSize(Margin)*2)-(kShadowW*2), 50-(kShadowW*2));
        path = [UIBezierPath bezierPathWithRoundedRect:viewRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(Radius, Radius)].CGPath;
        //backView
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kShadowW);
            make.bottom.equalTo(self).offset(-kShadowW);
        }];
    }else if (indexPath.row == 0) {
        //根据cell设置Rect
        viewRect = CGRectMake(0, kShadowW, kScreenWidth-(kAutoWithSize(Margin)*2)-(kShadowW*2), 48);
        path = [UIBezierPath bezierPathWithRoundedRect:viewRect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(Radius, Radius)].CGPath;
        [self configSeparator];// 添加线条
        //backView
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kShadowW);
        }];
    }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        //根据cell设置Rect
        viewRect = CGRectMake(0, 0, kScreenWidth-(kAutoWithSize(Margin)*2)-(kShadowW*2), 50-kShadowW);
        path = [UIBezierPath bezierPathWithRoundedRect:viewRect byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(Radius, Radius)].CGPath;
        //backView
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kShadowW);
        }];
    }else{
        path = [UIBezierPath bezierPathWithRect:viewRect].CGPath;
        [self configSeparator];// 添加线条
    }

    CAShapeLayer *radiusLayer = [CAShapeLayer layer];
    radiusLayer.path = path;
    self.backView.layer.mask = radiusLayer;

    self.backView.layer.borderWidth = 0.000001; // 只要不为0就行
    self.backView.layer.shadowColor = [UIColor colorWithHexString:@"#EAEAEA"].CGColor;
//    self.backView.layer.shadowColor = [UIColor colorWithHexString:@"#FF2600"].CGColor;
    self.backView.layer.shadowOpacity = 0.5f;
    self.backView.layer.shadowRadius = kShadowW;
    self.backView.layer.shadowOffset = CGSizeMake(kShadowW,kShadowW);
}

/** 设置线条 */
- (void)configSeparator {
    [self.backView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(kAutoWithSize(Margin));
        make.right.equalTo(self.backView).offset(-kAutoWithSize(Margin));
        make.height.equalTo(@(kAutoHeightSize(1)));
        make.bottom.equalTo(self.backView.mas_bottom);
    }];
}

-(void)layoutSubviews {
    [super layoutSubviews];

}

#pragma mark - Event
- (void)didClickNormal {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineNormalCell:mineModel:cellType:)]) {
        [self.delegate mineNormalCell:self mineModel:self.mineMData cellType:self.mineMData.cellType];
    }
}

#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {
    _mineMData = mineMData;

    self.title.text = mineMData.title;
    self.subTitle.text = mineMData.details;
}

#pragma mark - LazySet

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

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

- (UILabel *)subTitle {
    if (_subTitle == nil) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.textColor = [UIColor colorWithHexString:@"#999999"];
        _subTitle.textAlignment = NSTextAlignmentRight;
        _subTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
    }
    return _subTitle;
}

@end
