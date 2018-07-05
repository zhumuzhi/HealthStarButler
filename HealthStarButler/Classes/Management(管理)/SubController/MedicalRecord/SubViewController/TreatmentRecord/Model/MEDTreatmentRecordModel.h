//
//	MEDTreatmentRecordModel.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDTreatmentRecordModel : NSObject
@property (nonatomic, assign) NSInteger uid;                    //用户ID
@property (nonatomic, strong) NSString * diagnosisRreatTime;    //就诊时间
@property (nonatomic, strong) NSString * hospitalName;          //就诊机构
@property (nonatomic, assign) NSInteger diagnosisRreatType;     //就诊类别 1门诊，2住院
@property (nonatomic, strong) NSString * departmentName;        //就诊科室
@property (nonatomic, strong) NSString * doctorName;            //诊疗医生
@property (nonatomic, strong) NSString * diagnosisRreatContent; //病情描述

@property (nonatomic, assign) NSInteger doctorId;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger delFlag;

+ (instancetype)treatmentRecordWithDictionary:(NSDictionary *)dict;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
