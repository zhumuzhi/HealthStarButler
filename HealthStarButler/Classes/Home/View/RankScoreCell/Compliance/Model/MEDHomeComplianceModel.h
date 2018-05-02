//
//  MEDHomeComplianceModel.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/15.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDHomeComplianceModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSNumber *complete;
@property (nonatomic, assign) NSNumber *frequency;

@property (nonatomic, assign) NSNumber *isfinish;

+ (instancetype)complianceWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
