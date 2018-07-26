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


+ (NSMutableArray *)creatMineOrderMDataWithDataType:(FSMineOrderDataType)dataType {
    
    NSMutableArray *dataArray;
    if (dataType == FSMineOrderDataTypeOne) {
        NSArray *dictArrayOne = @[
                                  @{@"title":@"全部订单", @"image":@"mine_waitReceiv", @"type":@(FSMineOrderCellBtnTypeExamine)},
                                  @{@"title":@"待付款", @"image":@"mine_waitPay", @"type":@(FSMineOrderCellBtnTypePay)},
                                  @{@"title":@"待发货", @"image":@"mine_waitSend", @"type":@(FSMineOrderCellBtnTypeReceiv)},
                                  @{@"title":@"待收货", @"image":@"mine_waitReceiv", @"type":@(FSMineOrderCellBtnTypeSend)},
                                  ];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArrayOne) {
            FSMineMData *mineData = [[FSMineMData alloc] init];
            mineData.orderTitle = dict[@"title"];
            mineData.orderImage = dict[@"image"];
            NSNumber *typeNum = dict[@"type"];
            mineData.ordertype = typeNum.integerValue;
            [tempArray addObject:mineData];
        }
        dataArray = [NSMutableArray arrayWithArray:tempArray];
    }else if(dataType == FSMineOrderDataTypeTwo) {
        NSArray *dictArrayTwo = @[
                                  @{@"title":@"待审批", @"image":@"mine_waitExamine", @"type":@(FSMineOrderCellBtnTypeExamine)},
                                  @{@"title":@"待付款", @"image":@"mine_waitPay", @"type":@(FSMineOrderCellBtnTypePay)},
                                  @{@"title":@"待发货", @"image":@"mine_waitSend", @"type":@(FSMineOrderCellBtnTypeReceiv)},
                                  @{@"title":@"待收货", @"image":@"mine_waitReceiv", @"type":@(FSMineOrderCellBtnTypeSend)},
                                  ];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArrayTwo) {
            FSMineMData *mineData = [[FSMineMData alloc] init];
            mineData.orderTitle = dict[@"title"];
            mineData.orderImage = dict[@"image"];
            NSNumber *typeNum = dict[@"type"];
            mineData.ordertype = typeNum.integerValue;
            [tempArray addObject:mineData];
        }
        dataArray = [NSMutableArray arrayWithArray:tempArray];
    }
    return dataArray;
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
    CGFloat cache = [[CacheHelper sharedManager] sdGetCacheSize];
    NSString *cacheStr = [NSString stringWithFormat:@"%.fM",cache];
    NSArray *subTitles = @[@"",@"",@"400-680-9666",cacheStr,@""];
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

+ (FSMineMData *)creatMineHeaderData {
    FSMineMData *mineHeadData = [[FSMineMData alloc]init];
    mineHeadData.acountName = @"账号：MEID123";
    mineHeadData.permission = @"权限: 下单 结算 审批";
    mineHeadData.iconUrl = @"list_denglutouxiang";
    return mineHeadData;
}

@end
