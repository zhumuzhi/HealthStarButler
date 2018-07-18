//
//  FSMineMData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineMData.h"

@implementation FSMineMData

+ (NSMutableArray *)creatMineMData {
    NSArray *titles = @[@"账户设置",@"我的订单",@"设置",@"客服电话",@"清除缓存"];
    NSArray *cellTypes = @[
                      /** 账户设置 */
                      @(FSMineCellTypeAcount),
                      /** 我的订单 */
                      @(FSMineCellTypeOrder),
                      /** 设置 */
                      @(FSMineCellTypeSetting),
                      /** 客服电话 */
                      @(FSMineCellTypeServicePhone),
                      /** 清除缓存 */
                      @(FSMineCellTypeClearCache)
                      ];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titles.count; index++) {
        FSMineMData *mineMData = [[FSMineMData alloc] init];
        mineMData.title = [titles by_ObjectAtIndex:index];
        NSNumber *typeNum = [cellTypes by_ObjectAtIndex:index];
        mineMData.cellType = typeNum.integerValue;
        [dataArray addObject:mineMData];
    }
    return dataArray;
}



@end
