//
//  FSAddressListController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressListController.h"

//Model
#import "FSAddressListNData.h"
#import "FSAddressListMData.h"
//View
#import "FSAddressContactsCell.h"
#import "FSAddressShipAddressCell.h"

@interface FSAddressListController ()<UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, strong) UITableView *addressTableView;
// Data&Model
@property (nonatomic, strong) NSMutableArray *dataArray;
// 入参
@property (nonatomic, assign) NSInteger pageSize;  // 页内容
@property (nonatomic, assign) NSInteger pageNum;   // 页号
@property (nonatomic, assign) FSAddressListJempSourceType jempSourceType;  // 跳转来源
// other
@property (nonatomic, strong) NSMutableArray *maxArray;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, assign) NSInteger address_id;

@end

@implementation FSAddressListController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self configuration];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadDataWithRequestType];
}

#pragma mark - ConfigUI & Configration
- (void)setupUI {
    self.addressTableView.frame = CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight);
    [self.view addSubview:self.addressTableView];
}

- (void)configuration {
    self.navigationItem.title = @"收货地址";
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageSize = 10;
    self.pageNum = 1;
}

#pragma mark - RequestData
/** 根据类型请求数据 */
- (void)loadDataWithRequestType {
    
    FSAddressListReqNData *req = [[FSAddressListReqNData alloc] initWithRequstType:FSAddressListRequstTypeList];
    req.pageSize = self.pageSize;
    req.pageNum = self.pageNum;
    
    MEDWeakSelf(self);
    [[GHHTTPManager sharedManager] requstDataWithUrl:req.url parametes:req.parametes finishedBlock:^(id responseObject, NSError *error) {
        // NSLog(@"获取到的地址列表数据为:%@", responseObject);
        FSAddressListResNData *res = [[FSAddressListResNData alloc] initWithDict:responseObject];
        if (res.errorCode == 0) {
            weakself.dataArray = res.dataArray;
            [weakself.addressTableView reloadData];
            NSLog(@"获取数据成功，范返回：%@", self.dataArray);
        }else {
            NSLog(@"%@", res.errorMessage);
        }
        /* 错误解决 & 提示*/
        if (error) {
            NSLog(@"获取地址列表的错误信息:%@", res.errorMessage);
        }
        
    }];
}

#define cellIdentify @"cellIdentify"

#pragma mark - LazyGet
- (UITableView *)addressTableView {
    if (_addressTableView == nil) {
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _addressTableView.showsVerticalScrollIndicator = NO;
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        /*注册Cell*/
        [_addressTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];

        [_addressTableView registerClass:[FSAddressContactsCell class] forCellReuseIdentifier:@"FSAddressContactsCellID"];
        [_addressTableView registerClass:[FSAddressShipAddressCell class] forCellReuseIdentifier:@"FSAddressShipAddressCellID"];
        
        /* FIXME:下拉刷新 & 上拉加载 方法*/
    }
    return _addressTableView;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)maxArray {
    if (_maxArray == nil) {
        _maxArray = [NSMutableArray array];
    }
    return _maxArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FSAddressListMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.items.count;
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSAddressListMData *sectionMData = [self.dataArray by_ObjectAtIndex:indexPath.section];
    FSAddressListMData *rowMData = [sectionMData.items by_ObjectAtIndex:indexPath.row];
    rowMData.indexPath = indexPath;
    
    if (rowMData.addressListCellType == FSAddressListCellTypeConsignee) {
        NSString *cellIdentifier = [NSString stringWithFormat:@"FSAddressListCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        FSAddressContactsCell *cell = [[FSAddressContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.listMData = rowMData;
        return cell;
    } else if(rowMData.addressListCellType == FSAddressListCellTypeAddress) {
        NSString *cellIdentifier = [NSString stringWithFormat:@"FSAddressShipAddressCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        FSAddressShipAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[FSAddressShipAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.rowMData = rowMData;
        return cell;
    } else {
        static NSString *identify = @"cellIdentify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
/** 设置Header&Footer */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    FSAddressListMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.sectionHeaderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    FSAddressListMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.sectionFooterHeight;
}

#pragma mark - Event

@end
