//
//  FSLoginNData.m
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSLoginNData.h"
#import "FSLoginMData.h"

@interface FSLoginReqNData()
@property (nonatomic , assign)FSLoginRequstType requestType;
@end
@implementation FSLoginReqNData

- (instancetype)initWithType: (FSLoginRequstType)requstType {
    if (self == [super init]) {
        self.requestType = requstType;
        if (requstType == FSLoginRequstTypeCode) {
            self.url = kVerifyCode;
        } else if (requstType == FSLoginRequstTypeLogin) {
            self.url = kLogin;
        }
    }
    return self;
}

- (NSMutableDictionary *)parametes {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.requestType == FSLoginRequstTypeCode) {
        dict[@"loginAccount"] = self.loginAccount;
        dict[@"password"] = self.password;
    } else if (self.requestType == FSLoginRequstTypeLogin) {
        dict[@"loginAccount"] = self.loginAccount;
        dict[@"password"] = self.password;
        dict[@"uuid"] = self.uuid;
        dict[@"code"] = self.code;
    }
    return dict;
}

@end

@implementation FSLoginResNData

@end




