//
//  FSAddressListController.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 跳转来源类型 */
typedef NS_ENUM (NSUInteger, FSAddressListJempSourceType) {
    /** 来源: 个人中心 */
    FSAddressListJempSourceTypeMe = 1,
    /** 来源: 确认订单 */
    FSAddressListJempSourceTypeOrder ,
};


@interface FSAddressListController : UIViewController

@end

