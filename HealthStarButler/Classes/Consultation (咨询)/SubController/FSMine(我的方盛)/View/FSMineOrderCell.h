//
//  FSMineOrderCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  订单管理cell

#import <UIKit/UIKit.h>
#import "FSMineMData.h"

typedef NS_ENUM (NSUInteger,FSMineOrderCellType) {
    FSMineOrderCellTypeAllOrder = 1,
    FSMineOrderCellTypeOrderBtn
};

@class FSMineOrderCell, FSMineMData;
@protocol FSMineOrderCellDelegate <NSObject>
@optional
- (void)mineOrderCell:(FSMineOrderCell *)mineOrderCell mineModel:(FSMineMData *)mineModel orderBtnType:(FSMineOrderCellBtnType)btnType;

@end

@interface FSMineOrderCell : UITableViewCell

@property(nonatomic, weak) id<FSMineOrderCellDelegate> delegate;

@property (nonatomic, strong) FSMineMData *mineMData;

@property (nonatomic, assign) FSMineOrderCellBtnType orderBtnType;

@property (nonatomic, assign) NSInteger orderType;

@end
