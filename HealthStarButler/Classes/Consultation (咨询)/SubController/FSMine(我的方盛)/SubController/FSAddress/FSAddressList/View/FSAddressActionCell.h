//
//  FSAddressActionCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/12.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
/** cell的按钮事件 */
typedef NS_ENUM (NSUInteger,FSAddressActionCellButtonType) {
    /** 设为默认 */
    FSAddressActionCellButtonTypeDefault = 1,
    /** 编辑 */
    FSAddressActionCellButtonTypeEdit ,
};

@class FSAddressActionCell, FSAddressListMData;

@protocol FSAddressActionCellDelegate <NSObject>
@optional
- (void)addressActionCell:(FSAddressActionCell *)cell addressListMData:(FSAddressListMData *)rowMData buttonType:(FSAddressActionCellButtonType)buttonTYpe;
@end

/** 操作cell */
@interface FSAddressActionCell : UITableViewCell

@property (nonatomic, strong) FSAddressListMData *rowMData;
@property(nonatomic, weak) id<FSAddressActionCellDelegate> delegate;

@end

