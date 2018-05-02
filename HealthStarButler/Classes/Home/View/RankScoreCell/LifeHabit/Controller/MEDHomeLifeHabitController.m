//
//  MEDHomeLifeHabitController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/16.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomeLifeHabitController.h"

#import "MEDHomeHabitFoodCell.h"    //饮食cell
#import "MEDHomeHabitSportCell.h"   //运动cell
#import "MEDHomeHabitSleepCell.h"   //睡眠cell

//#import "MED_QWP_FoodDiaryVC.h"     //饮食日志
#import "MEDHomePhysiologyModel.h"


static NSString *const homeHabitFoodCellID = @"homeHabitFoodCell";
static NSString *const homeHabitSportCellID = @"homeHabitSportCellID";
static NSString *const homeHabitSleepCellID = @"homeHabitSleepCellID";

static NSString *const cellID = @"LifeHabitCell";

@interface MEDHomeLifeHabitController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *lifeHabitDataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MEDHomeLifeHabitController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"生活习惯";
    self.view.backgroundColor = MEDRGB(243, 243, 243);
    
    [self setupIntroductionsView];
    [self.view addSubview:self.tableView];
    
    [self dataRequest];
}


#pragma mark - DataRequest

- (void)dataRequest {
    
    [MEDProgressHUD showHUDStatusTitle:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setObject:userModel.uid forKey:@"uid"];
    }
    //NSString *URL = @"health/personalIndexRanking/list";
    [MEDDataRequest GET:MED_HomeScoreExplain params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"请求成功，返回的结果为:%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 0 ) {
            
            [MEDProgressHUD dismissHUD];
            NSDictionary *homeScoreDict = responseObject[@"data"];
            NSArray *habitsAndCustomsDes = homeScoreDict[@"habitsAndCustomsDes"];
            self.lifeHabitDataArray  = habitsAndCustomsDes;
            [self.tableView reloadData];
            
        }else {
            [MEDProgressHUD dismissHUDErrorTitle:@"生活习惯获取失败"];
        }
    
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败，原因为:%@", error);
        [MEDProgressHUD dismissHUDErrorTitle:@"生活习惯网络请求失败"];
    }];
}


#pragma mark - UI
//指示View
- (void)setupIntroductionsView {
    UIView *introductionsView = [[UIView alloc] init];
    introductionsView.frame = CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, 40);
    introductionsView.backgroundColor = MEDRGB(234, 245, 248);
    [self.view addSubview:introductionsView];
    
    UILabel *IntroductionsLabel = [[UILabel alloc] init];
    IntroductionsLabel.text = @"生活习惯是计算分数的重要依据...";
    IntroductionsLabel.font = [UIFont systemFontOfSize:14];
    IntroductionsLabel.textColor = MEDRGB(153, 153, 153);
    IntroductionsLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 20);
    IntroductionsLabel.textAlignment = NSTextAlignmentLeft;
    [introductionsView addSubview:IntroductionsLabel];
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (StatusBarHeight+50), SCREEN_WIDTH, SCREEN_HEIGHT-(StatusBarHeight+50)) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomeHabitFoodCell" bundle:nil] forCellReuseIdentifier:homeHabitFoodCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomeHabitSportCell" bundle:nil] forCellReuseIdentifier:homeHabitSportCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"MEDHomeHabitSleepCell" bundle:nil] forCellReuseIdentifier:homeHabitSleepCellID];
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MEDHomeHabitFoodCell *fcell = [MEDHomeHabitFoodCell habitFoodCellWithTableView:tableView];
        
        [fcell.SeeDetails addTarget:self action:@selector(buttonAction:event:) forControlEvents:UIControlEventTouchUpInside];
        
        fcell.foodData = self.lifeHabitDataArray;
        return fcell;
        
    }else if (indexPath.section == 1) {
        MEDHomeHabitSportCell *sportCell = [MEDHomeHabitSportCell habitSportCellWithTableView:tableView];
        sportCell.sportData = self.lifeHabitDataArray;
        return sportCell;
        
    }else {
        MEDHomeHabitSleepCell *slcell = [MEDHomeHabitSleepCell habitSleepCellWithTableView:tableView];
        slcell.sleepData = self.lifeHabitDataArray;
        return slcell;
    }
}

-(void)buttonAction:(UIButton*)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint Position = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:Position];
    if (indexPath!= nil)    {
        
        // 时间逻辑调整，如果后台返回时间数据，使用后台时间，如果不反回使用当天时间减去一天
        if (self.lifeHabitDataArray != nil && ![self.lifeHabitDataArray isKindOfClass:[NSNull class]] && self.lifeHabitDataArray.count != 0) {
            NSString *foodDataStr = [NSString string];
            
            BOOL hasFood = NO;
            NSString *strDate = [NSString string];
            
            for (NSDictionary *dict in self.lifeHabitDataArray) {
                MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
                
                if ([model.name isEqualToString:@"food"]) {
                    foodDataStr = model.createTime;
                    //NSLog(@"获取的时间为:%@", foodDataStr);
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    
                    if (foodDataStr.length>0) {
                        NSArray *array = [foodDataStr componentsSeparatedByString:@" "];
                        foodDataStr = [array firstObject];
                        NSDate *DataDate = [dateFormatter dateFromString:foodDataStr];
                        strDate = [dateFormatter stringFromDate:DataDate];
                    }else {
                        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];
                        strDate = [dateFormatter stringFromDate:lastDay];
                    }
                    //NSLog(@"最终的日期为:%@", strDate);
                    hasFood = YES;
                }
            }
            
            if (hasFood == YES) {
                //NSLog(@"确定有food");
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];
                strDate = [dateFormatter stringFromDate:lastDay];
                
//                MED_QWP_FoodDiaryVC *foodDiary = [[MED_QWP_FoodDiaryVC alloc] init];
//                foodDiary.dateStr = strDate;
//                foodDiary.isLivingHabit = YES;
//                self.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:foodDiary animated:YES];
            }else {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                strDate = [dateFormatter stringFromDate:[NSDate date]];
                
//                MED_QWP_FoodDiaryVC *foodDiary = [[MED_QWP_FoodDiaryVC alloc] init];
//                foodDiary.dateStr = strDate;
//                foodDiary.isLivingHabit = YES;
//                self.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:foodDiary animated:YES];
            }
            
        }else {
            
            NSString *strDate;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            strDate = [dateFormatter stringFromDate:[NSDate date]];
            
            NSLog(@"最终的日期为:%@", strDate);
            
//            MED_QWP_FoodDiaryVC *foodDiary = [[MED_QWP_FoodDiaryVC alloc] init];
//            foodDiary.dateStr = strDate;
//            foodDiary.isLivingHabit = YES;
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:foodDiary animated:YES];
        }
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 125;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Lazy

#pragma mark - falseData
//- (void)getData {
//    
//    NSArray *falseDict= @[
//                          @{
//                              @"result":@1,
//                              @"createTime":@"2017-08-14 00:00:00",
//                              @"actualValue":@"419千卡",
//                              @"name":@"food",
//                              @"suggestValue":@"324~351"
//                              },
//                          @{
//                              @"result":@1,
//                              @"createTime":@"2017-08-14 00:00:00",
//                              @"actualValue":@"8小时17分钟",
//                              @"name":@"sleep",
//                              @"suggestValue":@"8小时"
//                              },
//                          
//                          @{
//                              @"result":@1,
//                              @"createTime":@"2017-08-14 00:00:00",
//                              @"actualValue":@"7小时30分钟",
//                              @"name":@"sport",
//                              @"suggestValue":@"7~9小时"
//                              }
//                          ];
//    
//    self.lifeHabitDataArray = falseDict;
//    [self.tableView reloadData];
//}



@end
