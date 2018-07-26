//
//  MEDCategoryModel.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDCategoryModel.h"

@implementation MEDCategoryModel

+ (NSDictionary *)objectClassInArray {
    return @{@"spus":@"MEDFoodModel"};
}

@end

@implementation MEDFoodModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"foodId":@"id"};
}

@end
