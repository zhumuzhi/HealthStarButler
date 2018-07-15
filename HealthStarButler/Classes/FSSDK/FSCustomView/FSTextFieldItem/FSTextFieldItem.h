//
//  FSTextFieldItem.h
//  FangShengyun
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSUInteger,FSTextFieldItemType) {
    FSTextFieldItemTypeLeft = 1,
    FSTextFieldItemTypeRight,

};
@interface FSTextFieldItem : UIView
+ (FSTextFieldItem *)creatTextFieldItemWithFrame:(CGRect)frame normalImageName: (NSString *)normalImageName seletedImageName: (NSString *)seletedImageName
                                        itemType: (FSTextFieldItemType)itemType;
@end
