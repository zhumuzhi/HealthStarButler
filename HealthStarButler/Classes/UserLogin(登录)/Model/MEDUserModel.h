//
//  MEDUserModel.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDUserModel : NSObject 
/** uid */
@property (nonatomic, copy) NSString *uid;
/** 用户名 */
@property (nonatomic, copy) NSString *user_name;
/** 用户状态 */
@property (nonatomic, assign) NSInteger user_status;
/** 身高 */
@property (nonatomic, assign) CGFloat height;
/** 体重 */
@property (nonatomic, assign) CGFloat weight;
/** 年纪 */
@property (nonatomic, assign) NSInteger age;
/** 性别 */
@property (nonatomic, assign) NSInteger sex;
/** 设备id */
@property (nonatomic, copy) NSString *deviceid;
/** 是否回答问卷 */
@property (nonatomic, assign) NSInteger firstQuestion;
/** 头像url */
@property (nonatomic, copy) NSString *userPhoto;
/** 体检编号 */
@property (nonatomic, copy) NSString *medicalExmnum;
/** 是否首次登录 */
@property (nonatomic, assign) NSInteger first_login;
/** 机构/组织list */
@property (nonatomic, strong) NSArray *orga_list;
/** 是否商业用户 */
@property (nonatomic, assign) NSInteger businessUser;

@property (nonatomic, copy) NSString *myId;

/** UserModel的单例方法 */
+ (instancetype)sharedUserModel;

@end
