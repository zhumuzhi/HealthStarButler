//
//  FSMineMData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineMData.h"

@implementation FSMineMData

///** 创建本地数据 */
+ (NSMutableArray *)creatMineMData {
    NSMutableArray *dataArray = [NSMutableArray array];
//    [dataArray addObject:[[FSMineMData alloc] creatMineFirstSectionData]];
    [dataArray addObject:[[FSMineMData alloc] creatMineSecondSectionData]];
    [dataArray addObject:[[FSMineMData alloc] creatMineThirdSectionData]];
    return dataArray;
}

- (FSMineMData *)creatMineFirstSectionData {

    FSMineMData *sectionMData = [[FSMineMData alloc]init];
    sectionMData.sectionHeaderHeight = 0.1f;
    sectionMData.sectionFooterHeight = 0.1f;

    NSArray *titles = @[@"账户设置"];
    NSArray *cellTypes = @[
                           /** 账户设置 */
                           @(FSMineCellTypeAcount),
                           ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titles.count; index++) {
        FSMineMData *mineMData = [[FSMineMData alloc] init];
        mineMData.title = [titles by_ObjectAtIndex:index];
        NSNumber *typeNum = [cellTypes by_ObjectAtIndex:index];
        mineMData.cellType = typeNum.integerValue;
        [dataArray addObject:mineMData];
    }
    sectionMData.items = dataArray.mutableCopy;
    return sectionMData;
}

- (FSMineMData *)creatMineSecondSectionData {

    FSMineMData *sectionMData = [[FSMineMData alloc]init];
    sectionMData.sectionHeaderHeight = 15.0f;
    sectionMData.sectionFooterHeight = 0.1f;

    NSArray *titles = @[@"我的订单"];
    NSArray *cellTypes = @[
                           /** 我的订单 */
                           @(FSMineCellTypeOrder),
                           ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titles.count; index++) {
        FSMineMData *mineMData = [[FSMineMData alloc] init];
        mineMData.title = [titles by_ObjectAtIndex:index];
        NSNumber *typeNum = [cellTypes by_ObjectAtIndex:index];
        mineMData.cellType = typeNum.integerValue;
        [dataArray addObject:mineMData];
    }
    sectionMData.items = dataArray.mutableCopy;
    return sectionMData;
}

- (FSMineMData *)creatMineThirdSectionData {

    FSMineMData *sectionMData = [[FSMineMData alloc]init];
    sectionMData.sectionHeaderHeight = 15.0f;
    sectionMData.sectionFooterHeight = 0.1f;

    NSArray *titles = @[@"我的优惠券",@"我的地址",@"客服电话",@"清除缓存",@"设置"];
    NSArray *cellTypes = @[
                           /** 我的优惠券 */
                           @(FSMineCellTypeTicket),
                           /** 我的地址 */
                           @(FSMineCellTypeAddress),
                           /** 客服电话 */
                           @(FSMineCellTypeServicePhone),
                           /** 清除缓存 */
                           @(FSMineCellTypeClearCache),
                           /** 设置 */
                           @(FSMineCellTypeSetting),
                           ];
    NSArray *subTitles = @[@"",@"",@"400-680-9666",@"0M",@""];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titles.count; index++) {
        FSMineMData *mineMData = [[FSMineMData alloc] init];
        mineMData.title = [titles by_ObjectAtIndex:index];
        NSNumber *typeNum = [cellTypes by_ObjectAtIndex:index];
        mineMData.cellType = typeNum.integerValue;
        mineMData.details = [subTitles by_ObjectAtIndex:index];
        [dataArray addObject:mineMData];
    }
    sectionMData.items = dataArray.mutableCopy;
    return sectionMData;
}

//    NSArray *sectionDatas = @[
//                              @{
//                                  },
//                              @{
//                                  }
//                              ];

@end
