//
//  FSModelUIListController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/9/4.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSModelUIListController.h"

@interface FSModelUIListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FSModelUIListController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self configruation];
}

#pragma mark - configUI
- (void)configUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - Configruation
- (void)configruation {
    self.navigationItem.title = @"模型UI";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - RequestData

#pragma mark - Event

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
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


#pragma mark - LazyGet
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:NormalFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置
    }
    return _tableView;
}


//- (NSMutableArray *)datasArray
//{
//    if (_datasArray == nil) {
//        _datasArray = [NSMutableArray arrayWithArray:@[
//                                                       @{@"name":@"圆角阴影", @"className":@"FSCornerRadiusController"},
//                                                       @{@"name":@"WKWeb-JS", @"className":@"FSWKWebJSController"},
//                                                       @{@"name":@"支付宝测试", @"className":@"FSAliPayController"},
//                                                       @{@"name":@"支付弹窗", @"className":@"FSPassWordController"},
//                                                       @{@"name":@"JSBridge测试", @"className":@"FSJavascriptBridgeController"},
//                                                       @{@"name":@"地址选择", @"className":@"FSChoseZoneViewController"},
//                                                       @{@"name":@"WKWebDemo", @"className":@"WKWebViewDemoController"},
//                                                       @{@"name":@"倒计时测试", @"className":@"FSCountDownTestController"}
//                                                       ]
//                       ];
//    }
//    return _datasArray;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSDictionary *dict = self.datasArray[indexPath.row];
//    Class controller = NSClassFromString(dict[@"className"]);
//    NSLog(@"跳转到:%@", NSClassFromString(dict[@"className"]));
//    UIViewController *viewController = [[controller alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
//}


@end
