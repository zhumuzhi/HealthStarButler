//
//  FSMineOrderCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineOrderCell.h"
//#import "FSMineMData.h"

#import "FSMineAllOrderView.h" // 全部订单
#import "FSMineOrderItem.h"    // 订单按钮

@interface FSMineOrderCell ()

/** 背景View */
@property (nonatomic, strong) UIView *backView;
/** 标题 */
@property (nonatomic, strong) UILabel *title;
/** 全部订单 */
@property (nonatomic, strong) FSMineAllOrderView *allOrderView;
/** 按钮ContentView */
@property (nonatomic, strong) UIView *orderContentView;
/** 订单控件 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation FSMineOrderCell

static CGFloat kShadowW = 2.0;

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];

        [self configShadow];
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - ConfigUI

static CGFloat MarginTop = 20.0;
static CGFloat Margin = 10.0;

- (void)configUI {
    /** 背景图 */
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kShadowW);
        make.bottom.equalTo(self).offset(-kShadowW);
        make.left.equalTo(self).offset(kAutoWithSize(Margin)+kShadowW);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin)-kShadowW);
    }];

    /** 订单标题 */
    [self.backView addSubview:self.title];
    CGSize titleSize = [@"我的订单" sizeWithFont:[UIFont systemFontOfSize:14.0]];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(MarginTop);
        make.left.equalTo(self.backView).offset(kAutoWithSize(Margin));
        make.width.equalTo(@(titleSize.width));
    }];
    
    /** 全部订单 */
    [self.backView addSubview:self.allOrderView];
    [self.allOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.title.mas_centerY);
        make.right.equalTo(self.backView).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(100));
    }];
    
    /** 按钮ContentView */
    [self.backView addSubview:self.orderContentView];
    [self.orderContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(kAutoWithSize(Margin));
        make.left.equalTo(self.backView);
        make.right.equalTo(self.backView);
        make.bottom.equalTo(self.backView);
    }];

}

- (void)configShadow {
    // ----- 阴影 -----
    CGRect viewRect = CGRectMake(0, 0, kScreenWidth-(kAutoWithSize(Margin)*2), 128);
    CGPathRef path = [UIBezierPath bezierPathWithRect:viewRect].CGPath;
    CAShapeLayer *radiusLayer = [CAShapeLayer layer];
    radiusLayer.path = path;
    self.backView.layer.mask = radiusLayer;
    self.backView.layer.borderWidth = 0.000001; // 只要不为0就行
    self.backView.layer.shadowColor = [UIColor colorWithHexString:@"#EAEAEA"].CGColor;
    self.backView.layer.shadowOpacity = 0.5f;
    self.backView.layer.shadowRadius = kShadowW;
    self.backView.layer.shadowOffset = CGSizeMake(kShadowW,kShadowW);
    // ----- 阴影 -----
}


- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {
    NSMutableArray *dataArray;
    if (self.orderType == FSMineOrderDataTypeOne) {
        dataArray = [FSMineMData creatMineOrderMDataWithDataType:FSMineOrderDataTypeOne];
    }else if (self.orderType == 2) {
        dataArray = [FSMineMData creatMineOrderMDataWithDataType:FSMineOrderDataTypeTwo];
    }

    NSMutableArray *tempItems = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++) {
        FSMineOrderItem *item = [[FSMineOrderItem alloc] init];
        [tempItems addObject:item];
        [self.orderContentView addSubview:item];
        
        FSMineMData *mineData = [dataArray by_ObjectAtIndex:i];
        item.itemTitle.text = mineData.orderTitle;
        item.itemImage.image = [UIImage imageNamed:mineData.orderImage];
        item.itemType = mineData.ordertype;
        
        // 添加点击手势触发理方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickItem:)];
        [item addGestureRecognizer:tap];
    }
    self.items = tempItems;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat itemMargin = Margin;
    CGFloat itemW = (kScreenWidth-(itemMargin*4))/4;
    CGFloat itemH = (60);
    for (int i=0; i<self.items.count; i++) {
        FSMineOrderItem *item = [self.items by_ObjectAtIndex:i];
        item.frame = CGRectMake(itemMargin+itemW*i, 0, itemW, itemH);
    }
}

- (void)didClickItem:(id)sender  {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    FSMineOrderItem *item = (FSMineOrderItem*)tap.view;
    //NSLog(@"item:%lu",item.itemType);
    if ([self.delegate respondsToSelector:@selector(mineOrderCell:mineModel:orderBtnType:)]) {
        [self.delegate mineOrderCell:self mineModel:self.mineMData orderBtnType:item.itemType];
    }
}

#pragma mark - Event
- (void)allOrderClick {
    //NSLog(@"点击了全部订单");
    if ([self.delegate respondsToSelector:@selector(mineOrderCell:mineModel:orderBtnType:)]) {
        [self.delegate mineOrderCell:self mineModel:self.mineMData orderBtnType:FSMineOrderCellBtnTypeAllOrder];
    }
}

#pragma mark - LazySet
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _backView.layer.cornerRadius = 6.0;
    }
    return _backView;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14.0];
        _title.text = @"我的订单";
    }
    return _title;
}

- (FSMineAllOrderView *)allOrderView {
    if (_allOrderView == nil) {
        _allOrderView = [[FSMineAllOrderView alloc] init];
        UITapGestureRecognizer *allOrderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allOrderClick)];
        [_allOrderView addGestureRecognizer:allOrderTap];
    }
    return _allOrderView;
}

- (UIView *)orderContentView {
    if (_orderContentView == nil) {
        _orderContentView = [[UIView alloc] init];
    }
    return _orderContentView;
}


@end
