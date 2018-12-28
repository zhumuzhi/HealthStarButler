//
//  FSGroupingCollectionCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/28.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSGroupingCollectionCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, weak) UIImageView *imageV;
/** 标题Label */
@property (nonatomic, weak) UILabel *titleLabel;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
