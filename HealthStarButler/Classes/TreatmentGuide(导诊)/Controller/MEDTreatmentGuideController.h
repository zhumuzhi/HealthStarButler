//
//  MEDTreatmentGuideController.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEDTwoTableView.h"
@interface MEDTreatmentGuideController : MEDBaseViewController

@property (nonatomic, strong) MEDTwoTableView *twoTable;

- (void)reInitIntellectGuidance;

@end
