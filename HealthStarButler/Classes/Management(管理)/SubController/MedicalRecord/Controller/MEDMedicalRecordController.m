//
//  MEDMedicalRecordController.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/4.
//  Copyright © 2017年 mmednet. All rights reserved.
//  就诊记录

#import "MEDMedicalRecordController.h"

#import "MEDTreatmentRecordListController.h"    //诊疗记录列表
#import "MEDTestReportListController.h"         //检测报告列表

#import "MEDAddTreatmentRecordController.h" //添加诊疗记录
#import "MEDAddTestReportController.h"      //添加检测报告

#define titleBtnWidth 80
#define indicatorHeight 3

@interface MEDMedicalRecordController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;    //标题ScrollView
@property (nonatomic, strong) UIScrollView *contentScrollView;  //内容ScrollView
@property (nonatomic, strong) UIView *indicatorLine;            //指示线条
@property (nonatomic, copy) NSString *selectedSign;             //选择标记
@end

@implementation MEDMedicalRecordController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavigation];
    [self setupTwoContentScrollView];
    [self setupChildViewControllers];
    [self setupHealthPlaneTitleButtons];
 
    //设置添加默认控制器
    UIViewController *firstVc = [self.childViewControllers firstObject];
    [self.contentScrollView addSubview:firstVc.view];
    
    //设置默认选中第一个标题
    NSUInteger index = _titleScrollView.contentOffset.x / _titleScrollView.frame.size.width;
    UIButton *titleButton = self.titleScrollView.subviews[index];
    [self titleButtonClick:titleButton];
    
    //设置内容ScrollView的ContentSize
    CGFloat contentW = self.childViewControllers.count*[UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentW, 0);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.titleScrollView removeFromSuperview];
}

#pragma mark - lazy
- (UIScrollView *)titleScrollView {
    if(!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
//        _titleScrollView.backgroundColor = [UIColor lightGrayColor];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
    }
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.delegate = self;
        _contentScrollView.backgroundColor = [UIColor grayColor];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

#pragma mark - TwoScrollView
//设置两个容器ScrollViewUI
- (void)setupTwoContentScrollView{
    
    self.titleScrollView.frame = CGRectMake(0, 0, 160, 40);
    self.navigationItem.titleView = self.titleScrollView;
    
    self.contentScrollView.frame = self.view.bounds;
    [self.view addSubview:self.contentScrollView];
}

/** 添加子控制器 */
- (void)setupChildViewControllers {
    MEDTreatmentRecordListController *treatmentRecord = [[MEDTreatmentRecordListController alloc] init];
    //treatmentRecord.view.frame =  CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    treatmentRecord.title = @"诊疗记录";
    [self addChildViewController:treatmentRecord];
    
    MEDTestReportListController *testReport = [[MEDTestReportListController alloc] init];
    //testReport.view.frame =  CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    //testReport.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    
    testReport.title = @"检测报告";
    [self addChildViewController:testReport];
}

/** 添加所有TitleButton */
- (void)setupHealthPlaneTitleButtons {
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    NSUInteger count = self.childViewControllers.count;
    CGFloat titleButtonW = titleBtnWidth;
    CGFloat titleButtonH = 30;
    CGFloat titleButtonY = 0;
    
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; //MEDRGBA(153, 153, 153, 1)
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected]; //MEDRGBA(62, 195, 205, 1)
        titleButton.titleLabel.font = MEDSYSFont(15);
        [titleButton sizeToFit];
        titleButton.tag = i;
        [self.titleScrollView addSubview:titleButton];
        CGFloat titleButtonX = i * titleButtonW;//设置frame 先写死宽高
        titleButton.frame = CGRectMake(titleButtonX, titleButtonY, titleButtonW, titleButtonH);
        UIViewController *childVC = self.childViewControllers[i];
        [titleButton setTitle:childVC.title forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!_indicatorLine) {
        _indicatorLine = [[UIView alloc] init];
        _indicatorLine.frame = CGRectMake(5, 33, titleButtonW-10, indicatorHeight);
        _indicatorLine.backgroundColor = [UIColor whiteColor];
        [self.titleScrollView addSubview:_indicatorLine];
    }
    //设置TitleScrollView的ContentSize
    CGFloat titLeButtonsContentW = count * titleButtonW;
    self.titleScrollView.contentSize = CGSizeMake(titLeButtonsContentW, 0);
}

/** 标题按钮点击 */
- (void)titleButtonClick:(UIButton *)button {
    CGFloat contentOffsetX = button.tag * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
    
    //记录标记
    self.selectedSign = [NSString stringWithFormat:@"%ld", button.tag];
    
    for (UIButton *btn in self.titleScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setSelected:NO];
        }
    }
    [button setSelected:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self->_indicatorLine.centerX = button.centerX;
    }];
}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *rollVC = self.childViewControllers[index];
    
    NSLog(@"滚动后Index为%ld", index);
    
    //设置标题按钮的偏移量
    UIButton *rollButton = self.titleScrollView.subviews[index];
    [self titleButtonClick:rollButton];
    
    CGFloat titleOffsetX = rollButton.center.x - self.titleScrollView.frame.size.width * 0.5;
    CGFloat titleMaxOffSetX = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    if (titleOffsetX < 0) {
        titleOffsetX = 0;
    }else if(titleOffsetX > titleMaxOffSetX) {
        titleOffsetX = titleMaxOffSetX;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.titleScrollView.contentOffset = CGPointMake(titleOffsetX, 0);
    }];
    
    if (rollVC.view.superview) return;
    CGFloat rollVCW = scrollView.frame.size.width;
    CGFloat rollVCH = scrollView.frame.size.height;
    CGFloat rollVCX = index * rollVCW;
    CGFloat rollVCY = 0;
    rollVC.view.frame = CGRectMake(rollVCX, rollVCY, rollVCW, rollVCH);
    [scrollView addSubview:rollVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 设置导航栏

- (void)setupNavigation{
    UIButton *AddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [AddBtn setTitle:@"添加" forState:UIControlStateNormal];
    [AddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    AddBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    AddBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [AddBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:AddBtn];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self useMethodToFindBlackLineAndHind];
}

- (void)useMethodToFindBlackLineAndHind {
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    blackLineImageView.hidden = YES;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)addBtnClick {
//    NSLogFunc;
    if ([self.selectedSign integerValue] == 0) {      //诊疗记录
        NSLog(@"跳转到添加诊疗记录");
        
        MEDAddTreatmentRecordController *AddTreatmentRecord = [[MEDAddTreatmentRecordController alloc] init];
        [self.navigationController pushViewController:AddTreatmentRecord animated:YES];
    }else if ([self.selectedSign integerValue] == 1) { //检测报告
        NSLog(@"跳转到添加检测报告");
        
        MEDAddTestReportController *AddTestReport = [[MEDAddTestReportController alloc] init];
        [self.navigationController pushViewController:AddTestReport animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
