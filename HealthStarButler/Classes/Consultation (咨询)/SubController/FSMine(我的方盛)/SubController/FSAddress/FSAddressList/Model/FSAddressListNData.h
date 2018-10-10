//
//  FSAddressListNData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSBaseNData.h"

typedef NS_ENUM (NSUInteger,FSAddressListRequstType) {
    /** 收货地址列表 */
    FSAddressListRequstTypeList = 1,
    /** 设置默认收货地址 */
    FSAddressListRequstTypeDefault,
};


@interface FSAddressListReqNData : FSBaseReqNData
// ----- 网络请求 -----
/** 会员ID */
@property (nonatomic , assign) NSInteger memberId;
/** 每页多少条 */
@property (nonatomic , assign) NSInteger pageSize;
/** 哪页 */
@property (nonatomic , assign) NSInteger pageNum;
/** 请求类型 */
@property (nonatomic , assign) NSInteger type;
/** 设置默认地址Id */
@property (nonatomic , assign) NSInteger shipAddId;
/** token */
@property (nonatomic , copy) NSString *token;

// ----- 网络请求 -----
/** 省份id */
@property (nonatomic , assign) NSInteger provinceId;
/** 城市id */
@property (nonatomic , assign) NSInteger cityId;
/** 区县id */
@property (nonatomic , assign) NSInteger districtId;
/** 乡镇/街道id*/
@property (nonatomic , assign) NSInteger streetId;

- (instancetype)initWithRequstType: (FSAddressListRequstType)type;

@end


@interface FSAddressListResNData : FSBaseResNData

@end





