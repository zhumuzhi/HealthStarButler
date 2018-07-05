//
//  MEDHomePhysiologyModel.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomePhysiologyModel.h"

NSString *const kMEDHomePhysiologyModelActualValue = @"actualValue";
NSString *const kMEDHomePhysiologyModelCreateTime = @"createTime";
NSString *const kMEDHomePhysiologyModelName = @"name";
NSString *const kMEDHomePhysiologyModelResult = @"result";
NSString *const kMEDHomePhysiologyModelSuggestValue = @"suggestValue";

@interface MEDHomePhysiologyModel ()
@end

@implementation MEDHomePhysiologyModel

+(instancetype)physiologyWithDict:(NSDictionary *)dict {
    return [[MEDHomePhysiologyModel alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kMEDHomePhysiologyModelActualValue] isKindOfClass:[NSNull class]]){
        self.actualValue = dictionary[kMEDHomePhysiologyModelActualValue];
    }
    if(![dictionary[kMEDHomePhysiologyModelCreateTime] isKindOfClass:[NSNull class]]){
        self.createTime = dictionary[kMEDHomePhysiologyModelCreateTime];
    }
    if(![dictionary[kMEDHomePhysiologyModelName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kMEDHomePhysiologyModelName];
    }
    if(![dictionary[kMEDHomePhysiologyModelResult] isKindOfClass:[NSNull class]]){
        self.result = [dictionary[kMEDHomePhysiologyModelResult] integerValue];
    }
    
    if(![dictionary[kMEDHomePhysiologyModelSuggestValue] isKindOfClass:[NSNull class]]){
        self.suggestValue = dictionary[kMEDHomePhysiologyModelSuggestValue];
    }
    return self;
}

-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.actualValue != nil){
        dictionary[kMEDHomePhysiologyModelActualValue] = self.actualValue;
    }
    if(self.createTime != nil){
        dictionary[kMEDHomePhysiologyModelCreateTime] = self.createTime;
    }
    if(self.name != nil){
        dictionary[kMEDHomePhysiologyModelName] = self.name;
    }
    dictionary[kMEDHomePhysiologyModelResult] = @(self.result);
    if(self.suggestValue != nil){
        dictionary[kMEDHomePhysiologyModelSuggestValue] = self.suggestValue;
    }
    return dictionary;
    
}



@end
