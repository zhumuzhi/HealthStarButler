//
//  MEDPersonalDataModel.m
//  健康之星管家
//
//  Created by 朱慕之 on 2016/12/12.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#import "MEDPersonalDataModel.h"

@implementation MEDPersonalDataModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"MEDPersonalDataModel——UndefiKey-%@",key);
}

- (instancetype)initWithDict:(NSDictionary*)dict {
    
    if (self = [super init]) {
        self.user_id = dict[@"uid"];
        self.userPhoto = dict[@"userPhoto"];
        self.user_name = dict[@"user_name"];
        self.sex = dict[@"sex"];
        self.birthday = dict[@"birthday"];
        self.height = dict[@"height"];
        self.age = dict[@"age"];
    }
    return self;
    
}

+ (instancetype)personWithDict:(NSDictionary*)dict {
    return [[self alloc] initWithDict:dict];
}

@end
