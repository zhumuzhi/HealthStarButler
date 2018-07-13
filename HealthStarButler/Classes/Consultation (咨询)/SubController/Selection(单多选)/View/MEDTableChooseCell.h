//
//  MEDTableChooseCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDTableChooseCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectIconBtn;
@property (nonatomic, assign) BOOL isSelected;
/** 刷新状态 */
- (void)updateCellWithState:(BOOL)select;

@end


