//
//  MEDMonitorHeaderView.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDMonitorHeaderView.h"


@interface MEDMonitorHeaderView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateTitleConst;

@end

@implementation MEDMonitorHeaderView

+(instancetype)monitorHeaderViewWithTableView:(UITableView *)table {
    return [[[NSBundle mainBundle] loadNibNamed:@"MEDMonitorHeaderView" owner:nil options:nil] lastObject];
}

- (void)setDateTitle:(UILabel *)dateTitle {
    _dateTitle = dateTitle;
    _dateTitle.layer.cornerRadius = _dateTitle.height*0.5;
    _dateTitle.layer.borderWidth = 1.5;
    _dateTitle.layer.borderColor = MEDCommonBlue.CGColor;
    _dateTitle.clipsToBounds = YES;
}

- (void)setHeadTitle:(NSString *)titleName {
    
    NSDateFormatter* defaultFormat = [[NSDateFormatter alloc] init];
    defaultFormat.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [defaultFormat dateFromString:titleName];
    defaultFormat.dateFormat = @"MM月yyyy";
    NSString *currDateStr = [defaultFormat stringFromDate:[NSDate date]];
    NSString *showdateStr = [defaultFormat stringFromDate:date];
    if ([showdateStr isEqualToString:currDateStr]) {
        showdateStr = @"本月";
    }
    
    self.dateTitle.text = showdateStr;

    CGSize dateStringSize = [_dateTitle.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, _dateTitle.height) lineBreakMode:NSLineBreakByWordWrapping];
        self.dateTitleConst.constant = dateStringSize.width+40;
}

//历史按钮点击
- (IBAction)historyButtonClick:(id)sender {
    
    self.historyButton.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:0.5f];
    
    if (self.hisToryButtonClick) {
        self.hisToryButtonClick();
    }
}

-(void)changeButtonStatus{
    self.historyButton.enabled =YES;
}


@end
