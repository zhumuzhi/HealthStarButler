//
//  MEDInformationController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDInformationController.h"

#import "FSCornerRadiusController.h"     // 圆角阴影
#import "FSWKWebJSController.h"          // WKWeb_JS交互
#import "FSAliPayController.h"           // 支付宝测试
#import "FSPassWordController.h"         // 支付弹窗
#import "FSJavascriptBridgeController.h" // JSBridge框架
#import "FSChoseZoneViewController.h"    // 地址选择
#import "WKWebViewDemoController.h"      // WKDomeController

#import "FSGoTopButtonView.h"

@interface MEDInformationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datasArray;

@property (nonatomic, strong) FSGoTopButtonView *goTopButton;


@end

@implementation MEDInformationController

#pragma mark - Lazy
- (NSMutableArray *)datasArray
{
    if (_datasArray == nil) {
        _datasArray = [NSMutableArray arrayWithArray:@[
                                                       @{@"name":@"圆角阴影", @"className":@"FSCornerRadiusController"},
                                                       @{@"name":@"WKWeb-JS", @"className":@"FSWKWebJSController"},
                                                       @{@"name":@"支付宝测试", @"className":@"FSAliPayController"},
                                                       @{@"name":@"支付弹窗", @"className":@"FSPassWordController"},
                                                       @{@"name":@"JSBridge测试", @"className":@"FSJavascriptBridgeController"},
                                                       @{@"name":@"地址选择", @"className":@"FSChoseZoneViewController"},
                                                       @{@"name":@"WKWebDemo", @"className":@"WKWebViewDemoController"}
                                                       ]
                       ];
    }
    return _datasArray;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];


    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.goTopButton];
}

/** goTopBtn */
- (FSGoTopButtonView *)goTopButton {
    if (_goTopButton == nil) {
        _goTopButton = [[FSGoTopButtonView alloc] initWithFrame:CGRectMake(kScreenWidth-75, kScreenHeight-140, 60, 60) targetScroll:self.tableView];
        _goTopButton.hidden = YES;
    }
    return _goTopButton;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.datasArray.count;
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"id%zi", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        NSDictionary *dict = self.datasArray[indexPath.row];
//        cell.textLabel.text = dict[@"name"];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    cell.textLabel.text = identifier;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.datasArray[indexPath.row];
    Class controller = NSClassFromString(dict[@"className"]);
    UIViewController *viewController = [[controller alloc] init];

//    if (controller == [FSChoseZoneViewController class]) {
//        [self presentViewController:viewController animated:YES completion:nil];
//    } else {
//        [self.navigationController pushViewController:viewController animated:YES];
//    }

    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - ConfigUI

- (void)setupNavigation {
    self.navigationItem.title = @"资讯";
    [self setupPersonNavigationItem];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = MEDBlue;
    return button;
}



@end
