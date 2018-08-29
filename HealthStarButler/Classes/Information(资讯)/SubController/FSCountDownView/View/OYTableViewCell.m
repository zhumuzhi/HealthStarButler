//
//  TableViewCell.m
//  CellCountDown
//
//  Created by herobin on 16/9/11.
//  Copyright © 2016年 herobin. All rights reserved.
//

#import "OYTableViewCell.h"
#import "OYCountDownManager.h"
#import "OYModel.h"
NSString *const OYTableViewCellID = @"OYTableViewCell";

@interface OYTableViewCell ()

@end

@implementation OYTableViewCell

// 代码创建
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
    }
    return self;
}

// xib创建
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
    }
    return self;
}

#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    if (0) {
        return;
    }
    /// 计算倒计时
    OYModel *model = self.model;
    NSInteger timeInterval;
    if (model.countDownSource) {
        timeInterval = [kCountDownManager timeIntervalWithIdentifier:model.countDownSource];
    }else {
        timeInterval = kCountDownManager.timeInterval;
    }
    NSInteger countDown = model.count - timeInterval;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        self.detailTextLabel.text = @"活动开始";
        // 回调给控制器
        if (self.countDownZero) {
            self.countDownZero(model);
        }
        return;
    }

    NSInteger d = countDown/60/60/24;
    NSInteger h = countDown/60/60%24;
    NSInteger m = countDown/60%60;
    NSInteger s = countDown%60;

    NSString *dStr = @"0";
    if (d>0) {
        dStr = [NSString stringWithFormat:@"%zd", d];
    }

    NSString *hStr = @"0"; //%02zd
    hStr = [NSString stringWithFormat:@"%02zd", h];

    NSString *mStr = @"0";
    mStr = [NSString stringWithFormat:@"%02zd", m];

    NSString *sStr = @"0";
    sStr = [NSString stringWithFormat:@"%02zd", s];

    /// 重新赋值
    self.detailTextLabel.text = [NSString stringWithFormat:@"请在%@天:%@时:%@分:%@秒内完成支付", dStr, hStr, mStr, sStr];

    self.detailTextLabel.textColor = [UIColor orangeColor];
}

///  重写setter方法
- (void)setModel:(OYModel *)model {
    _model = model;
    
    self.textLabel.text = model.title;
    // 手动刷新数据
    [self countDownNotification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
