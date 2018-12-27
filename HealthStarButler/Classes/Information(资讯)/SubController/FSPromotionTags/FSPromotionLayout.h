//
//  FSPromotionLayout.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/27.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPromotionLayout;

@protocol FSPromotionLayoutDelegate <NSObject>
@optional

- (CGSize)waterFlowLayout:(FSPromotionLayout *) WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath;

- (void)getCollectionViewHeight:(CGFloat)ccHeight;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FSPromotionLayout : UICollectionViewLayout

/** 每一列item之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行item之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 设置于collectionView边缘的间距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 设置每一行排列的个数 */
@property (nonatomic, assign) NSInteger columnCount;

 @property(nonatomic, weak) id<FSPromotionLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
