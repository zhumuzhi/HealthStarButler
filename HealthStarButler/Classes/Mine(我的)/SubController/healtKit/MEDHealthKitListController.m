//
//  MEDHealthKitListController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHealthKitListController.h"
#import "HealthKitDetailViewController.h"

@interface MEDHealthKitListController () <UITableViewDelegate , UITableViewDataSource>

/**数据列表 */
@property (nonatomic , strong)NSArray *list;
@property (nonatomic , strong)NSArray *nameList;

@end

@implementation MEDHealthKitListController

-(NSArray *)nameList{
    if (!_nameList) {
        _nameList = @[@"步行 Step",
                      @"跑步+步行 Walking",
                      @"骑行 Cycling",
                      @"游泳 Swimming",
                      @"身高 Height",
                      @"体重 BodyMass",
                      @"活动能量 ActiveEnergyBurned",
                      @"膳食能量 BasalEnergyBurned",
                      @"血糖 BloodGlucose",
                      @"收缩压 BloodPressureSystolic",
                      @"舒张压 BloodPressureDiastolic"];
    }
    return _nameList;
}

- (NSArray *)list {
    if (!_list) {
        _list = @[@"TFQuantityTypeStep",
                  @"TFQuantityTypeWalking",
                  @"TFQuantityTypeCycling",
                  @"TFQuantityTypeSwimming",
                  @"TFQuantityTypeHeight",
                  @"TFQuantityTypeBodyMass",
                  @"TFQuantityTypeActiveEnergyBurned",
                  @"TFQuantityTypeBasalEnergyBurned",
                  @"TFQuantityTypeBloodGlucose",
                  @"TFQuantityTypeBloodPressureSystolic",
                  @"TFQuantityTypeBloodPressureDiastolic"];
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.frame = self.view.frame;
    [self.view addSubview:tableView];
}

- (IBAction)authorizeHealth:(id)sender {
    
    //    [TFHealthManager TF_fetchAllHealthType:TFHealthIntervalUnitMonth queryResultBlock:^(NSArray *queryResults) {
    //        for (NSDictionary *dic in queryResults) {
    //            NSLog(@"----startDate = %@" ,dic[@"startDate"]);
    //            NSLog(@"----endDate = %@" , dic[@"endDate"]);
    //            NSLog(@"----count = %@" , dic[@"stepCount"]);
    //        }
    //    }];
    
    
    
    //     [TFHealthManager TF_getAllStepCount:^(NSUInteger stepCount) {
    //         NSLog(@"%lu" , (unsigned long)stepCount);
    //     }];
    //    [TFHealthManager TF_getStepCountWithHourOf0ClockBlock:^(NSArray *queryResults) {
    //        NSLog(@"%@" , queryResults);
    //    }];
    //     [TFHealthManager TF_getDayHealthWithType:TFQuantityTypeBloodPressureDiastolic queryResultBlock:^(NSArray *queryResults) {
    //         NSLog(@"%@" , queryResults);
    //     }];
    //    NSDate *endDate         = [NSDate TF_getCurrentDate];
    //    NSDate *startDate       = [NSDate TF_dateAfterDate:endDate day:-1];
    //    //必须都加入收缩压和舒张压，健康数据才会有显示，但是提前最好判断一下数值范围
    //    [TFHealthManager TF_saveHealthKitDataType:TFQuantityTypeBloodPressureSystolic startDate:startDate endDate:endDate number:45.0f success:^(bool isSuccess, NSError *error) {
    //        NSLog(@"%d" ,isSuccess);
    //    }];
    //    [TFHealthManager TF_saveHealthKitDataType:TFQuantityTypeBloodPressureDiastolic startDate:startDate endDate:endDate number:110.0f success:^(bool isSuccess, NSError *error) {
    //        NSLog(@"%d" ,isSuccess);
    //    }];
}
#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.nameList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HealthKitDetailViewController *nextVc = [[HealthKitDetailViewController alloc] init];
    nextVc.type = self.list[indexPath.row];
    [self.navigationController pushViewController:nextVc animated:YES];
}

@end
