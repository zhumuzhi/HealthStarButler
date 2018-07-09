//
//  MEDHomePhysiologyController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/16.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomePhysiologyController.h"
#import "MEDHomePhysiologyModel.h"

#import "MEDHomePhysiologyBloodPressureCell.h"  //血压cell
#import "MEDHomePhysiologyBloodGlucoseCell.h"   //血糖cell
#import "MEDHomePhysiologyweightCell.h"         //体重cell
#import "MEDHomePhysiologyWaistlineCell.h"      //腰围cell

static NSString *const homePhysiologyBloodPressureCellID = @"homePhysiologyBloodPressureCell";
static NSString *const homePhysiologyBloodGlucoseCellID = @"homePhysiologyBloodGlucoseCell";
static NSString *const homePhysiologyWieghtCellID = @"homePhysiologyWieghtCell";
static NSString *const homePhysiologyWaistlineCellID = @"homePhysiologyWaistlineCell";

@interface MEDHomePhysiologyController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) NSMutableArray *physiologyDataArray;

@property (nonatomic, strong) NSMutableArray *physiologyDataArray;


//@property (nonatomic, strong) NSArray *bloodPressureArray;  //血压
//@property (nonatomic, strong) NSArray *bloodGlucoseArray;   //血糖
//@property (nonatomic, strong) NSArray *weightArray;         //体重
//@property (nonatomic, strong) NSArray *waistArray;          //腰围

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MEDHomePhysiologyController

#pragma mark - DataRequest
- (void)dataRequest {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setObject:userModel.uid forKey:@"uid"];
    }
    //NSString *URL = @"health/personalIndexRanking/list";
    [MEDDataRequest GET:MED_HomeScoreExplain params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"请求成功，返回的结果为:%@", responseObject);
        NSDictionary *homeScoreDict = responseObject[@"data"];
        NSMutableArray *complianceDes = homeScoreDict[@"physiologicalIndexMonitoringDes"];
        self.physiologyDataArray  = complianceDes;
        
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败，原因为:%@", error);
    }];
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"生理指标";
    self.view.backgroundColor = MEDRGB(243, 243, 243);
    [self setupIntroductionsView];
    
//  MEDHomePhysiologyHeader *headerView = [MEDHomePhysiologyHeader homePhysiologyHeaderView];
//  self.tableView.tableHeaderView = headerView;

    [self.view addSubview:self.tableView];
    [self dataRequest];
}

#pragma mark - UI
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (KStatusBarHeight+50), kScreenWidth, kScreenHeight-(KStatusBarHeight+50)) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomePhysiologyBloodPressureCell" bundle:nil] forCellReuseIdentifier:homePhysiologyBloodPressureCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomePhysiologyBloodGlucoseCell" bundle:nil] forCellReuseIdentifier:homePhysiologyBloodGlucoseCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomePhysiologyweightCell" bundle:nil] forCellReuseIdentifier:homePhysiologyWieghtCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomePhysiologyWaistlineCell" bundle:nil] forCellReuseIdentifier:homePhysiologyWaistlineCellID];
        
    }
    return _tableView;
}

//指示View
- (void)setupIntroductionsView {
    UIView *introductionsView = [[UIView alloc] init];
    introductionsView.frame = CGRectMake(0, KStatusBarHeight, kScreenWidth, 40);
    introductionsView.backgroundColor = MEDRGB(234, 245, 248);
    [self.view addSubview:introductionsView];
    
    UILabel *IntroductionsLabel = [[UILabel alloc] init];
    IntroductionsLabel.text = @"生理指标是计算分数的重要依据...";
    IntroductionsLabel.font = [UIFont systemFontOfSize:14];
    IntroductionsLabel.textColor = MEDRGB(153, 153, 153);
    IntroductionsLabel.frame = CGRectMake(10, 10, kScreenWidth - 20, 20);
    IntroductionsLabel.textAlignment = NSTextAlignmentLeft;
    [introductionsView addSubview:IntroductionsLabel];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MEDHomePhysiologyBloodPressureCell *bpcell = [MEDHomePhysiologyBloodPressureCell bloodPressureCellWithTableView:tableView];
        bpcell.bloodPressureData = self.physiologyDataArray;
        return bpcell;
        
    }else if (indexPath.section == 1) {
        MEDHomePhysiologyBloodGlucoseCell *bgcell = [MEDHomePhysiologyBloodGlucoseCell bloodGlucoseCellWithTableView:tableView];
        bgcell.bloodGlucoseData = self.physiologyDataArray;
        return bgcell;
        
    }else if (indexPath.section == 2) {
        MEDHomePhysiologyweightCell *wcell = [MEDHomePhysiologyweightCell weightCellWithTableView:tableView];
        wcell.weightData = self.physiologyDataArray;
        return wcell;
        
    }else {
        MEDHomePhysiologyWaistlineCell *wlcell = [MEDHomePhysiologyWaistlineCell waistlineCellWithTableView:tableView];
        wlcell.waistlineData = self.physiologyDataArray;
        return wlcell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1) {
        return 155;
    }else if (indexPath.section == 2) {
        return 125;
    }else if (indexPath.section == 3) {
        return 100;
    }else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 10;
}


#pragma mark - falseData 
//- (void)getData {
//    NSMutableArray *falseDict = [NSMutableArray arrayWithArray:@[
//                                                                 @{
//                                                                     @"result": @-1,
//                                                                     @"createTime": @"2017-08-15 11:12:29",
//                                                                     @"actualValue": @"135",
//                                                                     @"name": @"sbp",
//                                                                     @"suggestValue": @""
//                                                                     },
//                                                                 @{
//                                                                     @"result": @-1,
//                                                                     @"createTime": @"2017-08-15 11:12:29",
//                                                                     @"actualValue": @"88",
//                                                                     @"name": @"dbp",
//                                                                     @"suggestValue": @""
//                                                                     },
//                                                                 @{
//                                                                     @"result": @-1,
//                                                                     @"createTime": @"2017-07-28 14:57:39",
//                                                                     @"actualValue": @"166.0",
//                                                                     @"name": @"height",
//                                                                     @"suggestValue": @""
//                                                                     },
//                                                                 @{
//                                                                     @"result": @-1,
//                                                                     @"createTime": @"2017-07-28 14:57:39",
//                                                                     @"actualValue": @"79.7",
//                                                                     @"name": @"weight",
//                                                                     @"suggestValue": @""
//                                                                     },
//                                                                 @{
//                                                                     @"result": @-1,
//                                                                     @"createTime": @"2017-07-28 14:57:39",
//                                                                     @"actualValue": @"28.92",
//                                                                     @"name": @"bmi",
//                                                                     @"suggestValue": @""
//                                                                     },
//                                                                 @{
//                                                                     @"result": @1,
//                                                                     @"createTime": @"2017-08-15 11:12:29",
//                                                                     @"actualValue": @"5.3",
//                                                                     @"name": @"fbg",
//                                                                     @"suggestValue": @""
//                                                                     },
//                                                                 @{
//                                                                     @"result": @-1,
//                                                                     @"createTime": @"2017-08-15 11:12:29",
//                                                                     @"actualValue": @"8.2",
//                                                                     @"name": @"meal2bg",
//                                                                     @"suggestValue": @""
//                                                                     }
//                                                                 ]];
//
//    self.physiologyDataArray = falseDict;
//    [self.tableView reloadData];
//}

@end
