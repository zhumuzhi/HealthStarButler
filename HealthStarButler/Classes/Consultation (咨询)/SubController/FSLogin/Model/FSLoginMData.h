//
//  FSLoginMData.h
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSBaseMData.h"
typedef NS_ENUM (NSUInteger,FSLoginCellType) {
    /** 用户名 */
    FSLoginCellTypeUserAcount = 1,
    /** 密码 */
    FSLoginCellTypePassword ,
    /** 验证码 */
    FSLoginCellTypeCode,
    /** 登录 */
    FSLoginCellTypeLogin ,
    /** 忘记密码 */
    FSLoginCellTypeForget,
};
@interface FSLoginMData : FSBaseMData
@property (nonatomic , assign) FSLoginCellType loginCellType;
@property (nonatomic , assign) BOOL enabled;

@property (nonatomic , copy) NSString *code;
@property (nonatomic , copy) NSString *uuid;
//@property (nonatomic , copy) NSString *uuid;
//@property (nonatomic , copy) NSString *code;

- (NSMutableArray *)creatLoginMData;
@end
