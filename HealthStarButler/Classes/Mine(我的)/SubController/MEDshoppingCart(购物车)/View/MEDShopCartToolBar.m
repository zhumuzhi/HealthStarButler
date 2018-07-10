//
//  MEDShopCartToolBar.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/23.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDShopCartToolBar.h"

CGFloat toolBarH = 50;
CGFloat toolBarMargin = 10;

@interface MEDShopCartToolBar ()

@property (nonatomic, weak) UILabel *toolTitle;
@property (nonatomic, weak) UILabel *unitLabel;
//@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UIButton *clearButton;


@end

@implementation MEDShopCartToolBar

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        // ToolBar
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        lineView.backgroundColor = MEDGrayColor(240);
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *toolTitle = [[UILabel alloc] init];
        [self addSubview:toolTitle];
        self.toolTitle = toolTitle;
        toolTitle.text = @"总价";
        
        
        UILabel *unitLabel = [[UILabel alloc] init];
        self.unitLabel = unitLabel;
        [self addSubview:unitLabel];
        unitLabel.text = @"￥";
        unitLabel.textColor = [UIColor redColor];

        UILabel *totalPriceLabel = [[UILabel alloc] init];
        [self addSubview:totalPriceLabel];
        self.totalPriceLabel = totalPriceLabel;
        totalPriceLabel.text = @"0";
        totalPriceLabel.textColor = [UIColor redColor];
        
        UIButton *clearButton = [[UIButton alloc] init];
        [self addSubview:clearButton];
        /* 清空购物车*/
        clearButton.tag = 6181;
        self.clearButton = clearButton;
        [clearButton setTitle:@"清空购物车" forState:UIControlStateNormal];
        [clearButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *buyButton = [[UIButton alloc] init];
        [self addSubview:buyButton];
        /* 购买商品*/
        buyButton.tag = 6182;
        self.buyButton = buyButton;
        buyButton.enabled = NO; //默认不可点击
        [buyButton setTitle:@"购买" forState:UIControlStateNormal];
        [buyButton setTitleColor:MEDCommonBlue forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [buyButton addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

#pragma mark - subViews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.toolTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.toolTitle);
        make.left.equalTo(self.toolTitle.mas_right).offset(5);
    }];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.toolTitle);
        make.left.equalTo(self.unitLabel.mas_right);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.bottom.equalTo(self).offset(-10);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.clearButton);
        make.right.equalTo(self.clearButton.mas_left).offset(-10);
    }];
    
}

#pragma mark - Event

- (void)clearClick:(UIButton *)button {
    NSLog(@"点击清空购物车");
    if (self.buttonBlock) {
        self.buttonBlock(button);
    }

}

- (void)buyClick:(UIButton *)button {
    NSLog(@"点击购买");
    if (self.buttonBlock) {
        self.buttonBlock(button);
    }
    
}

@end
