//
//  FSLoginMData.m
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSLoginMData.h"

@implementation FSLoginMData

- (NSMutableArray *)creatLoginMData {
    NSArray *titles = @[@"",@"",@"",@"登录",@"忘记密码"];
    NSArray *types = @[
                       /** 用户名 */
                       @(FSLoginCellTypeUserAcount),
                       /** 密码 */
                       @(FSLoginCellTypePassword) ,
                       @(FSLoginCellTypeCode),
                       /** 登录 */
                       @(FSLoginCellTypeLogin) ,
                       /** 忘记密码 */
                       @(FSLoginCellTypeForget),
                       ];
    NSArray *placeholders = @[@"请输入用户名",@"请输入密码",@"请输入验证码",];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titles.count; index++) {
        FSLoginMData *loginMData = [[FSLoginMData alloc]init];
        loginMData.title = [titles by_ObjectAtIndex:index];
        loginMData.placeholder = [placeholders by_ObjectAtIndex:index];
        NSNumber *typeNum = [types by_ObjectAtIndex:index];
        loginMData.loginCellType = typeNum.integerValue;
        [dataArray addObject:loginMData];
    }
    return dataArray;
}
@end
