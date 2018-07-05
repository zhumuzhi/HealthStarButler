//
//	MEDTestReportModel.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEDDetectionReportFile.h"

@interface MEDTestReportModel : NSObject

@property (nonatomic, strong) NSString * detectionTime; //检测时间
@property (nonatomic, assign) NSInteger detectionReportType; //检测类别
@property (nonatomic, strong) NSString * detectionOrgName;   //检测机构
@property (nonatomic, strong) NSString * doctorName;         //医生姓名
@property (nonatomic, strong) NSArray * detectionReportFile; //报告文件(图片)
@property (nonatomic, assign) NSInteger idField;             //检测报告ID

+(instancetype)testReportWithDict:(NSDictionary *)dict;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
