//
//  FSCycleView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/29.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger ,FSCycleViewType) {
    FSCycleViewTypeImage                  = 1,
    FSCycleViewTypeSeparateTitleAndImage  = 1 << 1,
    FSCycleViewTypeMergeTitleAndImage     = 1 << 2,
};

/** 可以定义PageContol圆点的类型 */
typedef NS_ENUM (NSUInteger ,FSCyclePageContolStyle) {
    FSCyclePageContolStyleNone = 1,   //圆点
    FSCyclePageContolStyleRectangle,  //条状
    FSCyclePageContolStyleImage,      //图片
};

/** 可以定义PageContol圆点的位置 */
typedef NS_ENUM(NSInteger, FSCyclePageContolLocation) {
    FSCyclePageContolLocationCenter,//中间
    FSCyclePageContolLocationLeft, //左边
    FSCyclePageContolLocationRight,//右边
};

@class FSCycleView;
@protocol FSCycleViewDelegate <NSObject>
/** 点击图片回调 */
- (void)cycleView:(FSCycleView *)cycleView didSelectItemAtIndex:(NSInteger)index;
/** 图片滚动回调 */
- (void)cycleView:(FSCycleView *)cycleView didCycleToIndex:(NSInteger)index;
@end


NS_ASSUME_NONNULL_BEGIN

@interface FSCycleView : UIView

@property (nonatomic, weak) id <FSCycleViewDelegate> delegate;

/** 本地图片 */
@property (nonatomic, strong) NSArray<NSString *> *images;
/** 图片链接 */
@property (nonatomic, strong) NSArray<NSString *> *urlImages;
/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titles;
/** 图片和标题字典（字典结构为：@{@"imageUrl":@"",@"title":@""}） */
@property (nonatomic, strong) NSArray<NSDictionary *> *arrayD;

@property (nonatomic, assign) FSCycleViewType cycleViewType;

/** 自动轮播时间间隔,默认2s */
@property (nonatomic, assign) CGFloat autoCycleTimeInterval;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL isInfiniteCycle;

/** 是否自动轮播,默认Yes */
@property (nonatomic,assign) BOOL autoCycle;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;




@end

NS_ASSUME_NONNULL_END
