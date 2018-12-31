//
//  FSPageControl.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/29.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPageControl : UIPageControl

/** 选中图片 */
@property (nonatomic,strong)UIImage *currentImage;
/** 默认图片 */
@property (nonatomic,strong)UIImage *pageImage;
/** 图标大小 */
@property (nonatomic,assign)CGSize pointSize;

@end

NS_ASSUME_NONNULL_END
