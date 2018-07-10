//
//  MEDRefreshDetailsController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/11.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDRefreshDetailsController.h"
#import "MJRefresh.h"

#import "MEDEatBaoziHeader.h" // 自定义动画header
#import "MEDDIYHeader.h"      // 自定义header

#import "MEDEatBaoziFooter.h" // 自定义动画footer
#import "MEDDIYBackFooter.h"  // 自定义回弹footer ,footer分为三类(默认、动画、回弹本案例中未使用回弹)
/** 随机数据 */
#define MEDRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
/** 每次获取条数 */
#define DataCount 1
/** 默认开始加载条数 */
#define DefaultCount 5
/** 刷新时间*/
static const CGFloat MEDDuration = 1.0;

@interface MEDRefreshDetailsController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MEDRefreshDetailsController

//MARK:- Lazy
- (NSMutableArray *)datas {
    if (_datas == nil) {
        self.datas = [NSMutableArray array];
        for (int i = 0; i<DefaultCount; i++) {
            [self.datas addObject:MEDRandomData];
        }
    }
    return _datas;
}
    
- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect tableFrame = CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight-kTabbarSafeBottomMargin);
        _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];

    [self setupRefreshControl];
}

//MARK:- 下拉刷新
/** 根据类型设置刷新控件 */
- (void)setupRefreshControl {
    switch (self.type) {
        default:
            self.navigationItem.title = @"普通";
            [self refreshDefault];
            break;
        case MEDRefreshTypeGif:
            self.navigationItem.title = @"动画图片";
            [self refreshEatGif];
            break;
        case MEDRefreshTypeHiddeTime:
            self.navigationItem.title = @"隐藏时间";
            [self refreshHideTime];
            break;
        case MEDRefreshTypeOnlyActivityIndicator:
            self.navigationItem.title = @"纯指示器"; //隐藏状态和时间
            [self refreshOnlyActivityIndicator];
            break;
        case MEDRefreshTypeHiddeStatusAndTime:
            self.navigationItem.title = @"纯动画"; //隐藏状态和时间
            [self refreshHideStatusAndTime];
            break;
        case MEDRefreshTypeCustomText:
            self.navigationItem.title = @"自定义文字";
            [self refreshCsstomText];
            break;
        case MEDRefreshTypeCustomControl:
            self.navigationItem.title = @"自定义控件";
            [self refreshCustomControl];
            break;
    }
}

//MARK:默认刷新
/** 默认刷新 */
- (void)refreshDefault {
    // ---- 下拉刷新 ----
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];

    // ---- 上拉加载 ----
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

//MARK:动画图片刷新
/** 动画图片刷新 */
- (void)refreshEatGif {
    // ---- 下拉刷新 ----
    self.tableView.mj_header = [MEDEatBaoziHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    // ---- 上拉加载 ----
    self.tableView.mj_footer = [MEDEatBaoziFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//MARK:隐藏时间刷新
/** 隐藏时间刷新 */
- (void)refreshHideTime {
    // ---- 下拉刷新 ----
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //自己设置的文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    // 马上进入刷新状态
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    // ---- 上拉加载 ---- 数据加载完毕
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    self.tableView.mj_footer = footer;
}

//MARK:纯指示器
/** 纯指示器 */ //隐藏状态和时间
- (void)refreshOnlyActivityIndicator {
    // ---- 下拉刷新 ----
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    // ---- 上拉加载 ----
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
}

//MARK: 纯动画刷新
/** 纯动画刷新 */ //隐藏状态和时间
- (void)refreshHideStatusAndTime {
    // ---- 下拉刷新 ----
    MEDEatBaoziHeader *header = [MEDEatBaoziHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    // ---- 上拉加载 ----
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MEDEatBaoziFooter *footer = [MEDEatBaoziFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
}

//MARK: 自定义文字刷新
/** 自定义文字刷新 */
- (void)refreshCsstomText {
    // ---- 下拉刷新 ----
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    [header setTitle:@"自定:下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"自定:松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"自定:加载中" forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    header.stateLabel.textColor = MEDCommonBlue;
    header.lastUpdatedTimeLabel.textColor = MEDCommonBlue;
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableView.mj_header = header;
    
    // ---- 上拉加载 ----
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置文字
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多数据..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    footer.stateLabel.textColor = MEDCommonBlue;
    self.tableView.mj_footer = footer;
}

//MARK: 自定义控件刷新
/** 自定义控件刷新 */
- (void)refreshCustomControl {
    // ---- 下拉刷新 ----
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MEDDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    // ---- 上拉加载 ----
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.mj_footer = [MEDDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

//MARK:- 网络请求

/** 下拉刷新 */
- (void)loadNewData {
    for (int i = 0; i<DataCount; i++) {
        [self.datas insertObject:MEDRandomData atIndex:0]; //顶端插入数据
    }
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MEDDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData]; // 刷新表格
        [tableView.mj_header endRefreshing]; // 拿到当前的下拉刷新控件，结束刷新状态
    });
}

/** 上拉加载 */
- (void)loadMoreData {
    // 1.添加假数据
    for (int i = 0; i<DataCount; i++) {
        [self.datas addObject:MEDRandomData];
    }
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MEDDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}

/** 上拉加载-数据加载完 */
- (void)loadLastData {
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.datas addObject:MEDRandomData];
    }
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MEDDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];   
        //TODO: 数据加载完毕
        //拿到当前的上拉刷新控件，变为没有更多数据的状态
        [tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

/** 只加载一次数据 */ //加载后即隐藏加载控件，本案例未使用此方法
- (void)loadOnceData {
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.datas addObject:MEDRandomData];
    }
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MEDDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        // 隐藏当前的上拉刷新控件
        //TODO: 数据加载完毕隐藏加载更多
        tableView.mj_footer.hidden = YES;
    });
}

//MARK:- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

//MARK:- UITableViewDelegate

@end
