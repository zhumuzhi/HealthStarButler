//
//  FSMineOrderCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineOrderCell.h"
#import "FSMineMData.h"

#import "FSMineAllOrderView.h" // 全部订单
// 订单按钮
#import "FSMineOrderItem.h"
//#import "FSMineOrderButton.h"


@interface FSMineOrderCell ()

/** 标题 */
@property (nonatomic, strong) UILabel *title;
/** 全部订单 */
@property (nonatomic, strong) FSMineAllOrderView *allOrderView;
/** 按钮ContentView */
@property (nonatomic, strong) UIView *orderContentView;

@end

@implementation FSMineOrderCell

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - ConfigUI

static CGFloat MarginTop = 20.0;
static CGFloat Margin = 12.0;

- (void)configUI {
    /** 订单标题 */
    [self.contentView addSubview:self.title];
    CGSize titleSize = [@"我的订单" sizeWithFont:[UIFont systemFontOfSize:14.0]];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(MarginTop);
        make.left.equalTo(self).offset(Margin);
        make.width.equalTo(@(titleSize.width));
    }];
    
    /** 全部订单 */
    [self.contentView addSubview:self.allOrderView];
    [self.allOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.title.mas_centerY);
        make.right.equalTo(self).offset(-Margin);
        make.width.equalTo(@(100));
    }];
    
    /** 按钮ContentView */
    [self.contentView addSubview:self.orderContentView];
    [self.orderContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(Margin);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    CGFloat itemMargin = Margin;
    CGFloat itemW = (kScreenWidth-(itemMargin*2))/4;
    CGFloat itemH = (60);
    NSArray *itemTitles = @[@"全部订单", @"代付款", @"代发货", @"待收货"];
    NSArray *itemImages = @[@"mine_waitExamine",@"mine_waitPay",@"mine_waitReceiv",@"mine_waitSend"];
    for (int i=0; i<itemTitles.count; i++) {
        FSMineOrderItem *item = [[FSMineOrderItem alloc] init];
        item.backgroundColor = MEDGrayColor(250);
        [self.orderContentView addSubview:item];
        item.frame = CGRectMake(itemMargin+itemW*i, 0, itemW, itemH);
        item.itemTitle.text = itemTitles[i];
        item.itemImage.image = [UIImage imageNamed:itemImages[i]];
    }
    
    //    for (int i=0; i<itemTitles.count; i++) {
    //        FSMineOrderButton *button = [[FSMineOrderButton alloc] init];
    //        [self.orderContentView addSubview:button];
    //        button.frame = CGRectMake(itemMargin+itemW*i, 0, itemW, itemH);
    //        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //        [button setTitle:itemTitles[i] forState:UIControlStateNormal];
    //    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {
    

    
}

#pragma mark - LazySet

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

#pragma mark - Event

- (void)allOrderClick {
    //NSLog(@"点击了全部订单");
    if ([self.delegate respondsToSelector:@selector(mineOrderCelldidClickAllOrder:)]) {
        [self.delegate mineOrderCelldidClickAllOrder:self];
    }
}

@end
