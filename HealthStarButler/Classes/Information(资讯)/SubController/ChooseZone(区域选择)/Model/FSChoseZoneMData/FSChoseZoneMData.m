//
//  FSChoseZoneMData.m
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSChoseZoneMData.h"

@implementation FSChoseZoneMData

WYCodingImplementation

- (FSChoseZoneMData *)choseZoneDataWithType: (FSChoseZoneDataType)type {
    FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];
    choseZoneMData.choseZoneDataType = type;
    if (type == FSChoseZoneDataTypePosition) {
        choseZoneMData.array = [self choseCityWithCity:nil];
    } else if (type == FSChoseZoneDataTypeSearchList) {
        choseZoneMData.array = [self searchCity];
    }
    return choseZoneMData;
}

- (NSMutableArray *)choseCityWithCity: (NSString *)city {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self creatlocationWithCity:city]];
    [dataArray addObject:[self creatCityList]];
    return dataArray;
}

- (FSChoseZoneMData *)creatCityList{
    FSChoseZoneMData *sectionMData = [[FSChoseZoneMData alloc] init];
//    sectionMData.sectionHeaderTitle = @"选择配送位置";
//    NSArray *titles = @[@"北京",@"天津",@"河北"];
//    NSMutableArray *dataArray = [NSMutableArray array];
//    for (NSInteger index = 0; index < titles.count; index++) {
//        FSChoseZoneMData *rowMData = [[FSChoseZoneMData alloc]init];
//        rowMData.title = [titles by_ObjectAtIndex:index];
//        rowMData.choseZoneDataType = FSChoseZoneDataTypePosition;
//        rowMData.choseZoneCellType = FSChoseZoneCellTypeChoseCity;
//        [dataArray addObject:rowMData];
//    }
//    sectionMData.items = dataArray.mutableCopy;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
    // NSLog(@"tempArray: %@", tempArray);
    for (NSDictionary *dict in tempArray) {
        FSChoseZoneMData *choseZoneGroup = [[FSChoseZoneMData alloc] init];
        choseZoneGroup.cityCapital = dict[@"title"];
        NSMutableArray *tempGroup = [NSMutableArray array];
        NSArray *tempCitys = dict[@"cities"];
        for (int i = 0; i <tempCitys.count; i++) {
            FSChoseZoneMData *choseZone = [[FSChoseZoneMData alloc] init];
            choseZone.cityName = [tempCitys by_ObjectAtIndex:i];
            choseZone.choseZoneDataType = FSChoseZoneDataTypePosition;
            choseZone.choseZoneCellType = FSChoseZoneCellTypeChoseCity;
            [tempGroup addObject:choseZone];
        }
        choseZoneGroup.cities = tempGroup;
    }

    return sectionMData;
}

- (NSMutableArray *)searchCity {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"cities" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        FSChoseZoneMData *choseZoneMData = [FSChoseZoneMData mj_objectWithKeyValues:dict];
        choseZoneMData.choseZoneCellType = FSChoseZoneCellTypePosition;
        choseZoneMData.choseZoneDataType = FSChoseZoneCellTypeSearchCity;
        [dataArray addObject:choseZoneMData];
    }
    return dataArray;
}

#pragma mark --------------- 分组城市测试 ---------------

#pragma mark - 拼接数据
- (NSMutableArray *)choseCityWithCity: (NSString *)city cites:(NSArray *)cites {
    NSMutableArray *dataArray = [NSMutableArray array];
    // ------ 定位 ------
    [dataArray addObject:[self creatlocationWithCity:city]];
    // ------ 历史 ------
    [dataArray addObject:[self creatHistoryCity]];
    // ------ 列表 ------
    for (NSDictionary *dict in cites) {
        FSChoseZoneMData *choseZoneGroup = [[FSChoseZoneMData alloc] init];
        choseZoneGroup.sectionHeaderTitle = dict[@"item"];
        NSMutableArray *tempGroup = [NSMutableArray array];
        NSArray *tempCitys = dict[@"list"];
        for (NSDictionary *cityDict in tempCitys) {
            FSChoseZoneMData *choseZone = [[FSChoseZoneMData alloc] init];
            choseZone.cityName = cityDict[@"name"];
            choseZone.code = cityDict[@"code"];
            [tempGroup addObject:choseZone];
        }
        choseZoneGroup.items = tempGroup;
        [dataArray addObject:choseZoneGroup];
    }
    return dataArray;
}

#pragma mark - 创建当前定位城市数据
- (FSChoseZoneMData *)creatlocationWithCity:(NSString *)city {
    FSChoseZoneMData *sectionMData = [[FSChoseZoneMData alloc]init];
    sectionMData.sectionHeaderTitle = @"当前定位城市";
    FSChoseZoneMData *rowMData = [[FSChoseZoneMData alloc]init];
    rowMData.title = city.length > 0? city:@"正在定位中...";
    rowMData.isComplete = city.length > 0 ? YES:NO;
    rowMData.choseZoneDataType = FSChoseZoneDataTypePosition;
    rowMData.choseZoneCellType = FSChoseZoneCellTypePosition;
    sectionMData.items = @[rowMData];
    return sectionMData;
}

#pragma mark - 创建历史选择城市数据
- (FSChoseZoneMData *)creatHistoryCity{
    FSChoseZoneMData *sectionMData = [[FSChoseZoneMData alloc]init];
    sectionMData.sectionHeaderTitle = @"历史选择";

    NSArray *citysArray = [[CacheHelper sharedManager] readDataWithKey:kHistoyCites];
    if (citysArray == nil) {
        citysArray = [NSMutableArray array];
    }
//    NSLog(@"历史城市:%@", citysArray);
    if (citysArray.count>0) {
        for (FSChoseZoneMData *rowMData in citysArray) {
            rowMData.choseZoneDataType = FSChoseZoneDataTypePosition;
            rowMData.choseZoneCellType = FSChoseZoneCellTypeChoseCity;
        }
    }
    sectionMData.items = citysArray;
    return sectionMData;
}

@end
