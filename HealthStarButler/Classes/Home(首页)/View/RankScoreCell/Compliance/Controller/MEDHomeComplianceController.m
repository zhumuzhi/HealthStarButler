//
//  MEDHomeComplianceController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/15.
//  Copyright © 2017年 Meridian. All rights reserved.
//  依从性

#import "MEDHomeComplianceController.h"
#import "MEDHomeComplianceModel.h"
#import "MEDHomeComplianceCell.h"

//跳转操作
//#import "MEDBloodPressureController.h"     //血压
//#import "MEDBloodGlucoseController.h"      //血糖
//#import "MEDBloodOxygenController.h"       //血氧
//#import "MEDWeightMonitorController.h"     //体重
//#import "MEDWaistlindeMonitorController.h" //腰围
//#import "MED_QWP_FoodDiaryVC.h"         //饮食日志

//static NSString *const ID = @"cell";                                 //测试ID
//static NSString *const HomeComplianceCellID = @"HomeComplianceCell"; //预留ID

static NSString *const cellID = @"complianceCell";

@interface MEDHomeComplianceController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *complianceDataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MEDHomeComplianceController

#pragma mark - dataRequest
- (void)dataRequest {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setObject:userModel.uid forKey:@"uid"];
    }
    //NSString *URL = @"health/personalIndexRanking/list";
    
    //NSLog(@"山东首页请求参数:%@", param);
    [MEDDataRequest GET:MED_HomeScoreExplain params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"请求成功，返回的结果为:%@", responseObject);
        NSDictionary *homeScoreDict = responseObject[@"data"];
        NSMutableArray *complianceDes = homeScoreDict[@"complianceDes"];
        
        self.complianceDataArray  = complianceDes;
        
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败，原因为:%@", error);
    }];
}

#pragma mark - LifCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"依从性";
    //self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = MEDRGB(243, 243, 243);
    [self setupIntroductionsView];  //设置指示View
    [self.view addSubview:self.tableView];
    
    [self dataRequest];
    
    //NSLog(@"验证数据:%@", self.complianceDataArray);
    self.tableView.tableFooterView = [UIView new];
}

//指示View
- (void)setupIntroductionsView {
    UIView *introductionsView = [[UIView alloc] init];
    introductionsView.frame = CGRectMake(0, KStatusBarHeight, kScreenWidth, 40);
    introductionsView.backgroundColor = MEDRGB(234, 245, 248);
    [self.view addSubview:introductionsView];
    
    UILabel *IntroductionsLabel = [[UILabel alloc] init];
    IntroductionsLabel.text = @"依从性是计算分数的重要依据...";
    IntroductionsLabel.font = [UIFont systemFontOfSize:14];
    IntroductionsLabel.textColor = MEDRGB(153, 153, 153);
    IntroductionsLabel.frame = CGRectMake(10, 10, kScreenWidth - 20, 20);
    IntroductionsLabel.textAlignment = NSTextAlignmentLeft;
    [introductionsView addSubview:IntroductionsLabel];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.complianceDataArray != nil && ![self.complianceDataArray isKindOfClass:[NSNull class]] && self.complianceDataArray.count != 0) {
        return self.complianceDataArray.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MEDHomeComplianceCell *cell = [MEDHomeComplianceCell complianceCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MEDHomeComplianceModel *model = [MEDHomeComplianceModel complianceWithDict:self.complianceDataArray[indexPath.row]];
    cell.complianceModel = model;
    
    [cell.finishButton addTarget:self action:@selector(buttonAction:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - Event

-(void)buttonAction:(UIButton*)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint Position = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:Position];
    if (indexPath!= nil)    {
        MEDHomeComplianceCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell.titleName.text isEqualToString:@"血压"]) {
            
//            MEDBloodPressureController *bloodPressure = [[MEDBloodPressureController alloc] init];
//            bloodPressure.monModel = model1;
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:bloodPressure animated:YES];
            
        } else if([cell.titleName.text isEqualToString:@"空腹血糖"]) {
//            MEDBloodGlucoseController *bloodGlucose = [[MEDBloodGlucoseController alloc] init];
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:bloodGlucose animated:YES];
            
        }else if([cell.titleName.text isEqualToString:@"血氧"]) {
//            MEDBloodOxygenController *bloodOxygen = [[MEDBloodOxygenController alloc] init];
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:bloodOxygen animated:YES];
            
        }else if([cell.titleName.text isEqualToString:@"餐后2小时血糖"]) {
//            MEDBloodGlucoseController *bloodGlucose = [[MEDBloodGlucoseController alloc] init];
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:bloodGlucose animated:YES];
            
        }else if([cell.titleName.text isEqualToString:@"饮食"]) {
            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//            NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
//
//            MED_QWP_FoodDiaryVC *foodDiary = [[MED_QWP_FoodDiaryVC alloc] init];
//            foodDiary.dateStr = strDate;
//            foodDiary.isLivingHabit = YES;
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:foodDiary animated:YES];
            
        }else if([cell.titleName.text isEqualToString:@"体重"]) {
//            MEDWeightMonitorController *weight = [[MEDWeightMonitorController alloc] init];
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:weight animated:YES];
            
        }else if([cell.titleName.text isEqualToString:@"腰围"]) {
//            MEDWaistlindeMonitorController *waistline = [[MEDWaistlindeMonitorController alloc] init];
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:waistline animated:YES];
            
        }else if([cell.titleName.text isEqualToString:@"运动"]) {
            //NSLog(@"跳转到%@", cell.titleName.text);
        }else if([cell.titleName.text isEqualToString:@"睡眠"]) {
            //NSLog(@"跳转到%@", cell.titleName.text);
        }
    }
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSIndexPath *selectIndex = [self.tableView indexPathForSelectedRow];
    //    MEDHomeComplianceCell *cell = [self.tableView cellForRowAtIndexPath:selectIndex];
    //NSLog(@"模型为:%@", cell.complianceModel);
    //NSLog(@"标题为:%@", cell.titleName.text);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSeparatorWithTarget:cell Inset:UIEdgeInsetsZero];
}

- (void)setSeparatorWithTarget:(id)target Inset:(UIEdgeInsets)inset {
    [target setSeparatorInset:inset];
    if ([target respondsToSelector:@selector(setLayoutMargins:)]) {
        [target setLayoutMargins:inset];
    }
}


#pragma mark - Lazy
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (KStatusBarHeight+50), kScreenWidth, kScreenHeight-(KStatusBarHeight+50)) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomeComplianceCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

#pragma mark falseData
//-(NSMutableArray *)complianceDataArray {
//    if (_complianceDataArray == nil) {
//        NSArray *falseData = @[
//                                @{
//                                    @"complete": @0,
//                                    @"frequency": @2,
//                                    @"title": @"血压"
//                                    },
//                                @{
//                                    @"complete": @1,
//                                    @"frequency": @1,
//                                    @"title": @"体重"
//                                    },
//                                @{
//                                    @"complete": @1,
//                                    @"frequency": @1,
//                                    @"title": @"空腹血糖"
//                                    },
//                                @{
//                                    @"complete": @1,
//                                    @"frequency": @1,
//                                    @"title": @"餐后2小时血糖"
//                                    },
//                                @{
//                                    @"complete": @0,
//                                    @"frequency": @1,
//                                    @"title": @"饮食"
//                                    },
//                                @{
//                                    @"complete": @0,
//                                    @"frequency": @1,
//                                    @"title": @"运动"
//                                    },
//                                @{
//                                    @"complete": @0,
//                                    @"frequency": @1,
//                                    @"title": @"睡眠"
//                                    }
//                                ];;
//        NSMutableArray *tempA = [NSMutableArray array];
//        for (NSDictionary *dict in falseData) {
//            MEDHomeComplianceModel *CModel = [MEDHomeComplianceModel complianceWithDict:dict];
//            [tempA addObject:CModel];
//        }
//        _complianceDataArray = tempA;
//    }
//    return _complianceDataArray;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
