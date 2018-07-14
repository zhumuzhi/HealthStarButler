//
//  NSMutableAttributedString+Add.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const NSImageAttributeName;  //图片，传UIImage
FOUNDATION_EXTERN NSString *const NSImageBoundsAttributeName; //图片尺寸

@interface NSMutableAttributedString (Add)

- (NSMutableAttributedString *(^)(NSString *))addStr;

- (NSMutableAttributedString *(^)(NSString *,NSDictionary <NSString *,id > *))add;

@end



