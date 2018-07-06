//
//  GHFromModel.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, GHFromCellType) {
    /** 头像 */
    GHFromCellType_icon,
    /** 姓名 */
    GHFromCellType_name,
    /** 性别 */
    GHFromCellType_sex,
    /** 电话号码 */
    GHFromCellType_phone,
    /** 备注 */
    GHFromCellType_content
};

@interface GHFromModel : NSObject

@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, assign) NSInteger cellHeight;
@property (nonatomic, assign) GHFromCellType cellType;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) NSInteger isShowStar;

@end









