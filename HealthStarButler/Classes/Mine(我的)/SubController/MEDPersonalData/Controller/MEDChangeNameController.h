//
//  MEDChangeNameController.h
//  健康之星管家
//
//  Created by 朱慕之 on 2017/7/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDBaseViewController.h"

@class MEDChangeNameController;

@protocol MEDChangeNameControllerDelegate <NSObject>
@optional
- (void)changeNameController:(MEDChangeNameController *)controller didClickSaveButton:(NSString *)name;
@end

@interface MEDChangeNameController : MEDBaseViewController

@property (nonatomic, copy) NSString *currentName;

@property (nonatomic, weak) id<MEDChangeNameControllerDelegate> delegate;

@end
