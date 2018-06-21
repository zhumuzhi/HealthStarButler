//
//  MEDShopingCartController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDShopingCartController.h"
#import "MEDShopCartCell.h"

static CGFloat toolBarH = 50;
static NSString *cellID = @"wine";

@interface MEDShopingCartController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MEDShopingCartController


#pragma mark - Lazy

- (UITableView *)tableView
{
    if(!_tableView) {
        CGFloat tableH = SCREEN_HEIGHT - Navigation_Height - toolBarH - MED_TabbarSafeBottomMargin;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Navigation_Height, SCREEN_WIDTH ,tableH) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

#pragma mark - Config UI

- (void)configUI {
    
    //BaseSet
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = MEDGrayColor(240);
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MEDShopCartCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    // ToolBar
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - toolBarH - MED_TabbarSafeBottomMargin, SCREEN_WIDTH, toolBarH)];
    toolBar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:toolBar];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}



@end
