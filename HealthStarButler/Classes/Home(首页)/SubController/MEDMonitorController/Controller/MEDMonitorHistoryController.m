//
//  MEDMonitorHistoryController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDMonitorHistoryController.h"

#import "MEDMonitorHeaderView.h"
//Model
#import "MEDBloodpressureModel.h"
//Cell
#import "MEDBloodPressureCell.h"

#import "ITDatePickerController.h"

@interface MEDMonitorHistoryController ()<UITableViewDelegate, UITableViewDataSource,ITDatePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *historyDatas; //历史数据
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIButton *dateButton;
@property (nonatomic, copy) NSString *datePickStr;

@end

@implementation MEDMonitorHistoryController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigation];
    [self sendRequestStartDate:self.startDate endDate:self.endDate];
    
}

#pragma mark - DataRequest
- (void)sendRequestStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSString *URL = @"http://miot2.mmednet.com/app/health/bloodpressure/list";
    NSDictionary* parameters = @{
                                 @"uid":@"61004",
                                 @"orga_id":@"1116",
                                 @"ps":@"10",
                                 @"pn":@"1",
                                 @"start_date":startDate,
                                 @"end_date":endDate,
                                 };
    
    [MEDDataRequest GET:URL params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"拿到近期结果为:%@" , responseObject);
        
        if ([responseObject[@"status"] integerValue] == 0) {
            NSArray *array = responseObject[@"data"];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                MEDBloodpressureModel *model = [[MEDBloodpressureModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [tempArray addObject:model];
            }
            self.historyDatas = tempArray;
        }
        
        [self.view addSubview:self.tableView];
        self.endDate = endDate;
        [self.tableView reloadData];
        //NSLog(@"最终的历史数据数组为:%@", self.historyDatas);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"近期请求错误，原因:%@" , error);
        
    }];
}

#pragma mark UI
- (NSMutableArray *)historyDatas {
    if (_historyDatas == nil) {
        _historyDatas = [NSMutableArray array];
    }
    return _historyDatas;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect tableFrame = CGRectMake(0, Navigation_Height, SCREEN_WIDTH, SCREEN_HEIGHT - Navigation_Height);
        _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_historyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = MEDGrayColor(232);
    }
    return _tableView;
}

#pragma mark  TableViewDataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MEDBloodPressureCell *cell = [MEDBloodPressureCell bloodPressureCellWithTableView:tableView];
    MEDBloodpressureModel *model = self.historyDatas[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark  TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
}

//HeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MEDMonitorHeaderView *head = [MEDMonitorHeaderView monitorHeaderViewWithTableView:self.tableView];
    head.historyButton.hidden = YES;
    head.historyIndicator.hidden = YES;
    [head setHeadTitle:self.endDate];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

#pragma mark - Navigation
- (void)setupNavigation {
    self.title = @"历史数据";
    
    if (@available(iOS 11.0, *)) {
        //大标题测试
//        self.navigationController.navigationBar.prefersLargeTitles = YES;
//        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
        NSLog(@"手机系统低于iOS 11.0");
    }
    
    UIButton *dateButton = [[UIButton alloc] init];
    self.dateButton = dateButton;
    dateButton.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 44, 44);
    //[addButton.titleLabel setFont:sysFont(14)];
    [dateButton addTarget:self action:@selector(dateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [dateButton setTitle:@"切换" forState:UIControlStateNormal];
//    [dateButton setImage:[UIImage imageNamed:@"tab_magement"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:dateButton];

}

- (void)dateButtonClick {
    
    //NSLog(@"点击了历史日期选择按钮");
    ITDatePickerController *datePickerController = [[ITDatePickerController alloc] init];
    datePickerController.tag = 100;                     // Tag, which may be used in delegate methods
    datePickerController.delegate = self;               // Set the callback object
    datePickerController.showToday = NO;                // Whether to show "today", default is yes
    datePickerController.defaultDate = [NSDate date];   // Default date
    datePickerController.maximumDate = [NSDate date];   // maxinum date
    
    [self presentViewController:datePickerController animated:YES completion:nil];
    
}

#pragma mark - ITDatePickerControllerDelegate
- (void)datePickerController:(ITDatePickerController *)datePickerController didSelectedDate:(NSDate *)date dateString:(NSString *)dateString {
    //NSLog(@"date:%@ -- datedateString:%@", date, dateString);
    NSString *dateStr = [self dateyyyyMMStrFromDate:date];
    self.datePickStr = dateStr;
    
    //起止日期
    NSString *startDateStr = [NSString stringWithFormat:@"%@-01",dateStr];
    NSString *endDateStr = [NSString stringWithFormat:@"%@-%d",dateStr,[self currentDays]];
    NSLog(@"转换完成拿到的开始时间为:%@--结束时间为:%@", startDateStr, endDateStr);
    [self sendRequestStartDate:startDateStr endDate:endDateStr];
}

//天数
- (int)currentDays {
    NSString *currentDateStr = [self dateyyyyMMddStrFromDate:[NSDate date]];
    NSArray *array = [currentDateStr componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
    if ([str isEqualToString:self.datePickStr]) {
        return [[array objectAtIndex:2] intValue];
    } else{
        return [self numberDaysOfmonth];
    }
}

//月的天数
- (int)numberDaysOfmonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [self dateFromDateyyyyMMStr:self.datePickStr];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    //    return (int)days.length+1;
    return (int)days.length;
}

- (NSString *)dateyyyyMMddStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSString *)dateyyyyMMStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSDate *)dateFromDateyyyyMMStr:(NSString *)dateStr {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

@end
