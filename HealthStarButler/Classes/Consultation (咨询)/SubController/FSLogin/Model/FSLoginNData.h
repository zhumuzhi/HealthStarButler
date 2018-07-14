//
//  FSLoginNData.h
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSBaseNData.h"
typedef NS_ENUM (NSUInteger,FSLoginRequstType) {
    FSLoginRequstTypeCode = 1,
    FSLoginRequstTypeLogin
};

@interface FSLoginReqNData : FSBaseReqNData

// 登录验证码共用
@property (nonatomic , copy) NSString *loginAccount;
@property (nonatomic , copy) NSString *password;
// 登录
@property (nonatomic , copy) NSString *uuid;
@property (nonatomic , copy) NSString *code;

- (instancetype)initWithType: (FSLoginRequstType)requstType;

@end

@interface FSLoginResNData : FSBaseResNData

@end
