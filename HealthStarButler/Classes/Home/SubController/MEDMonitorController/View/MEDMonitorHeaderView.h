//
//  MEDMonitorHeaderView.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDMonitorHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *dateTitle;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIImageView *historyIndicator;

typedef void(^HistoryButtonClick)(void);
@property (nonatomic, copy) HistoryButtonClick hisToryButtonClick;

+(instancetype)monitorHeaderViewWithTableView:(UITableView *)table;

- (void)setHeadTitle:(NSString *)titleName;

@end
