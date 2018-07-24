//
//  FSAccountSetMData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 账号设置cell类型 */
typedef NS_ENUM (NSUInteger,FSAcountSetType) {
    /** 账户详情 */
    FSAcountSetTypeAcount = 1,
    /** 空格间距 */
    FSAcountSetTypeSpace,
    /** 账户信息 */
    FSAcountSetTypeInfo,
    /** 我的地址 */
    FSAcountSetTypeAddress,
    /** 登录密码 */
    FSAcountSetTypeLoginWord,
    /** 支付密码 */
    FSAcountSetTypePayWord,
    /** 退出登录 */
    FSAcountSetTypeQuit
};

@interface FSAccountSetMData : FSBaseMData

/** Cell类型 */
@property (nonatomic, assign) FSAcountSetType cellType;

//---- AccountSetHeader ----
/** 公司名字 */
@property (nonatomic, copy) NSString *companyName;
/** 头像URL */
@property (nonatomic, copy) NSString *iconUrl;
/** 账号名 */
@property (nonatomic, copy) NSString *acountName;
/** 权限 */
@property (nonatomic, copy) NSString *permission;

/** 返回账号设置数据 */
+ (NSMutableArray *)creatAccountSetData;

@end
