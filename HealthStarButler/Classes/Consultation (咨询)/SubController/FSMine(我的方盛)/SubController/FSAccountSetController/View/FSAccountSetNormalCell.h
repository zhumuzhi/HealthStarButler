//
//  FSAccountSetNormalCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAccountSetMData.h"

@class FSAccountSetMData,FSAccountSetNormalCell;
@protocol FSAccountSetNormalCellDelegate <NSObject>
@optional
- (void)accountSetNormalCell:(FSAccountSetNormalCell*)accountCell dataModel:(FSAccountSetMData *)dataModel acountSetType:(FSAcountSetType)acountSetType;
@end

@interface FSAccountSetNormalCell : UITableViewCell

@property (nonatomic, strong) FSAccountSetMData *accoutSetMData;
@property(nonatomic, weak) id<FSAccountSetNormalCellDelegate> delegate;

@end
