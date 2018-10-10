//
//  FSAddressListNData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressListNData.h"


@interface FSAddressListReqNData ()

@property (nonatomic, assign) FSAddressListRequstType requestType;

@end

@implementation FSAddressListReqNData

- (instancetype)initWithRequstType:(FSAddressListRequstType)type {
    if (self == [super init]) {
        self.requestType = type;
        if (type == FSAddressListRequstTypeList) {
            self.url = @"https://t.fsyuncai.com/membership/adminQueryAddressPerson.jhtml";
        }else if (type == FSAddressListRequstTypeDefault) {
            self.url = @"";
        }
    }
    return self;
}

- (NSMutableDictionary *)parametes{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    /** 地址列表 */
    if (self.requestType == FSAddressListRequstTypeList) {
//        dict[@"memberId"] = @(self.memberId);
        dict[@"memberId"] = @(15);
//        dict[@"type"] = @(self.type);
        dict[@"type"] = @(10);
        dict[@"pageNum"] = @(self.pageNum);
        dict[@"pageSize"] = @(self.pageSize);
    /** 设为默认地址 */
    }else if (self.requestType == FSAddressListRequstTypeDefault) {
        dict[@"shipAddId"] = @(self.shipAddId);
        dict[@"token"] = self.token;
    }
    return dict;
}

@end


@implementation FSAddressListResNData

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        NSArray *list = dictionary[@"list"];
        NSMutableArray *dataArray = [NSMutableArray array];
        if (![NSArray isEmptyArr:list]) {
            for (NSDictionary *dict in list) {
                
                
                
            }
            
        }
    }
}



@end
