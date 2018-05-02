//
//  MEDCompanyRankingController.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/8/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDCompanyRankModel : NSObject

@property (nonatomic, assign) double compliance;
@property (nonatomic, strong) NSObject * createTime;
@property (nonatomic, assign) BOOL currentUser;
@property (nonatomic, assign) double habitsAndCustoms;
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, strong) NSObject * month;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger orgId;
@property (nonatomic, strong) NSString * orgName;
@property (nonatomic, assign) CGFloat personalTotalScore;
@property (nonatomic, assign) double physiologicalIndexMonitoring;
@property (nonatomic, strong) NSObject * quarter;
@property (nonatomic, assign) NSInteger ranking;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger variationTrend;
@property (nonatomic, strong) NSObject * year;

+(instancetype)rankModelinitWithDictionary:(NSDictionary *)dict;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
