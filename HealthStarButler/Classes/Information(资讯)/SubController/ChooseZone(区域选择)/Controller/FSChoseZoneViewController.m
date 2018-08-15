//
//  FSChoseZoneViewController.m
//  FangShengyun
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//  区域选择

#import "FSChoseZoneViewController.h"
/* Model*/
#import "FSChoseZoneMData.h"
/* View */
#import "FSSearchBarView.h"           /* 搜索*/
#import "FSChoseZoneSectionHeader.h"  /* Header*/

#import "FSChoseZoneCell.h"           /* 定位Cell/列表Cell/搜索列表Cell*/
#import "FSChoseZoneHistoryCell.h"    /* 选择历史*/
//#import "FSChoseZoneListCell.h"       /* 展示列表*/

#import <CoreLocation/CoreLocation.h>

@interface FSChoseZoneViewController ()<
                        FSSearchBarViewDelegate,
                        CLLocationManagerDelegate,
                        FSChoseZoneCellDelegate,
                        UITableViewDataSource,
                        UITableViewDelegate
                        >

/** TableView */
@property (nonatomic, strong) UITableView *tableView;
/** 页面结构数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 右侧索引 */
@property (nonatomic, strong) NSArray *sectionIndexs;
/** 搜索Header */
@property (nonatomic , strong) FSSearchBarView *searchBar;
/** 选择数据类型 */
@property (nonatomic , assign) FSChoseZoneDataType choseZoneDataType;
/** 城市数据组 */
@property (nonatomic, strong) NSMutableArray *cityArray;
/** CLLocationManager */
@property (nonatomic , strong) CLLocationManager *locationManager;

@end

@implementation FSChoseZoneViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];

    [self configuration];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

static  NSString *FSChoseZoneCellID = @"FSChoseZoneCellID";
static  NSString *FSChoseZoneHistoryCellID = @"FSChoseZoneHistoryCellID";
static  NSString *FSChoseZoneListCellID = @"FSChoseZoneListCellID";

#pragma mark - Configuration
- (void)configuration {
    self.navigationItem.title = @"区域选择";
    [self.tableView registerClass:[FSChoseZoneCell class] forCellReuseIdentifier:FSChoseZoneCellID];

    [self.tableView registerClass:[FSChoseZoneHistoryCell class] forCellReuseIdentifier:FSChoseZoneHistoryCellID];
//    [self.tableView registerClass:[FSChoseZoneListCell class] forCellReuseIdentifier:FSChoseZoneListCellID];

    self.tableView.mj_footer.hidden = YES;
}

#pragma mark - ConfigUI
- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];
}

#pragma mark - RequestData
- (void)loadData {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.locationManager){
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 1.0;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
                [self.locationManager requestWhenInUseAuthorization];
            }
            [self.locationManager startUpdatingLocation];
        } else {
            [self.locationManager startUpdatingLocation];
        }
    });
//    FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];
//    self.dataArray = [choseZoneMData choseCityWithCity:nil];
    // ----------- 本地假数据 -----------
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *summary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *cites = summary[@"data"];
    FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];
    self.dataArray = [choseZoneMData choseCityWithCity:nil cites:cites];
    //NSLog(@"dataArray:%@", self.dataArray);
    // ----------- 本地假数据 -----------

    NSMutableArray *tempIndexs = [NSMutableArray array];
    for (FSChoseZoneMData *choseZoneMData in self.dataArray) {
        NSString *indexStr = choseZoneMData.sectionHeaderTitle;
        if ([indexStr isEqualToString:@"当前定位城市"]) {
            indexStr = @"定位";
        }
        if ([indexStr isEqualToString:@"历史选择"]) {
            indexStr = @"历史";
        }
        [tempIndexs addObject:indexStr];
    }
    self.sectionIndexs = tempIndexs;

    self.choseZoneDataType = FSChoseZoneDataTypePosition;
}

#pragma mark - 获取城市信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            /** 暂停地理位置获取 */
            [self.locationManager stopUpdatingLocation];

            // ----------- 本地假数据 -----------
            NSString *path = [[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *summary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *cites = summary[@"data"];
            FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];
            self.dataArray = [choseZoneMData choseCityWithCity:nil cites:cites];
            //NSLog(@"dataArray:%@", self.dataArray);
            // ----------- 本地假数据 -----------
            
            [self.tableView reloadData];
        } else if (error == nil && [array count] == 0){
            
        } else if (error != nil){

        }
    }];
}

#pragma mark - CustomDelegate
#pragma mark FSSearchBarViewDelegate
- (void)searchBarViewDidClick: (FSSearchBarView *)searchBarView
                         type: (FSSearchBarButtonType)type {
    if (type == FSSearchBarButtonTypeClearSearchString) {
        self.searchBar.searchString = nil;
    } else if (type == FSSearchBarButtonTypeSearch) {
        
    }
}

- (void)searchBarView:(FSSearchBarView *)searchBarView userInput: (NSString *)text {
    FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];

    if (text.length) {
        self.choseZoneDataType = FSChoseZoneDataTypeSearchList;
        NSMutableArray *array = [choseZoneMData searchCity];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (FSChoseZoneMData *choseZoneMData in array) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", text];
            if ([predicate evaluateWithObject:choseZoneMData.title]) {
                [dataArray addObject:choseZoneMData];
            }
        }
        self.dataArray = dataArray;
    } else {
        self.choseZoneDataType = FSChoseZoneDataTypePosition;
        self.dataArray = [choseZoneMData choseGroupCityWithCity:nil];;
    }
    [self.tableView reloadData];
}

#pragma mark FSChoseZoneCellDelegate
- (void)choseZoneCell:(FSChoseZoneCell *)cell choseZoneMData:(FSChoseZoneMData *)choseZoneMData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseZoneViewController:locationCity:)]) {
        [self.delegate choseZoneViewController:self locationCity:choseZoneMData.title];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        return self.dataArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        FSChoseZoneMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
        return sectionMData.items.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FSChoseZoneCell *zoneCell = [tableView dequeueReusableCellWithIdentifier:FSChoseZoneCellID];
    zoneCell.delegate = self;
    FSChoseZoneHistoryCell *historyCell = [[FSChoseZoneHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSChoseZoneHistoryCellID];

    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        FSChoseZoneMData *sectionMData = [self.dataArray by_ObjectAtIndex:indexPath.section];
        FSChoseZoneMData *rowMData = [sectionMData.items by_ObjectAtIndex:indexPath.row];
        if (indexPath.section == 1) {
            historyCell.textLabel.text = rowMData.cityName;
            return historyCell;
        }else {
            zoneCell.rowMData = rowMData;
            return zoneCell;
        }
    }else {
        FSChoseZoneMData *rowMData = [self.dataArray by_ObjectAtIndex:indexPath.row];
        zoneCell.rowMData = rowMData;
        return zoneCell;
    }
}

CGFloat SearchH = 56.0f;
CGFloat NomalCellH = 44.0f;
CGFloat HistoryCellH = 60.0f;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat CellH = 0;
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        if(indexPath.section == 1) {
            CellH = HistoryCellH;
        }else {
            CellH = NomalCellH;
        }
    }else {
         CellH = NomalCellH;
    }
    return CellH;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexs;
}

#pragma mark - UITableViewDelegate

#pragma mark Header
CGFloat HeaderH = 19.0f;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        FSChoseZoneMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
        FSChoseZoneSectionHeader *sectionHeader = [[FSChoseZoneSectionHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoWithSize(HeaderH))];
        //NSLog(@"sectionMData :%@", sectionMData);
        sectionHeader.sectionMData = sectionMData;
        return sectionHeader;
    } else if (self.choseZoneDataType == FSChoseZoneDataTypeSearchList) {
        return nil;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        return kAutoWithSize(HeaderH);
    } else {
        return 0.01f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];
}

#pragma mark - LazyGet
- (FSSearchBarView *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[FSSearchBarView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kAutoWithSize(56))];
        _searchBar.searchBarType = FSSearchBarTypeZoneSearch;
        _searchBar.delegate = self;
    }
    return _searchBar;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)cityArray {
    if (_cityArray == nil) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (NSArray *)sectionIndexs {
    if (_sectionIndexs == nil) {
        _sectionIndexs = [NSMutableArray array];
    }
    return _sectionIndexs;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight + self.searchBar.height , kScreenWidth, kScreenHeight - kSafeAreaTopHeight - self.searchBar.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO;//关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];// tableFooterView设置

        _tableView.sectionIndexColor = [UIColor colorWithHexString:@"#007AFF"];//修改右边索引字体的颜色
    }
    return _tableView;
}

@end
