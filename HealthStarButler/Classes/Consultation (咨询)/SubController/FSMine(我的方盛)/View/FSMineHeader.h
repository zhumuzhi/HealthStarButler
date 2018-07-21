//
//  FSMineAcountHeader.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, FSMineHeaderType) {
    /** HeaderView */
    FSMineHeaderTypeHeader = 1,
    //预留类型 /** 头像 */ /** 账号 */ /** 权限 */
};

@class FSMineHeader, FSMineMData;
@protocol FSMineHeaderDelegate <NSObject>
@optional

/**
 个人中心Header代理方法 MineHeaderViewDelegate Method
 @param mineHeader 个人中心Header
 @param mineModel 个人中心Header模型
 @param type 点击控件类型
 */
- (void)mineHeader:(FSMineHeader *)mineHeader mineModel:(FSMineMData *)mineModel type:(FSMineHeaderType)type;
@end


@interface FSMineHeader : UIView

@property (nonatomic, strong) FSMineMData *mineMData;
@property(nonatomic, weak) id<FSMineHeaderDelegate> delegate;

@end
