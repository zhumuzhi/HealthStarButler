//
//  FSAddressListMData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSBaseMData.h"


typedef NS_ENUM (NSUInteger,FSAddressType) {
    /** 是默认地址 */
    FSAddressTypeDefault = 1,
    /** 不是默认地址 */
    FSAddressTypeNone = 2,
};
typedef NS_ENUM (NSUInteger,FSAddressListCellType) {
    /** 收货人 */
    FSAddressListCellTypeConsignee = 1,
    /** 收货地址 */
    FSAddressListCellTypeAddress,
    /** 操作 */
    FSAddressListCellTypeAction,
    /** 操作 */
    FSAddressListCellTypeTag,
};

NS_ASSUME_NONNULL_BEGIN

@interface FSAddressListMData : FSBaseMData

@property (nonatomic , strong) NSDictionary *addressListDict;

@property (nonatomic , strong) UIColor *backgroundColor;
@property (nonatomic , assign) CGFloat tagWidth;

/** 详细地址 */
@property (nonatomic , copy) NSString *detail_address;
@property (nonatomic , copy) NSString *district_code;
@property (nonatomic , copy) NSString *province_code;
@property (nonatomic , assign) NSInteger receiverId;
@property (nonatomic , copy) NSString *createTime;
@property (nonatomic , copy) NSString *receiverName;
@property (nonatomic , copy) NSString *city_code;
@property (nonatomic , assign) NSInteger limitLine;
/** 绑定手机 */
@property (nonatomic , copy) NSString *mobile;
@property (nonatomic , assign) NSInteger id;
@property (nonatomic , assign) NSInteger addressId;
@property (nonatomic , assign) NSInteger status;
/** 地址别名 */
@property (nonatomic , copy) NSString *add_alias;
/** 是否默认(1是2不是) */
@property (nonatomic , assign) FSAddressType is_default;
/** 办公电话 */
@property (nonatomic , copy) NSString *office_phone;
/**  收货地址主键id */
@property (nonatomic , assign) NSInteger ship_add_id;
/** 市名 */
@property (nonatomic , copy) NSString *cityName;
/** 省份id */
@property (nonatomic , assign) NSInteger province_id;
@property (nonatomic , copy) NSString *areaName;
/** 区域id */
@property (nonatomic , assign) NSInteger district_id;
/**  省份名 */
@property (nonatomic , copy) NSString *provinceName;
/**  街道id */
@property (nonatomic , assign) NSInteger street_id;
@property (nonatomic , copy) NSString *email;
@property (nonatomic , copy) NSString *warehouse_code;
@property (nonatomic , copy) NSString *areaLimitLine;
@property (nonatomic , copy) NSString *street_code;
/** 市id */
@property (nonatomic , assign) NSInteger city_id;
@property (nonatomic , assign) FSAddressListCellType addressListCellType;
- (NSMutableArray *)creatAddressListMData;


@end

NS_ASSUME_NONNULL_END
