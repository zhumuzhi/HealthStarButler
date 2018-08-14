//
//  FSLocationView.h
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSLocationView;
@protocol FSLocationViewDelegate <NSObject>
- (void)locationView: (FSLocationView *)locationView finalX: (CGFloat)finalX;
@end
@interface FSLocationView : UIButton

/** 定位城市 */
@property (nonatomic , copy) NSString *locationCity;
@property (nonatomic , weak) id <FSLocationViewDelegate> delegate;

@end
