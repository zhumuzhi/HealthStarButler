//
//  MEDShopCartModel.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/22.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDShopCartModel : NSObject

@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int count;

@end
