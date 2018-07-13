//
//  MZFromCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZFromModel, MZFromCell;

@protocol MZFromCellDelegate <NSObject>
@optional
- (void)fromCell:(MZFromCell *)fromCell fromModel: (MZFromModel *)GHFromModel;

@end

@interface MZFromCell : UITableViewCell

@property (nonatomic, strong) MZFromModel *fromModel;
@property (nonatomic,weak) id<MZFromCellDelegate> delegate;

@end
