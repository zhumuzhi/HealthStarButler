//
//  MEDScoreOperationView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/2.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDScoreOperationView : UIView

@property (nonatomic, copy) void (^rankBtnClicked)(UIButton *button);

@end
