//
//  MEDHomeComplianceModel.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/15.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomeComplianceModel.h"

@implementation MEDHomeComplianceModel

+ (instancetype)complianceWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"UndefinedKey:%@", key);
}

@end
