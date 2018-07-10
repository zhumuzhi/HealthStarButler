//
//  MEDShopCartCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEDShopCartModel, MEDShopCartCell;

@protocol MEDShopCartDelegate <NSObject> //基协议NSObject

@optional
- (void)shopCartCellDidClickPlusButton:(MEDShopCartCell *)cell;
- (void)shopCartCellDidClickMinusButton:(MEDShopCartCell *)cell;

@end

@interface MEDShopCartCell : UITableViewCell

@property (nonatomic, strong) MEDShopCartModel *goods;
@property (nonatomic, weak) id<MEDShopCartDelegate> delegate;

@end
