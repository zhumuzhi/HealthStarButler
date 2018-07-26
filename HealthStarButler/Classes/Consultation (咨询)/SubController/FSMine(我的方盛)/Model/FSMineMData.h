//
//  FSMineMData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

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

/** OrderCell数据类型 */
typedef NS_ENUM (NSUInteger,FSMineOrderDataType) {
    /** 类型1-全部订单 */
    FSMineOrderDataTypeOne = 1,
    /** 类型2-待审核 */
    FSMineOrderDataTypeTwo
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
@property (nonatomic, copy) NSString *orderTitle;
@property (nonatomic, copy) NSString *orderImage;
@property (nonatomic, assign) FSMineOrderCellBtnType ordertype;

/* FIXME:增加Cell类型Type Enum用来判断*/

//---- OtherCell ----
//** 创建Header本地数据 */
+ (FSMineMData *)creatMineHeaderData;
//** 创建Cell本地数据 */
+ (NSMutableArray *)creatMineMData;
/** 根据类型创建Order数组 */
+ (NSMutableArray *)creatMineOrderMDataWithDataType:(FSMineOrderDataType)dataType;

@end
