//
//  FSFSLocationChangeView.h
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSLocationChangeView;
@protocol FSLocationChangeViewDelegate <NSObject>
- (void)locationChangeView: (FSLocationChangeView *)locationChangeView finalX: (CGFloat)finalX;
@end
@interface FSLocationChangeView : UIButton
/** 定位城市 */
@property (nonatomic , copy) NSString *locationCity;

@property (nonatomic , weak) id <FSLocationChangeViewDelegate> delegate;

@end
