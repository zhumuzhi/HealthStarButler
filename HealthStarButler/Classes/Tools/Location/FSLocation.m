//
//  FSLocation.m
//  FangShengyun
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSLocation.h"
@implementation FSLocationModel

@end
@interface FSLocation()<CLLocationManagerDelegate>
@property (nonatomic , strong) CLLocationManager *manager;
@property (nonatomic , strong) CLGeocoder*geocoder;
@property (nonatomic , copy) LocationcomplateBlock addressBlock;
@end
@implementation FSLocation
+ (instancetype)sharedManager {
    
    static FSLocation *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)startLocationAddress:(LocationcomplateBlock)block {
 
    self.addressBlock = block;
    /** 判断用户定位服务是否开启 */
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] ==
         kCLAuthorizationStatusAuthorizedWhenInUse ||
         [CLLocationManager authorizationStatus] ==
         kCLAuthorizationStatusNotDetermined ||
         [CLLocationManager authorizationStatus] ==
         kCLAuthorizationStatusAuthorizedAlways)) {
        /** 开启了定位 */
        if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.manager requestWhenInUseAuthorization];
        }
        [self.manager startUpdatingLocation];
        return;
    } else {
        /** 没有开启定位 */
        if (self.addressBlock) {
            self.addressBlock (NO,nil);
        }
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"打开定位开关" message:@"请点击设置打开定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
//        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        if (self.addressBlock) {
            self.addressBlock (NO,nil);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];

    MEDWeakSelf(self);
    FSLocationModel *model = [[FSLocationModel alloc] init];
    model.currentLocation = location;
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark= [placemarks firstObject];
        model.locatedAddress = placemark.addressDictionary;
        model.name = placemark.name;
        model.country = placemark.country;
        model.postalCode = placemark.postalCode;
        model.ISOcountryCode = placemark.ISOcountryCode;
        model.administrativeArea = placemark.administrativeArea;
        model.subAdministrativeArea = placemark.subAdministrativeArea;
        model.locality = placemark.locality;
        model.subLocality = placemark.subLocality;
        model.thoroughfare = placemark.thoroughfare;
        model.subThoroughfare = placemark.subThoroughfare;
        
        if (weakself.addressBlock) {
            weakself.addressBlock (YES,model);
        }
    }];

    [self stopLocation];
}
- (void)stopLocation {
    [self.manager stopUpdatingLocation];
    self.manager = nil;
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self stopLocation];
    if (self.addressBlock) {
        self.addressBlock (NO,nil);
    }
}

#pragma mark - get
- (CLLocationManager *)manager {
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        [_manager requestWhenInUseAuthorization];
        _manager.delegate = self;
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_manager setDistanceFilter:kCLDistanceFilterNone];
    }
    return _manager;
}

- (CLGeocoder *)geocoder {
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}


@end
