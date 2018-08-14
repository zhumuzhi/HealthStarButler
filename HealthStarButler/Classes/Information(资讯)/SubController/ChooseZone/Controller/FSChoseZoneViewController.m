//
//  FSChoseZoneViewController.m
//  FangShengyun
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSChoseZoneViewController.h"
#import "FSSearchBarView.h"
#import "FSChoseZoneMData.h"
#import "FSChoseZoneCell.h"
#import "FSChoseZoneSectionHeader.h"
#import <CoreLocation/CoreLocation.h>

@interface FSChoseZoneViewController ()<FSSearchBarViewDelegate,CLLocationManagerDelegate,FSChoseZoneCellDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic , strong) FSSearchBarView *header;
@property (nonatomic , assign) FSChoseZoneDataType choseZoneDataType;
@property (nonatomic , strong) CLLocationManager *locationManager;

@end

@implementation FSChoseZoneViewController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configuration];
    [self setupUI];
    [self loadData];
}

#pragma mark - ConfigUI
- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.header];
}
#pragma mark - Configuration
- (void)configuration {
    self.navigationItem.title = @"区域选择";
    [self.tableView registerClass:[FSChoseZoneCell class] forCellReuseIdentifier:@"FSChoseZoneCellID"];
    self.tableView.mj_footer.hidden = YES;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight + self.header.height , kScreenWidth, kScreenHeight - kSafeAreaTopHeight - self.header.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO;                 //关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置
    }
    return _tableView;
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
    FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];
    self.dataArray = [choseZoneMData choseCityWithCity:nil];
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
            
            FSChoseZoneMData *choseZoneMData = [[FSChoseZoneMData alloc]init];
            self.dataArray = [choseZoneMData choseCityWithCity:city];
            [self.tableView reloadData];
        } else if (error == nil && [array count] == 0){
            
        } else if (error != nil){
            
        }
    }];
}

#pragma mark - CustomDelegate

#pragma mark - FSSearchBarViewDelegate
- (void)searchBarViewDidClick: (FSSearchBarView *)searchBarView
                         type: (FSSearchBarButtonType)type {
    if (type == FSSearchBarButtonTypeClearSearchString) {
        self.header.searchString = nil;
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

#pragma mark - FSChoseZoneCellDelegate
- (void)choseZoneCell:(FSChoseZoneCell *)cell choseZoneMData:(FSChoseZoneMData *)choseZoneMData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseZoneViewController:locationCity:)]) {
        [self.delegate choseZoneViewController:self locationCity:choseZoneMData.title];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDataSource
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
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSChoseZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FSChoseZoneCellID"];
    cell.delegate = self;
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        FSChoseZoneMData *sectionMData = [self.dataArray by_ObjectAtIndex:indexPath.section];
        FSChoseZoneMData *rowMData = [sectionMData.items by_ObjectAtIndex:indexPath.row];
        cell.rowMData = rowMData;
        return cell;
    } else {
        FSChoseZoneMData *rowMData = [self.dataArray by_ObjectAtIndex:indexPath.row];
        cell.rowMData = rowMData;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        FSChoseZoneMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
        FSChoseZoneSectionHeader *sectionHeader = [[FSChoseZoneSectionHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoWithSize(40))];
        sectionHeader.sectionMData = sectionMData;
        return sectionHeader;
    } else if (self.choseZoneDataType == FSChoseZoneDataTypeSearchList) {
        return nil;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.choseZoneDataType == FSChoseZoneDataTypePosition) {
        return kAutoWithSize(40);
    } else {
        return 0.01f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];
}

#pragma mark - LazyGet
- (FSSearchBarView *)header {
    if (_header == nil) {
        _header = [[FSSearchBarView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kAutoWithSize(56))];
        _header.searchBarType = FSSearchBarTypeZoneSearch;
        _header.delegate = self;
    }
    return _header;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
