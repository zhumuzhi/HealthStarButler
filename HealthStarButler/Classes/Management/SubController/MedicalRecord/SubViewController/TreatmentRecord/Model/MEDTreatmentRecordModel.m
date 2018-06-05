//
//	MEDTreatmentRecordModel.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import "MEDTreatmentRecordModel.h"

NSString *const kMEDTreatmentRecordModelDelFlag = @"delFlag";
NSString *const kMEDTreatmentRecordModelDepartmentName = @"departmentName";
NSString *const kMEDTreatmentRecordModelDiagnosisRreatContent = @"diagnosisRreatContent";
NSString *const kMEDTreatmentRecordModelDiagnosisRreatTime = @"diagnosisRreatTime";
NSString *const kMEDTreatmentRecordModelDiagnosisRreatType = @"diagnosisRreatType";
NSString *const kMEDTreatmentRecordModelDoctorId = @"doctorId";
NSString *const kMEDTreatmentRecordModelDoctorName = @"doctorName";
NSString *const kMEDTreatmentRecordModelHospitalName = @"hospitalName";
NSString *const kMEDTreatmentRecordModelIdField = @"id";
NSString *const kMEDTreatmentRecordModelUid = @"uid";

@interface MEDTreatmentRecordModel ()
@end
@implementation MEDTreatmentRecordModel


+ (instancetype)treatmentRecordWithDictionary:(NSDictionary *)dict
{
    return [[MEDTreatmentRecordModel alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMEDTreatmentRecordModelDelFlag] isKindOfClass:[NSNull class]]){
		self.delFlag = [dictionary[kMEDTreatmentRecordModelDelFlag] integerValue];
	}

	if(![dictionary[kMEDTreatmentRecordModelDepartmentName] isKindOfClass:[NSNull class]]){
		self.departmentName = dictionary[kMEDTreatmentRecordModelDepartmentName];
	}	
	if(![dictionary[kMEDTreatmentRecordModelDiagnosisRreatContent] isKindOfClass:[NSNull class]]){
		self.diagnosisRreatContent = dictionary[kMEDTreatmentRecordModelDiagnosisRreatContent];
	}	
	if(![dictionary[kMEDTreatmentRecordModelDiagnosisRreatTime] isKindOfClass:[NSNull class]]){
		self.diagnosisRreatTime = dictionary[kMEDTreatmentRecordModelDiagnosisRreatTime];
	}	
	if(![dictionary[kMEDTreatmentRecordModelDiagnosisRreatType] isKindOfClass:[NSNull class]]){
		self.diagnosisRreatType = [dictionary[kMEDTreatmentRecordModelDiagnosisRreatType] integerValue];
	}

	if(![dictionary[kMEDTreatmentRecordModelDoctorId] isKindOfClass:[NSNull class]]){
		self.doctorId = [dictionary[kMEDTreatmentRecordModelDoctorId] integerValue];
	}

	if(![dictionary[kMEDTreatmentRecordModelDoctorName] isKindOfClass:[NSNull class]]){
		self.doctorName = dictionary[kMEDTreatmentRecordModelDoctorName];
	}	
	if(![dictionary[kMEDTreatmentRecordModelHospitalName] isKindOfClass:[NSNull class]]){
		self.hospitalName = dictionary[kMEDTreatmentRecordModelHospitalName];
	}	
	if(![dictionary[kMEDTreatmentRecordModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMEDTreatmentRecordModelIdField] integerValue];
	}

	if(![dictionary[kMEDTreatmentRecordModelUid] isKindOfClass:[NSNull class]]){
		self.uid = [dictionary[kMEDTreatmentRecordModelUid] integerValue];
	}

	return self;
}

-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMEDTreatmentRecordModelDelFlag] = @(self.delFlag);
	if(self.departmentName != nil){
		dictionary[kMEDTreatmentRecordModelDepartmentName] = self.departmentName;
	}
	if(self.diagnosisRreatContent != nil){
		dictionary[kMEDTreatmentRecordModelDiagnosisRreatContent] = self.diagnosisRreatContent;
	}
	if(self.diagnosisRreatTime != nil){
		dictionary[kMEDTreatmentRecordModelDiagnosisRreatTime] = self.diagnosisRreatTime;
	}
	dictionary[kMEDTreatmentRecordModelDiagnosisRreatType] = @(self.diagnosisRreatType);
	dictionary[kMEDTreatmentRecordModelDoctorId] = @(self.doctorId);
	if(self.doctorName != nil){
		dictionary[kMEDTreatmentRecordModelDoctorName] = self.doctorName;
	}
	if(self.hospitalName != nil){
		dictionary[kMEDTreatmentRecordModelHospitalName] = self.hospitalName;
	}
	dictionary[kMEDTreatmentRecordModelIdField] = @(self.idField);
	dictionary[kMEDTreatmentRecordModelUid] = @(self.uid);
	return dictionary;

}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.delFlag) forKey:kMEDTreatmentRecordModelDelFlag];	if(self.departmentName != nil){
		[aCoder encodeObject:self.departmentName forKey:kMEDTreatmentRecordModelDepartmentName];
	}
	if(self.diagnosisRreatContent != nil){
		[aCoder encodeObject:self.diagnosisRreatContent forKey:kMEDTreatmentRecordModelDiagnosisRreatContent];
	}
	if(self.diagnosisRreatTime != nil){
		[aCoder encodeObject:self.diagnosisRreatTime forKey:kMEDTreatmentRecordModelDiagnosisRreatTime];
	}
	[aCoder encodeObject:@(self.diagnosisRreatType) forKey:kMEDTreatmentRecordModelDiagnosisRreatType];	[aCoder encodeObject:@(self.doctorId) forKey:kMEDTreatmentRecordModelDoctorId];	if(self.doctorName != nil){
		[aCoder encodeObject:self.doctorName forKey:kMEDTreatmentRecordModelDoctorName];
	}
	if(self.hospitalName != nil){
		[aCoder encodeObject:self.hospitalName forKey:kMEDTreatmentRecordModelHospitalName];
	}
	[aCoder encodeObject:@(self.idField) forKey:kMEDTreatmentRecordModelIdField];	[aCoder encodeObject:@(self.uid) forKey:kMEDTreatmentRecordModelUid];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.delFlag = [[aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDelFlag] integerValue];
	self.departmentName = [aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDepartmentName];
	self.diagnosisRreatContent = [aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDiagnosisRreatContent];
	self.diagnosisRreatTime = [aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDiagnosisRreatTime];
	self.diagnosisRreatType = [[aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDiagnosisRreatType] integerValue];
	self.doctorId = [[aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDoctorId] integerValue];
	self.doctorName = [aDecoder decodeObjectForKey:kMEDTreatmentRecordModelDoctorName];
	self.hospitalName = [aDecoder decodeObjectForKey:kMEDTreatmentRecordModelHospitalName];
	self.idField = [[aDecoder decodeObjectForKey:kMEDTreatmentRecordModelIdField] integerValue];
	self.uid = [[aDecoder decodeObjectForKey:kMEDTreatmentRecordModelUid] integerValue];
	return self;

}

- (instancetype)copyWithZone:(NSZone *)zone
{
	MEDTreatmentRecordModel *copy = [MEDTreatmentRecordModel new];

	copy.delFlag = self.delFlag;
	copy.departmentName = [self.departmentName copyWithZone:zone];
	copy.diagnosisRreatContent = [self.diagnosisRreatContent copyWithZone:zone];
	copy.diagnosisRreatTime = [self.diagnosisRreatTime copyWithZone:zone];
	copy.diagnosisRreatType = self.diagnosisRreatType;
	copy.doctorId = self.doctorId;
	copy.doctorName = [self.doctorName copyWithZone:zone];
	copy.hospitalName = [self.hospitalName copyWithZone:zone];
	copy.idField = self.idField;
	copy.uid = self.uid;

	return copy;
}
@end
