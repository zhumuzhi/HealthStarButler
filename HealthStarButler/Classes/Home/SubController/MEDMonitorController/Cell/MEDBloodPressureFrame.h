//
//  MEDBloodPressureFrame.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/11/8.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEDBloodpressureModel;

@interface MEDBloodPressureFrame : NSObject

@property (nonatomic, strong) MEDBloodpressureModel *bloodPressure;

@property (nonatomic, assign) CGRect imageF;
@property (nonatomic, assign) CGRect dateF;
@property (nonatomic, assign) CGRect typeF;
@property (nonatomic, assign) CGRect systolicF;
@property (nonatomic, assign) CGRect separatorF;
@property (nonatomic, assign) CGRect diastolicF;
@property (nonatomic, assign) CGRect unitF;
@property (nonatomic, assign) CGRect heartRateF;

@end
