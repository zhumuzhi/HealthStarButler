//
//  MEDRefreshDetailsController.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/11.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDBaseViewController.h"

typedef NS_ENUM(NSInteger, MEDRefreshType) {
    MEDRefreshTypeDefault,
    MEDRefreshTypeGif,
    MEDRefreshTypeHiddeTime,
    MEDRefreshTypeOnlyActivityIndicator,
    MEDRefreshTypeHiddeStatusAndTime,
    MEDRefreshTypeCustomText,
    MEDRefreshTypeCustomControl
};

@interface MEDRefreshDetailsController : MEDBaseViewController

@property (nonatomic, assign) MEDRefreshType type;

@end
