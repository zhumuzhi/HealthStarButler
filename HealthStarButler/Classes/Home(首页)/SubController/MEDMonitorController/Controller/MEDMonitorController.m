//
//  MEDMonitorController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDMonitorController.h"

#import "MEDMonitorDateView.h"  //日期选择View
//Header
#import "MEDMonitorHeaderView.h"
//Model
#import "MEDBloodpressureModel.h"
//Cell
#import "MEDBloodPressureCell.h"
#import "MEDBloodPressureCodeCell.h"

//历史列表
#import "MEDMonitorHistoryController.h"

//********** 图表 **********
#import "MEDMonitorLineChart.h"


@interface MEDMonitorController ()<UITableViewDataSource, UITableViewDelegate>
// 请求起止时间
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
// 日期选择
@property (nonatomic, weak) MEDMonitorDateView  *datePick;
// 图表
@property (nonatomic, weak) MEDMonitorLineChart *lineChart;
// 历史记录
@property (nonatomic, strong) NSMutableArray    *historyDatas; //历史数据(table使用)
@property (nonatomic, strong) UITableView       *historyTable;

@end

@implementation MEDMonitorController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moitorType = MEDMoitorTypeBloodPressure;

    self.view.backgroundColor = MEDGrayColor(243);
    [self setupNavigation];
    [self setupDatePickView];
}

#pragma mark - Navigation
- (void)setupNavigation {
    
    switch (self.moitorType) {
        case MEDMoitorTypeBloodPressure:
            self.title = @"血压监测";
            break;
        case MEDMoitorTypeBloodGlucose:
            self.title = @"血糖监测";
            break;
        case MEDMoitorTypeBloodOxygen:
            self.title = @"血氧监测";
            break;
        case MEDMoitorTypeWeight:
            self.title = @"体重监测";
            break;
        case MEDMoitorTypeWaistline:
            self.title = @"腰围监测";
            break;
        case MEDMoitorTypeSleep:
            self.title = @"睡眠监测";
            break;
        default:
            break;
    }
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
        //NSLog(@"拿到近期结果为:%@" , responseObject);

        if ([responseObject[@"status"] integerValue] == 0) {
            
            NSMutableArray *array = responseObject[@"data"];
            array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
            
            // *********************** 图表数据 ***********************
            NSMutableArray *diastolicArray = [[NSMutableArray alloc] init];  //舒张压数组
            NSMutableArray *systolicArray = [[NSMutableArray alloc] init];   //收缩压数
            
            int m = [self.datePick currentDays];
            
            for (int i = 0; i<m; i++) {
                [systolicArray addObject:@"0"];
                [diastolicArray addObject:@"0"];
            }
            NSString *tempTimeStr = [[NSString alloc] init];
            for (NSDictionary *dic in array) {
                NSString *timerStr = [dic objectForKey:@"meas_date"];
                NSArray *array = [timerStr componentsSeparatedByString:@" "];
                if (tempTimeStr.length !=0 && [[array objectAtIndex:0] isEqualToString:tempTimeStr]) {
                    continue;
                }
                tempTimeStr = [array objectAtIndex:0];
                
                NSArray *array2 = [tempTimeStr componentsSeparatedByString:@"-"];
                NSString *lastDate = [array2 objectAtIndex:2];
                
                [systolicArray replaceObjectAtIndex:[lastDate integerValue]-1 withObject:[dic objectForKey:@"systolic"]];
                [diastolicArray replaceObjectAtIndex:[lastDate integerValue]-1 withObject:[dic objectForKey:@"diastolic"]];
            }
            
            MEDLineChartData *systolicData = [MEDLineChartData lineChartDataWithValuesArray:systolicArray lineColor:MEDRGB(28, 196, 225)];
            systolicData.lineWidth = 1.5;
            systolicData.circleType = MEDLineDataCircleTypeCircle;
            
            MEDLineChartData *diastolicData = [MEDLineChartData lineChartDataWithValuesArray:diastolicArray lineColor:MEDRGB(87, 174, 251)];
            diastolicData.lineWidth = 1.5;
            diastolicData.circleType = MEDLineDataCircleTypeCircle;
            [self setupLineChartWithValueArray:@[systolicData, diastolicData] ];
            // *********************** 图表数据 ***********************
            
            // *********************** 近期table数据  ***********************
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                MEDBloodpressureModel *model = [[MEDBloodpressureModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [tempArray addObject:model];
            }
            tempArray = (NSMutableArray *)[[tempArray reverseObjectEnumerator] allObjects];
            self.historyDatas = tempArray;
            // *********************** 近期table数据  ***********************
        }
        
        [self.view addSubview:self.historyTable];
        self.startDate = startDate;
        self.endDate = endDate;
        [self.historyTable reloadData];
        //NSLog(@"最终的历史数据数组为:%@", self.historyDatas);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"近期请求错误，原因:%@" , error);
    }];
}

#pragma mark - UI

#pragma mark 日期选择
- (void)setupDatePickView {
    MEDMonitorDateView *datePickView = [[MEDMonitorDateView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, 30) textColor:MEDRGB(40, 40, 40) textFont:[UIFont systemFontOfSize:18] previousButton:@"mointor_date_left" NextButon:@"mointor_date_right"];
    [self.view addSubview:datePickView];
    self.datePick = datePickView;
    
    MEDWeakSelf(self);
    
    self.datePick.DateButtonClick = ^(NSString *startDate, NSString *endDate) {
        //根据 startDate 与 endDate进行网络请求
        NSLog(@"请求::%@<<->>%@", startDate, endDate);
        weakself.startDate = startDate;
        weakself.endDate = endDate;
        [weakself sendRequestStartDate:startDate endDate:endDate];
    };
    
    [datePickView getCurrrentDateResult:^(NSString *startDate, NSString *endDate) {
        NSLog(@"####首次请求####::%@<<->>%@", startDate, endDate);
        weakself.startDate = startDate;
        weakself.endDate = endDate;
        [weakself sendRequestStartDate:startDate endDate:endDate];
    }];
}

#pragma mark 图表
- (void)setupLineChartWithValueArray:(NSArray *)valueArray {
    
    [self.lineChart removeFromSuperview];
    self.lineChart = nil;
    
    // ******************* init&set *******************
    CGFloat chartH = (kScreenHeight-self.datePick.height)*0.4;
    MEDMonitorLineChart *lineChart = [[MEDMonitorLineChart alloc] initWithFrame: CGRectMake(0, self.datePick.bottom, kScreenWidth, chartH)];
    self.lineChart = lineChart;
    lineChart.chartBackgroundColor = MEDGrayColor(255);
    [self.view addSubview:lineChart];

    lineChart.exampleY1 = 200;
    lineChart.exampleY2 = 40;
    
    /*这样计算出的横线有7个，每格为40<>280/7*/
    lineChart.yMaxValue = 280;               //y轴最大值
    lineChart.ySepLabelCount = 14;            //Y坐标Label个数
    //lineChart.xLabelsWidth = kScreenWidth/7; //可以在此为每格宽度赋值
    // ******************* setData *******************
    // Value
    self.lineChart.yValueLabels = valueArray;
    self.lineChart.isShowGradientColor = YES;
    
    // ****************** 设置图表滚动 ******************
//    MEDLineChartData *chartData = [valueArray firstObject];
//    NSLog(@"每格的宽度为:%f<>共有%ld个格子", lineChart.xLabelsWidth, chartData.valuesArray.count);
//    CGFloat ContentX = (lineChart.xLabelsWidth*chartData.valuesArray.count);
//    NSLog(@"X方向的移动距离为:%f", ContentX);
//    [lineChart.scrollView setContentOffset:CGPointMake(ContentX, 0) animated:YES];
    // ****************** 设置图表滚动 ******************
    
    // Date
    NSUInteger days = [self.datePick numberDaysOfmonth];
    NSArray *monthBase = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    NSArray *monthActual = [monthBase subarrayWithRange:NSMakeRange(0, days)];
    self.lineChart.xLabels = monthActual;
    
    NSMutableArray *tempLegends = [NSMutableArray array];
    
    switch (self.moitorType) {
        case MEDMoitorTypeBloodPressure:
        {
            tempLegends = [NSMutableArray arrayWithArray:@[@{@"color":MEDRGB(82, 150, 240), @"title":@"舒张压"}, @{@"color":MEDRGB(28, 196, 225), @"title":@"收缩压" }]];
            lineChart.unitName = @"mmHg";
        }
            break;
        case MEDMoitorTypeBloodGlucose:
        {
            tempLegends = [NSMutableArray arrayWithArray:@[@{@"color":MEDRGB(82, 150, 240), @"title":@"空腹"}, @{@"color":MEDRGB(28, 196, 225), @"title":@"餐前" },@{@"color":MEDRGB(82, 150, 240), @"title":@"餐后"},@{@"color":MEDRGB(82, 150, 240), @"title":@"睡前"}]];
            lineChart.unitName = @"mmol";
        }
            break;
            
        case MEDMoitorTypeBloodOxygen:
        {
            tempLegends = [NSMutableArray arrayWithArray:@[@{@"color":MEDRGB(82, 150, 240), @"title":@"血氧"}]];
            lineChart.unitName = @"  %";
        }
            break;
        case MEDMoitorTypeWeight:
        {
            tempLegends = [NSMutableArray arrayWithArray:@[@{@"color":MEDRGB(82, 150, 240), @"title":@"体重"}]];
            lineChart.unitName = @"  kg";
        }
            break;
        case MEDMoitorTypeWaistline:
        {
            tempLegends = [NSMutableArray arrayWithArray:@[@{@"color":MEDRGB(82, 150, 240), @"title":@"腰围"}]];
            lineChart.unitName = @"  cm";
        }
            break;
        case MEDMoitorTypeSleep:
        {
            tempLegends = [NSMutableArray arrayWithArray:@[@{@"color":MEDRGB(82, 150, 240), @"title":@"睡眠"}]];
            lineChart.unitName = @"   h";
        }
            break;
        default:
            break;
    }
    
    //legend
    NSArray *legends = tempLegends;
    self.lineChart.legends = legends;
    
    // ******************* stroke *******************
    [self.lineChart strokeStart];
}

#pragma mark 历史记录

- (NSMutableArray *)historyDatas {
    if (_historyDatas == nil) {
        _historyDatas = [NSMutableArray array];
    }
    return _historyDatas;
}

- (UITableView *)historyTable {
    if (_historyTable == nil) {
        CGRect tableFrame = CGRectMake(0, self.lineChart.bottom+5, kScreenWidth, kScreenHeight-self.lineChart.bottom-5);
        _historyTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        _historyTable.dataSource = self;
        _historyTable.delegate = self;
        //_historyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyTable.separatorColor = MEDGrayColor(232);
    }
    return _historyTable;
}

#pragma mark  TableViewDataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MEDBloodPressureCell *cell = [MEDBloodPressureCell bloodPressureCellWithTableView:tableView];
//    MEDBloodpressureModel *model = self.historyDatas[indexPath.row];
//    cell.model = model;
//    return cell;
    
    MEDBloodPressureCodeCell *cell = [MEDBloodPressureCodeCell bloodPressureCellWithTableView:tableView];
        MEDBloodpressureModel *model = self.historyDatas[indexPath.row];
        cell.bloodpressureModel = model;
    return cell;
}

#pragma mark  TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MEDMonitorHeaderView *head = [MEDMonitorHeaderView monitorHeaderViewWithTableView:self.historyTable];
    
    MEDWeakSelf(self);
    
    head.hisToryButtonClick = ^{
        NSLog(@"跳转到历史数据页面");
        MEDMonitorHistoryController *historyController = [[MEDMonitorHistoryController alloc] init];
        historyController.startDate = self.startDate;
        historyController.endDate = self.endDate;
        [weakself.navigationController pushViewController:historyController animated:YES];
    };
    
    [head setHeadTitle:self.endDate];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Event

@end
