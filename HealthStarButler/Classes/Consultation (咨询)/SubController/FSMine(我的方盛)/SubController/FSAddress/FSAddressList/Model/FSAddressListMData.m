//
//  FSAddressListMData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressListMData.h"

@implementation FSAddressListMData

- (NSMutableArray *)creatAddressListMData {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject: [self creatFirst]];
    [dataArray addObject: [self creatSecond]];
    
    return dataArray.mutableCopy;
}

- (FSAddressListMData *)creatFirst {
    FSAddressListMData *sectionMData = [[FSAddressListMData alloc]init];
    sectionMData.sectionHeaderHeight = 10.0f;
    sectionMData.sectionFooterHeight = 0.0f;
    NSArray *names = @[@"1233333",@"ddas"];
    NSMutableArray *items = [NSMutableArray array];
    NSString *address = @"北京市大兴区黄村海信北路村海信北路村海信北路村海信北路村村村村村村海信北路";
    for (NSInteger index = 0; index < names.count; index++) {
        FSAddressListMData *rowMData = [[FSAddressListMData alloc]init];
        rowMData.title = [names by_ObjectAtIndex:index];
        rowMData.cellHeight = 30;
        rowMData.addressListCellType = FSAddressListCellTypeConsignee;
        
        [items addObject:rowMData];
    }
    for (NSInteger index = 0; index < 1; index++) {
        FSAddressListMData *rowMData = [[FSAddressListMData alloc]init];
        rowMData.title = address;
        rowMData.cellHeight = 44;
        rowMData.addressListCellType = FSAddressListCellTypeAddress;
        [items addObject:rowMData];
    }
    for (NSInteger index = 0; index < 1; index++) {
        FSAddressListMData *rowMData = [[FSAddressListMData alloc]init];
        rowMData.cellHeight = 44;
        rowMData.addressListCellType = FSAddressListCellTypeAction;
        [items addObject:rowMData];
    }
    sectionMData.items = items.mutableCopy;
    
    return sectionMData;
}

- (FSAddressListMData *)creatSecond {
    FSAddressListMData *sectionMData = [[FSAddressListMData alloc]init];
    sectionMData.sectionHeaderHeight = 10.0f;
    sectionMData.sectionFooterHeight = 0.0f;
    NSArray *names = @[@"1233333"];
    NSMutableArray *items = [NSMutableArray array];
    NSString *address = @"北京市大兴区黄村海信北路村海信北路村海信北路村海信北路村村村村村村海信北路黄村海信北路村海信北路黄村海信北路村海信北路黄村海信北路村海信北路黄村海信北路村海信北路黄村海信北路村海信北路黄村海信北路村海信北路黄村海信北路村海信北路黄村海信北路村海信北路";
    for (NSInteger index = 0; index < names.count; index++) {
        FSAddressListMData *rowMData = [[FSAddressListMData alloc]init];
        rowMData.title = [names by_ObjectAtIndex:index];
        rowMData.cellHeight = 30;
        rowMData.addressListCellType = FSAddressListCellTypeConsignee;
        
        [items addObject:rowMData];
    }
    for (NSInteger index = 0; index < 1; index++) {
        FSAddressListMData *rowMData = [[FSAddressListMData alloc]init];
        rowMData.title = address;
        rowMData.cellHeight = 44;
        rowMData.addressListCellType = FSAddressListCellTypeAddress;
        [items addObject:rowMData];
    }
    sectionMData.items = items.mutableCopy;
    
    return sectionMData;
}


@end
