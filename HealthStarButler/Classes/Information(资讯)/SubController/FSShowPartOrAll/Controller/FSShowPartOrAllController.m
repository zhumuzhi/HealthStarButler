//
//  FSShowPartOrAllController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/11/30.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSShowPartOrAllController.h"
#import "FSShowMData.h"

@interface FSShowPartOrAllController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FSShowMData *showMData;

@property (nonatomic, assign) BOOL isExpand;

@end

@implementation FSShowPartOrAllController


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self configration];
}
#pragma mark - config UI & configration
- (void)configUI {
    [self.view addSubview:self.tableView];
}
- (void)configration {
    self.navigationItem.title = @"显示部分全部";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showMData.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    FSShowMData *showMData = [self.showMData.items by_ObjectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", showMData.title];
    return cell;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        FSShowMData *showMData = [[FSShowMData alloc] creatPartShowMData];
        _dataArray = [NSMutableArray arrayWithArray:showMData.items];
    }
    return _dataArray;
}

- (FSShowMData *)showMData {
    if (_showMData == nil) {
        _showMData = [[FSShowMData alloc] creatPartShowMData];
    }
    return _showMData;
    
}

#pragma mark - Event
- (void)showBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.isExpand = YES;
        self.showMData = [[FSShowMData alloc] creatAllShowMData];
    }else {
        self.showMData = [[FSShowMData alloc] creatPartShowMData];
    }
    [self.tableView reloadData];
    
    NSLog(@"负责展示的模型:%@", self.showMData);
}

#pragma mark - LazyGet

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO;                 //关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置
        
        UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showBtn.frame = CGRectMake(0, 0, kScreenWidth, 50);
        [showBtn setTitle:@"展示全部" forState:UIControlStateNormal];
        [showBtn setTitle:@"展示部分" forState:UIControlStateSelected];
        showBtn.backgroundColor = [UIColor  lightGrayColor];
        _tableView.tableFooterView = showBtn;
        [showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _tableView;
}



@end
