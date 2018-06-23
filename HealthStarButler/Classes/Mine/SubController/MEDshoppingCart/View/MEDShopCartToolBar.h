//
//  MEDShopCartToolBar.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/23.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ButtonClickBlock)(UIButton *button);

@interface MEDShopCartToolBar : UIView

/** 总价 */
@property (nonatomic, weak) UILabel *totalPriceLabel;
/** 购买按钮 */
@property (nonatomic, weak) UIButton *buyButton;
@property (nonatomic, copy) ButtonClickBlock buttonBlock;

@end
