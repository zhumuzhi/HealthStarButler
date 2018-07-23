//
//  FSMineMData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSBaseMData.h"


/** 我的方盛cell类型 */
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

/** 订单cell按钮类型 */
typedef NS_ENUM (NSUInteger,FSMineOrderCellBtnType) {
    /** 全部订单 */
    FSMineOrderCellBtnTypeAllOrder = 1,
    /** 待审核 */
    FSMineOrderCellBtnTypeExamine,
    /** 待付款 */
    FSMineOrderCellBtnTypePay,
    /** 待收货 */
    FSMineOrderCellBtnTypeReceiv,
    /** 待发货 */
    FSMineOrderCellBtnTypeSend
};

@interface FSMineMData : FSBaseMData

/** 我的cell类型 */
@property (nonatomic, assign) FSMineCellType cellType;


//---- Headr ----
/** 头像URL */
@property (nonatomic, copy) NSString *iconUrl;
/** 账号名 */
@property (nonatomic, copy) NSString *acountName;
/** 权限 */
@property (nonatomic, copy) NSString *permission;

//---- OrderCell ----
@property (nonatomic, strong) NSArray *orderItems;


/* FIXME:增加Cell类型Type Enum用来判断*/

//---- OtherCell ----
//** 创建Header本地数据 */
//- (FSMineMData *)creatMineHeaderData;
//** 创建Cell本地数据 */
+ (NSMutableArray *)creatMineMData;

@end
