
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */


#import <UIKit/UIKit.h>

@class BAGridItemModel, BAGridView;
@protocol BAGridViewDelegate <NSObject>
- (void)gridView: (BAGridView *)gridView height: (CGFloat)height;
- (void)gridView: (BAGridView *)gridView gridItemModel: (BAGridItemModel *)gridItemModel;

@end
/**
 宫格样式

 - BAGridViewTypeImageTitle: 上面是图片，下面是文字
 - BAGridViewTypeTitleDesc: 上下都是文字，上面标题字体大，下面是详情字体小
 */
typedef NS_ENUM(NSUInteger, BAGridViewType) {
    BAGridViewTypeImageTitle = 0,
    BAGridViewTypeTitleDesc
};

/**
 BAGridView 回调

 @param model 返回 BAGridItemModel
 @param indexPath indexPath
 */
typedef void (^BAGridViewBlock)(BAGridItemModel *model, NSIndexPath *indexPath);

/**
 BAGridView 配置回调

 @param tempView BAGridView
 */
typedef void (^BAGridView_configurationBlock)(BAGridView *tempView);

@interface BAGridView : UIView

/**
 宫格样式，默认：BAGridViewTypeImageTitle
 */
@property(nonatomic, assign) BAGridViewType gridViewType;

/**
 数据源：来自 BAGridItemModel
 */
@property(nonatomic, strong) NSArray <BAGridItemModel *>*dataArray;

/**
 item：点击回调
 */
@property(nonatomic, copy)   BAGridViewBlock ba_gridViewBlock;

/**
 item：高度，图片高度 默认：ba_gridView_itemHeight * 0.4
 */
@property(nonatomic, assign) CGFloat ba_gridView_itemHeight;

/**
 item：图片与文字间距（或者两行文字类型的间距），默认：0
 */
@property(nonatomic, assign) CGFloat ba_gridView_itemImageInset;

/**
 item：每行 item 的个数，默认：4个
 */
@property(nonatomic, assign) NSInteger ba_gridView_rowCount;

/**
 item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
 */
@property(nonatomic, strong) UIColor *ba_gridView_titleColor;

/**
 item：Desc 颜色，默认：BAKit_Color_Gray_9【BAKit_Color_RGB(216, 220, 228)】
 */
@property(nonatomic, strong) UIColor *ba_gridView_titleDescColor;

/**
 item：分割线颜色，默认：BAKit_Color_Gray_10【BAKit_Color_RGB(240, 240, 240)】
 */
@property(nonatomic, strong) UIColor *ba_gridView_lineColor;

/**
 item：背景颜色，默认：BAKit_Color_White
 */
@property(nonatomic, strong) UIColor *ba_gridView_backgroundColor;

/**
 item：背景选中颜色，默认：无色
 */
@property(nonatomic, strong) UIColor *ba_gridView_selectedBackgroundColor;

/**
 item：是否显示分割线
 */
@property(nonatomic, assign, getter=isShowLineView) BOOL showLineView;

/**
 item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
 */
@property(nonatomic, strong) UIFont *ba_gridView_titleFont;

/**
 item：Desc Font，默认：两行文字下 12
 */
@property(nonatomic, strong) UIFont *ba_gridView_titleDescFont;

@property (nonatomic , weak) id <BAGridViewDelegate> delegate;

/**
 快速创建宫格

 @param gridViewType 样式
 @param dataArray 数据
 @param configurationBlock 配置回调
 @param block 点击事件回调
 @return BAGridView
 */
+ (instancetype)ba_creatGridViewWithGridViewType:(BAGridViewType)gridViewType
                                       dataArray:(NSArray <BAGridItemModel *>*)dataArray
                              configurationBlock:(BAGridView_configurationBlock)configurationBlock
                                           block:(BAGridViewBlock)block;

@end
