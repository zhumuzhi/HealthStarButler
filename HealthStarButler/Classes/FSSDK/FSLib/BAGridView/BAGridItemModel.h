/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSUInteger,BAGridItemModelType) {
    BAGridItemModelTypeCategory = 1,
    BAGridItemModelTypeMore,

};
@interface BAGridItemModel : NSObject
@property (nonatomic , assign) NSInteger index;

@property (nonatomic , copy) NSString *category_code;
@property (nonatomic , assign) NSInteger category_id;
@property (nonatomic , assign) NSInteger category_level;
@property (nonatomic , copy) NSString *category_name;
@property(nonatomic, copy) NSString *imageName;
@property(nonatomic, copy) NSString *titleString;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, assign) BAGridItemModelType gridItemModelType;

@end
