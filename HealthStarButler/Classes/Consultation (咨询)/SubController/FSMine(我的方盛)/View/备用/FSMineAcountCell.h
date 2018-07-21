//
//  FSMineAcountCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/19.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  账户Cell

#import <UIKit/UIKit.h>
@class FSMineAcountCell, FSMineMData;

@protocol FSMineAcountCellDelegate <NSObject>
@optional
//-(void)<#MethodName#>:(<#Class#> *)<#obj#>;
@end

@interface FSMineAcountCell : UITableViewCell

@property (nonatomic, strong) FSMineMData *mineMData;
@property(nonatomic, weak) id<FSMineAcountCellDelegate> delegate;



@end
