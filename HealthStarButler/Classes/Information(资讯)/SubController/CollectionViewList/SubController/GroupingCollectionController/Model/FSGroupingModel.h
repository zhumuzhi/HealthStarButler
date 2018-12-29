//
//  FSGroupingModel.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/29.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSGroupingModel : NSObject

/** 品牌索引 */
@property (nonatomic, copy) NSString *brandKey;
/** 二级组 */
@property (nonatomic, strong) NSMutableArray *items;
//---- NSArray ---->
/** 商品id */
@property (nonatomic, copy) NSString *itemId;
/** 首字母 */
@property (nonatomic, copy) NSString *first_letter;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 图片id */
@property (nonatomic, strong) NSNumber *pic_id;
/** 品牌 */
@property (nonatomic, strong) NSNumber *is_car_brand;

@end

NS_ASSUME_NONNULL_END
