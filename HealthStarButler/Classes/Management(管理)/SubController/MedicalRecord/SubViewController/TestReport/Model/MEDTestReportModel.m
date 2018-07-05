//
//	MEDTestReportModel.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//



#import "MEDTestReportModel.h"

NSString *const kMEDTestReportModelDetectionOrgName = @"detectionOrgName";
NSString *const kMEDTestReportModelDetectionReportFile = @"detectionReportFile";
NSString *const kMEDTestReportModelDetectionReportType = @"detectionReportType";
NSString *const kMEDTestReportModelDetectionTime = @"detectionTime";
NSString *const kMEDTestReportModelDoctorName = @"doctorName";
NSString *const kMEDTestReportModelIdField = @"id";

@interface MEDTestReportModel ()
@end
@implementation MEDTestReportModel

+(instancetype)testReportWithDict:(NSDictionary *)dict
{
    return [[MEDTestReportModel alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMEDTestReportModelDetectionOrgName] isKindOfClass:[NSNull class]]){
		self.detectionOrgName = dictionary[kMEDTestReportModelDetectionOrgName];
	}	
	if(dictionary[kMEDTestReportModelDetectionReportFile] != nil && [dictionary[kMEDTestReportModelDetectionReportFile] isKindOfClass:[NSArray class]]){
		NSArray * detectionReportFileDictionaries = dictionary[kMEDTestReportModelDetectionReportFile];
		NSMutableArray * detectionReportFileItems = [NSMutableArray array];
		for(NSDictionary * detectionReportFileDictionary in detectionReportFileDictionaries){
			MEDDetectionReportFile * detectionReportFileItem = [[MEDDetectionReportFile alloc] initWithDictionary:detectionReportFileDictionary];
			[detectionReportFileItems addObject:detectionReportFileItem];
		}
		self.detectionReportFile = detectionReportFileItems;
	}
	if(![dictionary[kMEDTestReportModelDetectionReportType] isKindOfClass:[NSNull class]]){
		self.detectionReportType = [dictionary[kMEDTestReportModelDetectionReportType] integerValue];
	}

	if(![dictionary[kMEDTestReportModelDetectionTime] isKindOfClass:[NSNull class]]){
		self.detectionTime = dictionary[kMEDTestReportModelDetectionTime];
	}	
	if(![dictionary[kMEDTestReportModelDoctorName] isKindOfClass:[NSNull class]]){
		self.doctorName = dictionary[kMEDTestReportModelDoctorName];
	}	
	if(![dictionary[kMEDTestReportModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMEDTestReportModelIdField] integerValue];
	}

	return self;
}


-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.detectionOrgName != nil){
		dictionary[kMEDTestReportModelDetectionOrgName] = self.detectionOrgName;
	}
	if(self.detectionReportFile != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(MEDDetectionReportFile * detectionReportFileElement in self.detectionReportFile){
			[dictionaryElements addObject:[detectionReportFileElement toDictionary]];
		}
		dictionary[kMEDTestReportModelDetectionReportFile] = dictionaryElements;
	}
	dictionary[kMEDTestReportModelDetectionReportType] = @(self.detectionReportType);
	if(self.detectionTime != nil){
		dictionary[kMEDTestReportModelDetectionTime] = self.detectionTime;
	}
	if(self.doctorName != nil){
		dictionary[kMEDTestReportModelDoctorName] = self.doctorName;
	}
	dictionary[kMEDTestReportModelIdField] = @(self.idField);
	return dictionary;

}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.detectionOrgName != nil){
		[aCoder encodeObject:self.detectionOrgName forKey:kMEDTestReportModelDetectionOrgName];
	}
	if(self.detectionReportFile != nil){
		[aCoder encodeObject:self.detectionReportFile forKey:kMEDTestReportModelDetectionReportFile];
	}
	[aCoder encodeObject:@(self.detectionReportType) forKey:kMEDTestReportModelDetectionReportType];	if(self.detectionTime != nil){
		[aCoder encodeObject:self.detectionTime forKey:kMEDTestReportModelDetectionTime];
	}
	if(self.doctorName != nil){
		[aCoder encodeObject:self.doctorName forKey:kMEDTestReportModelDoctorName];
	}
	[aCoder encodeObject:@(self.idField) forKey:kMEDTestReportModelIdField];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.detectionOrgName = [aDecoder decodeObjectForKey:kMEDTestReportModelDetectionOrgName];
	self.detectionReportFile = [aDecoder decodeObjectForKey:kMEDTestReportModelDetectionReportFile];
	self.detectionReportType = [[aDecoder decodeObjectForKey:kMEDTestReportModelDetectionReportType] integerValue];
	self.detectionTime = [aDecoder decodeObjectForKey:kMEDTestReportModelDetectionTime];
	self.doctorName = [aDecoder decodeObjectForKey:kMEDTestReportModelDoctorName];
	self.idField = [[aDecoder decodeObjectForKey:kMEDTestReportModelIdField] integerValue];
	return self;

}

- (instancetype)copyWithZone:(NSZone *)zone
{
	MEDTestReportModel *copy = [MEDTestReportModel new];

	copy.detectionOrgName = [self.detectionOrgName copyWithZone:zone];
	copy.detectionReportFile = [self.detectionReportFile copyWithZone:zone];
	copy.detectionReportType = self.detectionReportType;
	copy.detectionTime = [self.detectionTime copyWithZone:zone];
	copy.doctorName = [self.doctorName copyWithZone:zone];
	copy.idField = self.idField;

	return copy;
}
@end
