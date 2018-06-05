//
//	MEDDetectionReportFile.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import "MEDDetectionReportFile.h"

NSString *const kMEDDetectionReportFileDrfId = @"drfId";
NSString *const kMEDDetectionReportFileFileName = @"fileName";
NSString *const kMEDDetectionReportFileFilePath = @"filePath";
NSString *const kMEDDetectionReportFileUploadFileTime = @"uploadFileTime";

@interface MEDDetectionReportFile ()
@end
@implementation MEDDetectionReportFile

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMEDDetectionReportFileDrfId] isKindOfClass:[NSNull class]]){
		self.drfId = [dictionary[kMEDDetectionReportFileDrfId] integerValue];
	}

	if(![dictionary[kMEDDetectionReportFileFileName] isKindOfClass:[NSNull class]]){
		self.fileName = dictionary[kMEDDetectionReportFileFileName];
	}	
	if(![dictionary[kMEDDetectionReportFileFilePath] isKindOfClass:[NSNull class]]){
		self.filePath = dictionary[kMEDDetectionReportFileFilePath];
	}	
	if(![dictionary[kMEDDetectionReportFileUploadFileTime] isKindOfClass:[NSNull class]]){
		self.uploadFileTime = dictionary[kMEDDetectionReportFileUploadFileTime];
	}	
	return self;
}


-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMEDDetectionReportFileDrfId] = @(self.drfId);
	if(self.fileName != nil){
		dictionary[kMEDDetectionReportFileFileName] = self.fileName;
	}
	if(self.filePath != nil){
		dictionary[kMEDDetectionReportFileFilePath] = self.filePath;
	}
	if(self.uploadFileTime != nil){
		dictionary[kMEDDetectionReportFileUploadFileTime] = self.uploadFileTime;
	}
	return dictionary;

}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.drfId) forKey:kMEDDetectionReportFileDrfId];	if(self.fileName != nil){
		[aCoder encodeObject:self.fileName forKey:kMEDDetectionReportFileFileName];
	}
	if(self.filePath != nil){
		[aCoder encodeObject:self.filePath forKey:kMEDDetectionReportFileFilePath];
	}
	if(self.uploadFileTime != nil){
		[aCoder encodeObject:self.uploadFileTime forKey:kMEDDetectionReportFileUploadFileTime];
	}

}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.drfId = [[aDecoder decodeObjectForKey:kMEDDetectionReportFileDrfId] integerValue];
	self.fileName = [aDecoder decodeObjectForKey:kMEDDetectionReportFileFileName];
	self.filePath = [aDecoder decodeObjectForKey:kMEDDetectionReportFileFilePath];
	self.uploadFileTime = [aDecoder decodeObjectForKey:kMEDDetectionReportFileUploadFileTime];
	return self;

}


- (instancetype)copyWithZone:(NSZone *)zone
{
	MEDDetectionReportFile *copy = [MEDDetectionReportFile new];

	copy.drfId = self.drfId;
	copy.fileName = [self.fileName copyWithZone:zone];
	copy.filePath = [self.filePath copyWithZone:zone];
	copy.uploadFileTime = [self.uploadFileTime copyWithZone:zone];

	return copy;
}
@end
