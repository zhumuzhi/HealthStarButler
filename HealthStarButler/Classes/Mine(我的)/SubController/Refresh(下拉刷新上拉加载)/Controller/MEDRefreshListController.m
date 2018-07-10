//
//  MEDRefreshListController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/11.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDRefreshListController.h"

#import "MEDRefreshDetailsController.h"

@interface MEDRefreshListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listData;

@end

@implementation MEDRefreshListController

//MARK:- Lazy
- (NSArray *)listData {
    if (_listData == nil) {
        _listData = @[@"普通", @"动画图片", @"隐藏时间", @"纯指示器", @"纯动画", @"自定义文字", @"自定义刷新控件"];
    }
    return _listData;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect tableFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

//MARK:- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.title = @"下拉刷新类型选择";
}

//MARK:- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"RefreshID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


//MARK:- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@", indexPath);
    MEDRefreshDetailsController *test = [[MEDRefreshDetailsController alloc] init];
    
    switch (indexPath.row) {
        default:
            test.type = MEDRefreshTypeDefault;
            break;
        case 1:
            test.type = MEDRefreshTypeGif;
            break;
        case 2:
            test.type = MEDRefreshTypeHiddeTime;
            break;
        case 3:
            test.type = MEDRefreshTypeOnlyActivityIndicator;
            break;
        case 4:
            test.type = MEDRefreshTypeHiddeStatusAndTime;
            break;
        case 5:
            test.type = MEDRefreshTypeCustomText;
            break;
        case 6:
            test.type = MEDRefreshTypeCustomControl;
            break;
    }
    
    
    [self.navigationController pushViewController:test animated:YES];
}



@end
