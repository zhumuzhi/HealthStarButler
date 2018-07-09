//
//  MZModelTypeLoginController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZModelTypeLoginController.h"

static NSString *MZLoginCellID = @"MZLoginCellID";

@interface MZModelTypeLoginController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic , copy) NSString *emailAccount;
@property (nonatomic , copy) NSString *userCode;
@property (nonatomic , copy) NSString *serverCode;
@property (nonatomic , copy) NSString *password;
@property (nonatomic , strong) UIImageView *backImageView;


@end

@implementation MZModelTypeLoginController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - ConfigUI
- (void)setupUI
{
    [self.view addSubview:self.backImageView];
    [self.backImageView addSubview:self.tableView];
//    self.tableView.tableHeaderView = self.headerView;

}

#pragma mark - RequestData

- (void)loadData {
//    NSArray *tempArray= [[GHDataModelHelper dataModelHepler] creatLoginDataArray];
//    self.dataArray = [GHDataModel mj_objectArrayWithKeyValuesArray:tempArray];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01f;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GHDataModel *dataModel = self.dataArray[indexPath.row];
//    GHLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:GHLoginCellID];
//    cell.dataModel = dataModel;
//    dataModel.indexPath = indexPath;
//    cell.delegate = self;
//    return cell;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MZLoginCellID];
    return cell;
}

#pragma mark - LazyGet
- (UIImageView *)backImageView {
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _backImageView.image = [UIImage imageNamed:@"login_register_background"];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView registerClass:[GHLoginCell class] forCellReuseIdentifier:GHLoginCellID];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0.01f;
        _tableView.sectionHeaderHeight = 0.01f;
        _tableView.rowHeight = 56;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

//- (GHLoginHeaderView *)headerView {
//    if (_headerView == nil) {
//        _headerView = [[GHLoginHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
//    }
//    return _headerView;
//}



@end
