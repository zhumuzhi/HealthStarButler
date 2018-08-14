//
//  FSChoseZoneMData.h
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSBaseMData.h"
typedef NS_ENUM (NSUInteger,FSChoseZoneCellType) {
    /** 定位 */
    FSChoseZoneCellTypePosition = 1,
    /** 选择城市 */
    FSChoseZoneCellTypeChoseCity,
    /** 搜索城市 */
    FSChoseZoneCellTypeSearchCity,
};
typedef NS_ENUM (NSUInteger,FSChoseZoneDataType) {
    /** 定位 */
    FSChoseZoneDataTypePosition = 1,
    /** 搜索列表 */
    FSChoseZoneDataTypeSearchList,
};
@interface FSChoseZoneMData : FSBaseMData
@property (nonatomic , assign) FSChoseZoneDataType choseZoneDataType;
@property (nonatomic , assign) FSChoseZoneCellType choseZoneCellType;
@property (nonatomic , copy) NSArray *array;
/** 记录定位是否完成 */
@property (nonatomic , assign) BOOL isComplete;
@property (nonatomic , copy) NSArray *cities;
@property (nonatomic , copy) NSString *name;
/** 城市名称 */
@property (nonatomic, copy) NSString *cityName;
- (NSMutableArray *)searchCity;
- (NSMutableArray *)choseCityWithCity: (NSString *)city;
- (FSChoseZoneMData *)choseZoneDataWithType: (FSChoseZoneDataType)type;

- (NSMutableArray *)choseGroupCityWithCity: (NSString *)city;

@end
