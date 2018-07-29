//
//  FSShopCartController.m
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/27.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSShopCartController.h"

#import "FSShopCartToolBar.h"

//#import "GHCountField.h"

@interface FSShopCartController ()<
                                UITableViewDataSource,
                                UITableViewDelegate,
                                FSShopCartToolBarDelegate
                                >

@property (nonatomic, strong) UITableView *shopTableView;
/** 存储数组 */
@property (nonatomic, strong) NSMutableArray *storeArray;
/** 选中的数组 */
@property (nonatomic, strong) NSMutableArray *selectArray;

@property (nonatomic, strong) FSShopCartToolBar *shopCartToolbar;


@end

@implementation FSShopCartController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
//    [self configuration];
}

#pragma mark - ConfigUI
- (void)configUI{
    [self.view addSubview:self.shopTableView];
    [self.view addSubview:self.shopCartToolbar];
}
//- (void)configuration {
//    // Navigation
//    self.navBarView.navTitle = @"采购单";
//    self.navBarViewStyleType = FSNavBarViewStyleTypeNone;
//    self.navBarColor = [UIColor colorWithHexString:@"#2E3034"];
//
//    self.shopTableView.mj_footer.hidden = YES;
//    // 设置空页面
//    self.shopTableView.emptyDataSetSource = self;
//    self.shopTableView.emptyDataSetDelegate = self;

    // [self makeCountField]; 展示购物车控件
//}
#pragma mark - RequestData

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd", indexPath.section, indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - LazyGet
- (FSShopCartToolBar *)shopCartToolbar {
    if (_shopCartToolbar == nil) {
        _shopCartToolbar = [[FSShopCartToolBar alloc] init];
        _shopCartToolbar.frame = CGRectMake(0, kScreenHeight - kTabBarHeight-kAutoWithSize(50), kScreenWidth, kAutoWithSize(50));
        _shopCartToolbar.delegate = self;
    }
    return _shopCartToolbar;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
}
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}
- (UITableView *)shopTableView {
    if (_shopTableView == nil) {
        _shopTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight - kTabBarHeight) style:UITableViewStyleGrouped];
        _shopTableView.dataSource = self;
        _shopTableView.delegate = self;
    }
    return _shopTableView;
}

#pragma mark - CustomDelegate
- (void)shopCartToolBarSelectedAllClick {
    NSLog(@"选中/取消所有数据，刷新购物车页面");
}

- (void)shopCartToolBarClearingClick {
    NSLog(@"点击结算页面");
}

#pragma mark - OtherDelegate
#pragma mark EmptyDataDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"common_noResult"];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:kAutoWithSize(14)],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]                                                                                                                                           };
        return [[NSAttributedString alloc] initWithString:@"去逛一逛" attributes:attributes];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    NSLog(@"跳转到去逛一逛的页面");
}

#pragma mark - TEST
//- (void)makeCountField {
//    GHCountField * countField = [[GHCountField alloc]init];
//    countField.maxCount = 99;
//    countField.minCount = 0;
//    countField.count = 0;
//    [self.contentView addSubview:countField];
//    [countField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kTabBarHeight);
//        make.width.equalTo(@(100));
//        make.height.equalTo(@(20));
//    }];
//}

#pragma mark - Event

#pragma mark - Notification Method

#pragma mark - Private Methods

#pragma mark - Public Method

@end
