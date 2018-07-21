//
//  FSMineMData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSBaseMData.h"

typedef NS_ENUM (NSUInteger,FSMineCellType) {
    /** 账户信息 */
    FSMineCellTypeAcount = 1,
    /** 我的订单 */
    FSMineCellTypeOrder,
    /** 我的优惠卷 */
    FSMineCellTypeTicket,
    /** 我的地址 */
    FSMineCellTypeAddress,
    /** 客服电话 */
    FSMineCellTypeServicePhone,
    /** 清除缓存 */
    FSMineCellTypeClearCache,
    /** 设置 */
    FSMineCellTypeSetting
};

@interface FSMineMData : FSBaseMData

@property (nonatomic, assign) FSMineCellType cellType;
//** 创建本地数据 */
+ (NSMutableArray *)creatMineMData;

@end
