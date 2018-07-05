//
//  MEDPersonalDataModel.h
//  健康之星管家
//
//  Created by 朱慕之 on 2016/12/12.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDPersonalDataModel : NSObject

@property (nonatomic, copy) NSString *user_id;    //user_id
@property (nonatomic, copy) NSString *userPhoto;  //头像
@property (nonatomic, copy) NSString *user_name;  //用户名
@property (nonatomic, assign) NSNumber *sex;      //性别     1男 2女
@property (nonatomic, copy) NSString *birthday;   //生日
@property (nonatomic, strong) NSNumber *height;   //身高
@property (nonatomic, strong) NSNumber *age;      //年龄

- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)personWithDict:(NSDictionary*)dict;

@end
