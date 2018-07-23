//
//  FSMineNormalCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  设置/客服/缓存Cell

#import <UIKit/UIKit.h>
#import "FSMineMData.h"  //Model

//typedef NS_ENUM (NSUInteger,FSMineNormalCellType) {
//    /** 我的优惠卷 */
//    FSMineNormalCellTypeTicket = 1,
//    /** 我的地址 */
//    FSMineNormalCellTypeAddress,
//    /** 客服电话 */
//    FSMineNormalCellTypeServicePhone,
//    /** 清除缓存 */
//    FSMineNormalCellTypeClearCache,
//    /** 设置 */
//    FSMineNormalCellTypeSetting
//};

@class FSMineNormalCell;
@protocol FSMineNormalCellDelegate <NSObject>
@optional
- (void)mineNormalCell:(FSMineNormalCell *)mineNormalCell mineModel:(FSMineMData *)mineModel cellType:(FSMineCellType)cellType;

@end

@interface FSMineNormalCell : UITableViewCell

@property(nonatomic, weak) id<FSMineNormalCellDelegate> delegate;

@property (nonatomic, strong) FSMineMData *mineMData;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath withTable:(UITableView *)tableView;

@end
