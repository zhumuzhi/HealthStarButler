//
//  FSSearchBarChangeView.h
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSLocationChangeView.h"

@class FSSearchBarChangeView;
@protocol FSSearchBarChangeViewDelegate <NSObject>
@optional
- (void)searchBarChangeViewDidClick: (FSSearchBarChangeView *)searchBarChangeView;
@end
@interface FSSearchBarChangeView : UIView
@property (nonatomic , weak) id <FSSearchBarChangeViewDelegate> delegate;
@property (nonatomic , strong) FSLocationChangeView *locationChangeView;

@end
