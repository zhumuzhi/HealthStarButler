//
//  FSAddressListController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressListController.h"
#import "FSAddressListNData.h"

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
@property (nonatomic , assign) NSInteger address_id;

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
//    self.addressTableView.frame =CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
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
    
    [[GHHTTPManager sharedManager] requstDataWithUrl:req.url parametes:req.parametes finishedBlock:^(id responseObject, NSError *error) {
        NSLog(@"获取到的地址列表数据为:%@", responseObject);
        /* FIXME:返回解析*/
        

        /* 错误解决 & 提示*/
        if (error) {
        }
        
        
    }];
}

#pragma mark - LazyGet
- (UITableView *)addressTableView {
    if (_addressTableView == nil) {
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _addressTableView.showsVerticalScrollIndicator = NO;
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        /* FIXME:注册Cell*/
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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

#pragma mark - Event


@end
