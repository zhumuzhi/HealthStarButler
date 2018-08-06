//
//  FSCornerRadiusCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSCornerRadiusCell : UITableViewCell
//+ (instancetype)cornerCellWithTableView:(UITableView *)tableView;
+ (instancetype)cornerCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
