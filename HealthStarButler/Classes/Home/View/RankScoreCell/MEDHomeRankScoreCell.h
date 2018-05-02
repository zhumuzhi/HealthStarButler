//
//  MEDHomeRankScoreCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/26.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDHomeRankScoreCell : UITableViewCell

@property (nonatomic, copy) void (^rankBtnClicked)(UIButton *button);

//设置数据的模型
@property (nonatomic, strong) NSArray *cellData;

+ (instancetype)homerankScoreCellWithTableView:(UITableView *)tableView;

@end

