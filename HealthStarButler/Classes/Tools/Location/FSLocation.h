//
//  FSLocation.h
//  FangShengyun
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//
#pragma mark - - - - 请求用户权限,需要在info.plist中添加两个值NSLocationAlwaysUsageDescription      NSLocationWhenInUseUsageDescription

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#pragma mark - 定位模型

@interface FSLocationModel : NSObject
/** 当前定位的经度纬度 */
@property (nonatomic, strong) CLLocation *currentLocation;
/** 定位的地理位置信息 */
@property (nonatomic, strong) NSDictionary *locatedAddress;
/** 位置名 */
@property (nonatomic, strong) NSString *name;
/**  街道 */
@property (nonatomic, strong) NSString *thoroughfare;
/** 子街道 */
@property (nonatomic, strong) NSString *subThoroughfare;
/** 市 */
@property (nonatomic, strong) NSString *locality;
/** 区 */
@property (nonatomic, strong) NSString *subLocality;
/** 省（州） */
@property (nonatomic, strong) NSString *administrativeArea;
/** 其他行政信息，可能是县镇乡等 */
@property (nonatomic, strong) NSString *subAdministrativeArea;
/** 邮政编码 */
@property (nonatomic, strong) NSString *postalCode;
/** 国家编码 */
@property (nonatomic, strong) NSString *ISOcountryCode;
/** 国家 */
@property (nonatomic, strong) NSString *country;

@end

typedef void (^LocationcomplateBlock) (BOOL isSuccess, FSLocationModel *locationModel);

@interface FSLocation : NSObject

+ (instancetype)sharedManager;
/** 开始定位 */
- (void)startLocationAddress:(LocationcomplateBlock)block;

@end
