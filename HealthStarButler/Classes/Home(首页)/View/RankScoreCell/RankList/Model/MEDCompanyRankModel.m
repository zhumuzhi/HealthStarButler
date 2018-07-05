//
//  MEDCompanyRankingController.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/8/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDCompanyRankModel.h"

NSString *const kMEDCompanyRankModelCompliance = @"compliance";
NSString *const kMEDCompanyRankModelCreateTime = @"createTime";
NSString *const kMEDCompanyRankModelCurrentUser = @"currentUser";
NSString *const kMEDCompanyRankModelHabitsAndCustoms = @"habitsAndCustoms";
NSString *const kMEDCompanyRankModelIcon = @"icon";
NSString *const kMEDCompanyRankModelMonth = @"month";
NSString *const kMEDCompanyRankModelName = @"name";
NSString *const kMEDCompanyRankModelOrgId = @"orgId";
NSString *const kMEDCompanyRankModelOrgName = @"orgName";
NSString *const kMEDCompanyRankModelPersonalTotalScore = @"personalTotalScore";
NSString *const kMEDCompanyRankModelPhysiologicalIndexMonitoring = @"physiologicalIndexMonitoring";
NSString *const kMEDCompanyRankModelQuarter = @"quarter";
NSString *const kMEDCompanyRankModelRanking = @"ranking";
NSString *const kMEDCompanyRankModelUid = @"uid";
NSString *const kMEDCompanyRankModelVariationTrend = @"variationTrend";
NSString *const kMEDCompanyRankModelYear = @"year";

@interface MEDCompanyRankModel ()
@end
@implementation MEDCompanyRankModel

+(instancetype)rankModelinitWithDictionary:(NSDictionary *)dict {
    return [[MEDCompanyRankModel alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMEDCompanyRankModelCompliance] isKindOfClass:[NSNull class]]){
		self.compliance = [dictionary[kMEDCompanyRankModelCompliance] doubleValue];
	}

	if(![dictionary[kMEDCompanyRankModelCreateTime] isKindOfClass:[NSNull class]]){
		self.createTime = dictionary[kMEDCompanyRankModelCreateTime];
	}	
	if(![dictionary[kMEDCompanyRankModelCurrentUser] isKindOfClass:[NSNull class]]){
		self.currentUser = [dictionary[kMEDCompanyRankModelCurrentUser] boolValue];
	}

	if(![dictionary[kMEDCompanyRankModelHabitsAndCustoms] isKindOfClass:[NSNull class]]){
		self.habitsAndCustoms = [dictionary[kMEDCompanyRankModelHabitsAndCustoms] doubleValue];
	}

	if(![dictionary[kMEDCompanyRankModelIcon] isKindOfClass:[NSNull class]]){
		self.icon = dictionary[kMEDCompanyRankModelIcon];
	}	
	if(![dictionary[kMEDCompanyRankModelMonth] isKindOfClass:[NSNull class]]){
		self.month = dictionary[kMEDCompanyRankModelMonth];
	}	
	if(![dictionary[kMEDCompanyRankModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kMEDCompanyRankModelName];
	}	
	if(![dictionary[kMEDCompanyRankModelOrgId] isKindOfClass:[NSNull class]]){
		self.orgId = [dictionary[kMEDCompanyRankModelOrgId] integerValue];
	}

	if(![dictionary[kMEDCompanyRankModelOrgName] isKindOfClass:[NSNull class]]){
		self.orgName = dictionary[kMEDCompanyRankModelOrgName];
	}	
	if(![dictionary[kMEDCompanyRankModelPersonalTotalScore] isKindOfClass:[NSNull class]]){
		self.personalTotalScore = [dictionary[kMEDCompanyRankModelPersonalTotalScore] floatValue];
	}

	if(![dictionary[kMEDCompanyRankModelPhysiologicalIndexMonitoring] isKindOfClass:[NSNull class]]){
		self.physiologicalIndexMonitoring = [dictionary[kMEDCompanyRankModelPhysiologicalIndexMonitoring] doubleValue];
	}

	if(![dictionary[kMEDCompanyRankModelQuarter] isKindOfClass:[NSNull class]]){
		self.quarter = dictionary[kMEDCompanyRankModelQuarter];
	}	
	if(![dictionary[kMEDCompanyRankModelRanking] isKindOfClass:[NSNull class]]){
		self.ranking = [dictionary[kMEDCompanyRankModelRanking] integerValue];
	}

	if(![dictionary[kMEDCompanyRankModelUid] isKindOfClass:[NSNull class]]){
		self.uid = [dictionary[kMEDCompanyRankModelUid] integerValue];
	}

	if(![dictionary[kMEDCompanyRankModelVariationTrend] isKindOfClass:[NSNull class]]){
		self.variationTrend = [dictionary[kMEDCompanyRankModelVariationTrend] integerValue];
	}

	if(![dictionary[kMEDCompanyRankModelYear] isKindOfClass:[NSNull class]]){
		self.year = dictionary[kMEDCompanyRankModelYear];
	}	
	return self;
}

-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMEDCompanyRankModelCompliance] = @(self.compliance);
	if(self.createTime != nil){
		dictionary[kMEDCompanyRankModelCreateTime] = self.createTime;
	}
	dictionary[kMEDCompanyRankModelCurrentUser] = @(self.currentUser);
	dictionary[kMEDCompanyRankModelHabitsAndCustoms] = @(self.habitsAndCustoms);
	if(self.icon != nil){
		dictionary[kMEDCompanyRankModelIcon] = self.icon;
	}
	if(self.month != nil){
		dictionary[kMEDCompanyRankModelMonth] = self.month;
	}
	if(self.name != nil){
		dictionary[kMEDCompanyRankModelName] = self.name;
	}
	dictionary[kMEDCompanyRankModelOrgId] = @(self.orgId);
	if(self.orgName != nil){
		dictionary[kMEDCompanyRankModelOrgName] = self.orgName;
	}
	dictionary[kMEDCompanyRankModelPersonalTotalScore] = @(self.personalTotalScore);
	dictionary[kMEDCompanyRankModelPhysiologicalIndexMonitoring] = @(self.physiologicalIndexMonitoring);
	if(self.quarter != nil){
		dictionary[kMEDCompanyRankModelQuarter] = self.quarter;
	}
	dictionary[kMEDCompanyRankModelRanking] = @(self.ranking);
	dictionary[kMEDCompanyRankModelUid] = @(self.uid);
	dictionary[kMEDCompanyRankModelVariationTrend] = @(self.variationTrend);
	if(self.year != nil){
		dictionary[kMEDCompanyRankModelYear] = self.year;
	}
	return dictionary;

}

@end
