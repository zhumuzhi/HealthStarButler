//
//  FSChoseZoneViewController.h
//  FangShengyun
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//  区域选择

//#import "FSBaseViewController.h"

@class FSChoseZoneViewController;
@protocol FSChoseZoneViewControllerDelegate <NSObject>
- (void)choseZoneViewController: (FSChoseZoneViewController *)vc locationCity: (NSString *)locationCity;
@end


/** 选择区域控制器 */
@interface FSChoseZoneViewController : UIViewController
@property (nonatomic , weak) id <FSChoseZoneViewControllerDelegate> delegate;

@end
