//
//  FSMineNormalCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  设置/客服/缓存Cell

#import <UIKit/UIKit.h>

@class FSMineNormalCell, FSMineMData;
@protocol FSMineNormalCellDelegate <NSObject>
@optional
//- (void)<#loginViewControllerDidSuccess#>:(<#Class#> *)<#obj#>;

@end

@interface FSMineNormalCell : UITableViewCell

@property(nonatomic, weak) id<FSMineNormalCellDelegate> delegate;

@property (nonatomic, strong) FSMineMData *mineMData;

@end
