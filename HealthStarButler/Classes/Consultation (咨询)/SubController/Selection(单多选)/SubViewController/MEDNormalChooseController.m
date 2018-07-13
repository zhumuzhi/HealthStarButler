//
//  MEDNormalChooseController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/21.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDNormalChooseController.h"

static NSString *identifiter = @"identifiter";

@interface MEDNormalChooseController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 单选选中Index */
@property (nonatomic, strong) NSIndexPath *selectIndex;
/** 多选记录数组 */
@property (nonatomic, strong) NSMutableArray *selectIndexs;

@property (nonatomic, assign) BOOL isSingle;

@end

@implementation MEDNormalChooseController

//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigation];
    
    [self.view addSubview:self.tableView];
}

//MARK:- Navigation
- (void)setupNavigation {
    self.navigationItem.title = @"单选模式";
    _isSingle = YES;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"多选" style:UIBarButtonItemStylePlain target:self action:@selector(navigationItemClick)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)navigationItemClick {
    _isSingle = !_isSingle;
    if (_isSingle) { //单选
        _selectIndex = nil;
        _tableView.allowsMultipleSelection = NO;
        self.navigationItem.rightBarButtonItem.title = @"多选";
        self.navigationItem.title = @"单选模式";
        [self.selectIndexs removeAllObjects];
        [self.tableView reloadData];
    }else { //多选
        _tableView.allowsMultipleSelection = YES;
        self.navigationItem.title = @"多选模式";
        self.navigationItem.rightBarButtonItem.title = @"单选";
        [self.tableView reloadData];
    }
}

//MARK:- TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    if(_isSingle) {
        if (indexPath == _selectIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self setupCoustomChooseBtn:cell];
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        for (NSIndexPath *index in _selectIndexs) {
            if (indexPath == index) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self setupCoustomChooseBtn:cell];
            }
        }
    }
    
    return cell;
}

//MARK:- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isSingle) { //单选
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _selectIndex = indexPath;
        [self setupCoustomChooseBtn:cell];
    }else { //多选
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [_selectIndexs removeObject:indexPath];
        }else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [_selectIndexs addObject:indexPath];
            [self setupCoustomChooseBtn:cell];
        }
    }
}

/** 设置自定义选中View */
- (void)setupCoustomChooseBtn:(UITableViewCell *)cell{
//    UIButton *checkMark = cell.subviews[2];
//    [checkMark setImage:[UIImage imageNamed:@"danxuan_selected"] forState:UIControlStateNormal];
    //    打印查看界面
    //    NSLog(@"选中时: %@", cell.subvirews);
    //    NSLog(@"subView的个数:%ld", cell.subviews.count);
    //    NSLog(@"拿来使用的View:%@", cell.subviews[2]);
    //    for (UIView *subView in cell.subviews) {
    //        NSLog(@"subView--:%@", subView);
    //    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
}

//MARK:- lazy
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight - kTabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifiter];
    }
    return _tableView;
}

- (NSMutableArray *)selectIndexs {
    if (!_selectIndexs) {
        _selectIndexs = [NSMutableArray array];
    }
    return _selectIndexs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
