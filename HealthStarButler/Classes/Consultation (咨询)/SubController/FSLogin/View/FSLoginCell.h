//
//  FSLoginCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/14.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSLoginMData;
@class FSLoginCell;

@protocol FSLoginCellDelegate <NSObject>
@optional
- (void)FSLoginCellDelegateDidClick:(FSLoginCell *)loginCell;
@end

@interface FSLoginCell : UITableViewCell
@property (nonatomic, strong) FSLoginMData *rowMData;
@property(nonatomic, weak) id<FSLoginCellDelegate> delegate;
@end
