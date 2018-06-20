//
//  MEDBloodpressureModel.h
//  健康之星管家
//
//  Created by 吕海瑞 on 15/12/1.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDBloodpressureModel : NSObject
@property(nonatomic,copy)NSString *systolic;//收缩压
@property(nonatomic,copy)NSString *diastolic;//舒张压
@property(nonatomic,copy)NSString *heartrate;//心率
@property(nonatomic,copy)NSString *meas_date;//yyyyMMddHHmmss
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *data_id;
@property(nonatomic,copy)NSString *data_source;
@property(nonatomic,assign)NSInteger id;


@property(nonatomic,copy)NSString *systolic_is_alarm;
@property(nonatomic,copy)NSString *diastolic_is_alarm;

@property(nonatomic,copy)NSString *sex;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end


