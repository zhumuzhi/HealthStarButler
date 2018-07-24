//
//  FXMNavBarView.m
//  FXMOnLineAPP
//
//  Created by GHome on 2017/12/18.
//  Copyright © 2017年 GHome. All rights reserved.
//

#import "FSNavBarView.h"

@implementation FSNavBarView

#pragma mark - set
- (void)setTitleColor:(UIColor *)titleColor {
    self.title.textColor = titleColor;
}
- (void)setIsShowBottomLine:(BOOL)isShowBottomLine {
    self.line.hidden = !isShowBottomLine;
}
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    if (self.isShowTitleView) {
        self.title.text = navTitle;
    }
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setDefault];
        [self setupUI];
    }
    return self;
}
- (instancetype)init {
    if (self == [super init]) {
        [self setDefault];
        [self setupUI];
    }
    return self;
}
- (void)setDefault {
//    self.titleFont = kFont(18);
    self.title.text = @"";
//    self.titleColor = kFXMWhiteColor;
    self.isShowTitleView = YES;
    self.titleView.backgroundColor = self.backgroundColor;
}
- (void)setupUI {
    [self setupTitleView];
    [self setupTitle];
    [self setupLeftView];
    [self setupRightView];
    [self setupLeftButton];
    [self setupRightButton];
    [self setupLine];
}
- (void)setupLine {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
//    line.backgroundColor = kFXMLineColor;
    self.line = line;
    [self addSubview:line];
}
- (void)setupTitleView {
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(self.bounds.size.width * 0.6 * 0.5, 0, self.bounds.size.width * 0.4, self.bounds.size.height);
    self.titleView = titleView;
    [self addSubview:titleView];
}
- (void)setupTitle {
    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = self.titleColor;
    title.font = self.titleFont;
    self.title = title;
    [self.titleView addSubview:title];
}
- (void)setupLeftView {
    UIView *leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 0, self.bounds.size.width * 0.3, self.bounds.size.height);
    leftView.userInteractionEnabled = YES;
    self.leftView = leftView;
    [self addSubview:leftView];
}
- (void)setupRightView {
    UIView *rightView = [[UIView alloc]init];
    rightView.frame = CGRectMake(self.bounds.size.width - 10 - self.bounds.size.width * 0.3, 0, self.bounds.size.width * 0.3, self.bounds.size.height);
    rightView.userInteractionEnabled = YES;
    self.rightView = rightView;
    
    [self addSubview:rightView];
}

- (void)setupLeftButton {
    FSButton *leftButton = [[FSButton alloc]init];
    leftButton.frame = CGRectMake(0,0,44,self.leftView.bounds.size.height);
    leftButton.tag = FSNavBarViewButtonStyleTypeLeft;
    self.leftButton = leftButton;
    [self.leftView addSubview:leftButton];
}
- (void)setupRightButton {
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(self.rightView.bounds.size.width - 44,0,44,self.rightView.bounds.size.height);
    self.rightButton = rightButton;
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.tag = FSNavBarViewButtonStyleTypeRight;
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightView addSubview:rightButton];
}


@end
