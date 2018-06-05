//
//	MEDDetectionReportFile.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDDetectionReportFile : NSObject

@property (nonatomic, assign) NSInteger drfId;
@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSString * filePath;
@property (nonatomic, strong) NSString * uploadFileTime;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
