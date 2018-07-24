//
//  FSAccountSetMData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSAccountSetMData.h"

@implementation FSAccountSetMData

+ (NSMutableArray *)creatAccountSetData {

    NSArray *dictArray = @[
                           @{@"title":@"", @"type":@(FSAcountSetTypeSpace), @"cellHeight":@10},
                           @{@"title":@"账户信息", @"type":@(FSAcountSetTypeInfo), @"cellHeight":@50},
                           @{@"title":@"地址管理", @"type":@(FSAcountSetTypeAddress), @"cellHeight":@50},
                           @{@"title":@"修改登录密码", @"type":@(FSAcountSetTypeLoginWord), @"cellHeight":@50},
                           @{@"title":@"修改支付密码", @"type":@(FSAcountSetTypePayWord), @"cellHeight":@50},
                           @{@"title":@"", @"type":@(FSAcountSetTypeSpace), @"cellHeight":@10},
                           @{@"title":@"退出", @"type":@(FSAcountSetTypeQuit), @"cellHeight":@50}
                           ];

    NSMutableArray *tempArray = [NSMutableArray array];
    FSAccountSetMData *accountHeaderData = [[FSAccountSetMData alloc] creatAccountSetHeadData];
    accountHeaderData.cellHeight = 150.0f;
    [tempArray addObject:accountHeaderData];

    for (NSInteger i = 0; i<dictArray.count; i++) {
        NSDictionary *dataDict = [dictArray by_ObjectAtIndex:i];

        FSAccountSetMData *accountData = [[FSAccountSetMData alloc] init];

        accountData.title = dataDict[@"title"];
        NSNumber *typeNum = dataDict[@"type"];
        accountData.cellType = typeNum.integerValue;
        NSNumber *cellHeight = dataDict[@"cellHeight"];
        accountData.cellHeight = cellHeight.integerValue;

        [tempArray addObject:accountData];
    }

    return tempArray;
}

- (FSAccountSetMData *)creatAccountSetHeadData {
    FSAccountSetMData  *headData = [[FSAccountSetMData alloc] init];
    headData.cellType = FSAcountSetTypeAcount;
    headData.companyName = @"北京华海中一节能科技股份有限公司";
    headData.iconUrl = @"someName";
    headData.acountName = @"账号：MEID123";
    headData.permission = @"权限：下单 结算 审批";
    return headData;
}

@end
