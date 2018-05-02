//
//  MEDHomePhysiologyModel.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDHomePhysiologyModel : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * actualValue;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSString * suggestValue;

+(instancetype)physiologyWithDict:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)toDictionary;

@end
