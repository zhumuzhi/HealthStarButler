//
//  MEDTableViewLinkController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/22.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDTableViewLinkController.h"
#import "MEDCategoryModel.h"
#import "MEDLinkLeftTableViewCell.h"
#import "MEDLinkRightTableViewCell.h"
#import "MEDTableViewLHeaderView.h"

static float kLeftTableViewWidth = 80.f;

@interface MEDTableViewLinkController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isScrollDown;

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@end

static NSString * const MEDLeftCellID = @"MEDLeftCellID";
static NSString * const MEDRightCellID = @"MEDRightCellID";

@implementation MEDTableViewLinkController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = 0;
    _isScrollDown = YES;
    
    [self loadData];
    [self createTable];
    
}

#pragma mark - Lazy
- (NSMutableArray *)categoryData {
    if (!_categoryData) {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData {
    if (!_foodData) {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, kScreenHeight)];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[MEDLinkLeftTableViewCell class] forCellReuseIdentifier:MEDLeftCellID];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, kScreenWidth, kScreenHeight)];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.rowHeight = 80;
//        _rightTableView.tableFooterView = [UIView new];
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[MEDLinkRightTableViewCell class] forCellReuseIdentifier:MEDRightCellID];
    }
    return _rightTableView;
}




#pragma mark - LoadData

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    
    for (NSDictionary *dict in foods) {
        MEDCategoryModel *model = [MEDCategoryModel objectWithDictionary:dict];
        [self.categoryData addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (MEDFoodModel *f_model in model.spus) {
            [datas addObject:f_model];
        }
        [self.foodData addObject:datas];
    }
}

#pragma mark - creatUI
- (void)createTable {
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (_leftTableView == tableView) ? 1:self.categoryData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_leftTableView == tableView) ? self.categoryData.count : [self.foodData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (_leftTableView == tableView) {
        MEDLinkLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEDLeftCellID forIndexPath:indexPath];
        MEDFoodModel *model = self.categoryData[indexPath.row];
        cell.name.text = model.name;
        return cell;
    }else {
        MEDLinkRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEDRightCellID forIndexPath:indexPath];
        MEDFoodModel *model =self.foodData[indexPath.section][indexPath.row];
        cell.model = model;
        return cell;
    }
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return (_rightTableView == tableView) ? 20 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MEDTableViewLHeaderView *view = [[MEDTableViewLHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    MEDFoodModel *model = self.categoryData[section];
    view.title.text = model.name;
    return (_rightTableView == tableView) ? view : nil;

}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && (_rightTableView.dragging || _rightTableView.decelerating)) {
        [self selectRowAtIndexPath:section];
    }
    
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && (_rightTableView.dragging || _rightTableView.decelerating)) {
        [self selectRowAtIndexPath:section + 1];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_leftTableView == tableView) {
        _selectIndex = indexPath.row;
        
        [self scrollViewToTopOfSection:_selectIndex animated:YES];
        
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - private method

- (void)scrollViewToTopOfSection:(NSInteger)section animated:(BOOL)animated {
    
    CGRect headerRect = [self.rightTableView rectForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _rightTableView.contentInset.top);
    [self.rightTableView setContentOffset:topOfHeader animated:animated];
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}


@end
