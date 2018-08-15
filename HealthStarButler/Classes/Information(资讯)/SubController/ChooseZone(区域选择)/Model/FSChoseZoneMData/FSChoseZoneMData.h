//
//  FSChoseZoneMData.h
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSBaseMData.h"

/** ChoseZoneCellType */
typedef NS_ENUM (NSUInteger,FSChoseZoneCellType) {
    /** 定位 */
    FSChoseZoneCellTypePosition = 1,
    /** 选择城市 */
    FSChoseZoneCellTypeChoseCity,
    /** 选择历史 */
    FSChoseZoneCellTypeChoseHistory,
    /** 搜索城市 */
    FSChoseZoneCellTypeSearchCity
};

/** ChoseZoneDataType */
typedef NS_ENUM (NSUInteger,FSChoseZoneDataType) {
    /** 定位 */
    FSChoseZoneDataTypePosition = 1,
    /** 搜索列表 */
    FSChoseZoneDataTypeSearchList,
};

@interface FSChoseZoneMData : FSBaseMData

/** 数据类型(定位/搜索列表) */
@property (nonatomic , assign) FSChoseZoneDataType choseZoneDataType;
/** Cell类型(定位/选择城市/选择历史/搜索城市) */
@property (nonatomic , assign) FSChoseZoneCellType choseZoneCellType;

@property (nonatomic , copy) NSArray *array;
/** 记录定位是否完成 */
@property (nonatomic , assign) BOOL isComplete;

@property (nonatomic , copy) NSString *name;

#pragma mark -------------------- 新使用 --------------------
/** 城市组 */
@property (nonatomic , copy) NSArray *cities;
/** 城市字母 */
@property (nonatomic, copy) NSString *cityCapital;
/** 城市名称 */
@property (nonatomic, copy) NSString *cityName;
/** 城市code */
@property (nonatomic, copy) NSString *code;

#pragma mark -------------------- 方法 --------------------
- (NSMutableArray *)searchCity;
- (NSMutableArray *)choseCityWithCity: (NSString *)city;
- (FSChoseZoneMData *)choseZoneDataWithType: (FSChoseZoneDataType)type;
- (NSMutableArray *)choseGroupCityWithCity: (NSString *)city;

- (NSMutableArray *)choseCityWithCity: (NSString *)city cites:(NSArray *)cites;

@end
