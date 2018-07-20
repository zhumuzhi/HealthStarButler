//
//  FSMineOrderCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  订单管理cell

#import <UIKit/UIKit.h>

@class FSMineOrderCell, FSMineMData;

@protocol FSMineOrderCellDelegate <NSObject>
@optional
- (void)mineOrderCelldidClickAllOrder:(FSMineOrderCell *)mineOrderCell;

@end

@interface FSMineOrderCell : UITableViewCell

@property(nonatomic, weak) id<FSMineOrderCellDelegate> delegate;

@property (nonatomic, strong) FSMineMData *mineMData;


@end
