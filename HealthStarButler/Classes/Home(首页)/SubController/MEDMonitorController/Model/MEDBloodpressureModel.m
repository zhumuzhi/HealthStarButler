//
//  MEDBloodpressureModel.m
//  健康之星管家
//
//  Created by 吕海瑞 on 15/12/1.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDBloodpressureModel.h"

@implementation MEDBloodpressureModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _systolic = @"0";
        _diastolic = @"0";
        _heartrate = @"0";
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine--%@",key);
}




@end
