//
//  MEDCompanyRankHeadView.h
//  健康之星管家
//
//  Created by 朱慕之 on 2017/8/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEDCompanyRankModel;
@interface MEDCompanyRankHeadView : UIView
+ (instancetype)rankHeadView;

@property (nonatomic, strong) MEDCompanyRankModel *rankModel;
@end
