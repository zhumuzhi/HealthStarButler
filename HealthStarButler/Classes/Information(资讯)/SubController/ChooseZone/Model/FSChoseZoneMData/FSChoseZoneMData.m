//
//  FSChoseZoneMData.m
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSChoseZoneMData.h"

@implementation FSChoseZoneMData

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

- (FSChoseZoneMData *)creatCityList{
    FSChoseZoneMData *sectionMData = [[FSChoseZoneMData alloc]init];
    sectionMData.sectionHeaderTitle = @"选择配送位置";
    NSArray *titles = @[@"北京",@"天津",@"河北"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titles.count; index++) {
        FSChoseZoneMData *rowMData = [[FSChoseZoneMData alloc]init];
        rowMData.title = [titles by_ObjectAtIndex:index];
        rowMData.choseZoneDataType = FSChoseZoneDataTypePosition;
        rowMData.choseZoneCellType = FSChoseZoneCellTypeChoseCity;
        [dataArray addObject:rowMData];
    }
    sectionMData.items = dataArray.mutableCopy;
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

#pragma mark - 分组城市测试

- (NSMutableArray *)choseGroupCityWithCity: (NSString *)city {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self creatlocationWithCity:city]];
    [dataArray addObject:[self creatCityGroupList]];
    return dataArray;
}

- (FSChoseZoneMData *)creatCityGroupList {
    FSChoseZoneMData *cityGroup = [[FSChoseZoneMData alloc] init];
    cityGroup.sectionHeaderTitle = @"选择配送位置";
    NSArray *cityGroups = @[
                            @{
                                @"title" : @"A",
                                @"citys" : @[@"阿克苏", @"阿拉善", @"安庆", @"安阳"]
                                },
                            @{
                                @"title" : @"B",
                                @"citys" : @[@"白银", @"保定", @"巴中", @"北海", @"北京"]
                                },
                            @{
                                @"title" : @"C",
                                @"citys" : @[@"沧州", @"常州", @"成都", @"赤峰", @"潮州"]
                                },
                            @{
                                @"title" : @"D",
                                @"citys" : @[@"大理", @"大连", @"大庆", @"德州", @"东莞"]
                                }
                            ];
    NSMutableArray *tempItems = [NSMutableArray array];
    for (NSDictionary *dict in cityGroups) {
        cityGroup.title = dict[@"title"];
        cityGroup.choseZoneDataType = FSChoseZoneDataTypePosition;
        cityGroup.choseZoneCellType = FSChoseZoneCellTypeChoseCity;
        NSArray *citys = dict[@"citys"];
        for (NSString *cityName in citys) {
            FSChoseZoneMData *city = [[FSChoseZoneMData alloc] init];
            city.cityName = cityName;
            city.choseZoneDataType = FSChoseZoneDataTypePosition;
            city.choseZoneCellType = FSChoseZoneCellTypeChoseCity;
            [tempItems addObject:city];
        }
        cityGroup.items = tempItems.mutableCopy;
    }
    return cityGroup;
}


@end
