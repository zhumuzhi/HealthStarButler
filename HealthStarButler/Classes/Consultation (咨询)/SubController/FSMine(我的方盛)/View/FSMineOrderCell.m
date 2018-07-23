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

- (void)layoutSubviews {
    [super layoutSubviews];

}

- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {

    CGFloat itemMargin = Margin;
    CGFloat itemW = (kScreenWidth-(itemMargin*4))/4;
    CGFloat itemH = (60);

    NSMutableArray *itemTitles;
    NSMutableArray *itemImages;
    NSMutableArray *itemTypes;
    
//    FSMineOrderCellBtnType
//    if（ mineMData。typr = FSMineOrderCellBtnType） {
//        array = mineMData.array
//    } esle {
//    }

/* FIXME:1.数据创建写入模型*/
/* FIXME:2.增加动态数组，动态添加Frame计算在Layout中进行*/

    if (self.orderType == 1) {

        NSArray *tempTitles = @[@"全部订单", @"代付款", @"代发货", @"待收货"];
        NSArray *tempImages = @[@"mine_waitExamine", @"mine_waitPay", @"mine_waitSend", @"mine_waitReceiv"];
        NSArray *tempTypes = @[@(FSMineOrderCellBtnTypeAllOrder), @(FSMineOrderCellBtnTypePay), @(FSMineOrderCellBtnTypeReceiv), @(FSMineOrderCellBtnTypeSend)];
        itemTitles = [NSMutableArray arrayWithArray:tempTitles];
        itemImages = [NSMutableArray arrayWithArray:tempImages];
        itemTypes = [NSMutableArray arrayWithArray:tempTypes];

    }else if (self.orderType == 2) {

        NSArray *tempTitles = @[@"待审批", @"代付款", @"代发货", @"待收货"];
        NSArray *tempImages = @[@"mine_waitSend", @"mine_waitPay", @"mine_waitSend", @"mine_waitReceiv"];
        NSArray *tempTypes = @[@(FSMineOrderCellBtnTypeExamine), @(FSMineOrderCellBtnTypePay), @(FSMineOrderCellBtnTypeReceiv), @(FSMineOrderCellBtnTypeSend)];
        itemTitles = [NSMutableArray arrayWithArray:tempTitles];
        itemImages = [NSMutableArray arrayWithArray:tempImages];
        itemTypes = [NSMutableArray arrayWithArray:tempTypes];
    }

    for (int i=0; i<itemTitles.count; i++) {
        FSMineOrderItem *item = [[FSMineOrderItem alloc] init];
        // item.backgroundColor = MEDGrayColor(250);
        [self.orderContentView addSubview:item];
        item.frame = CGRectMake(itemMargin+itemW*i, 0, itemW, itemH);
        item.itemTitle.text = itemTitles[i];
        item.itemImage.image = [UIImage imageNamed:itemImages[i]];
        NSNumber *typeNum = [itemTypes by_ObjectAtIndex:i];
        item.itemType = typeNum.integerValue;
        // 添加点击手势触发理方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickItem:)];
        [item addGestureRecognizer:tap];
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
