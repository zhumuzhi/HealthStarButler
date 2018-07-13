//
//  MZFromModel.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MZFromCellType) {
    MZFromCellTypeIcon = 1, // 头像
    MZFromCellTypeName,     // 姓名
    MZFromCellTypeSex,      // 性别
    MZFromCellTypePhone,    // 电话
    MZFromCellTypeContent,  // 备注
};

@interface MZFromModel : NSObject

@property (nonatomic , copy) NSString *leftTitle;
@property (nonatomic , copy) NSString *imageName;
@property (nonatomic , copy) NSString *rightDetails;
@property (nonatomic , assign) CGFloat cellHeight;
@property (nonatomic , copy) NSString *placeholder;
@property (nonatomic , assign) MZFromCellType cellType;
@property (nonatomic , assign) bool isShowStar;
- (NSMutableArray *)creatFromMData;

@end
