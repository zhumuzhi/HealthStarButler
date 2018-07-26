//
//  MEDCategoryModel.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSArray *spus;

@end

@interface MEDFoodModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *foodId;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, assign) NSInteger praise_content;
@property (nonatomic, assign) NSInteger month_saled;
@property (nonatomic, assign) float min_price;

@end

