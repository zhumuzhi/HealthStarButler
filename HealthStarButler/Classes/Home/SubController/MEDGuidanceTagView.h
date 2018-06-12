//
//  MEDGuidanceTagView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MEDGuidanceTagView;

typedef enum{
    
    //正常状态（不可点击，单单显示）
    TagStateNormal = 0,
    
    //编辑转态
    TagStateEdit,
    
    //选择状态
    TagStateSelect
    
}TagStateType;


@protocol MEDGuidanceTagDelegate <NSObject>

@optional

/**
 *  TagList View的高度
 *
 *   taglist
 *   listHeight 高度
 */
-(void)tagList:(MEDGuidanceTagView *)taglist heightForView:(float)listHeight;

/**
 *  显示添加tag视图
 */
-(void)showAddTagView;

@required

/**
 *  点击第几个按钮
 *
 *   taglist
 *   buttonIndex 点击按钮的Index
 */
-(void)tagList:(MEDGuidanceTagView *)taglist clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface MEDGuidanceTagView : UIView


/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *tagViewBackgroundColor;

/**
 *  传入的Tag数组
 */
@property (nonatomic, strong) NSMutableArray *tagArr;

/**
 *  如果传入的数组的tag里包含的是字典的话，那么key是必传得，不然获取不到Value
 */
@property (nonatomic, strong) NSString *tagArrkey;

/**
 *  标签文字大小
 */
@property (nonatomic, assign) float tagFont;

/**
 *  标签文字颜色
 */
@property (nonatomic, strong) UIColor *tagTextColor;

/**
 *  标签背景颜色
 */
@property (nonatomic, strong) UIColor *tagBackgroundColor;

/**
 *  标签对齐方式
 */
@property (nonatomic) NSTextAlignment tagTextAlignment;

/**
 *  圆角的值
 */
@property (nonatomic, assign) float tagCornerRadius;

/**
 *  边框的宽度
 */
@property (nonatomic, assign) float tagBorderWidth;

/**
 *  边框的颜色
 */
@property (nonatomic, strong) UIColor *tagBorderColor;

/**
 *  状态（编辑状态下可以点击删除）
 */
@property (nonatomic, assign) TagStateType tagStateType;

/**
 *  是否可以添加标签（yes的时候最后一个按钮为添加按钮）
 */
@property (nonatomic, assign) BOOL is_can_addTag;

/**
 *  如果可以添加标签，那么最后一个添加按钮的title
 */
@property (nonatomic, strong) NSString *addTagStr;


@property (nonatomic, strong) id<MEDGuidanceTagDelegate>delegate;

/**
 *  初始话UI
 *
 *  @param tagArr Tag数组
 */
-(void)creatUI:(NSMutableArray *)tagArr;

/**
 *  刷新数据
 *
 *  @param newTagArr 新的Tag数组
 */
- (void)reloadData:(NSMutableArray *)newTagArr;

/**
 *  刷新数据
 *
 *  @param newTagArr 新的Tag数组
 *  @param time      动画时间
 */
- (void)reloadData:(NSMutableArray *)newTagArr andTime:(float)time;


@end

