//
//  MEDConsultationController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDConsultationController.h"

// 自定义按钮
#import "FSButton.h"
#import "HYEdgeInsetsButton.h"

#import "FSPriceAttributedStringTool.h"  // 富文本


#import "MEDStatusController.h"          // 状态栏
#import "MEDRefreshListController.h"     // 刷新测试
#import "MZModelTypeLoginController.h"   // 模型登录

#import "MZBaseSettingController.h"      // 模型个人中心
#import "MZSettingItem.h"
#import "MZSettingGroup.h"

#import "MZJSBridgeController.h"         // Bridge网页测试
#import "MEDWebTestController.h"         // 网页测试
#import "MEDPopViewListController.h"     // 弹窗测试

@interface MEDConsultationController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *namesArray;
@end

@implementation MEDConsultationController


#pragma mark - LazyGet
- (NSMutableArray *)namesArray
{
    if (_namesArray == nil) {
        _namesArray = [NSMutableArray arrayWithArray:@[@"状态栏测试", @"下拉刷新", @"模型登录", @"模型个人中心", @"Bridge网页测试", @"网页测试", @"弹窗测试"]];
    }
    return _namesArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:SecondPageFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - LifeCycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
}

#pragma mark - UI

- (void)setupNavigation {
    self.navigationItem.title = @"咨询";
    [self setupPersonNavigationItem];
    //self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.namesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.namesArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // @"状态栏测试", @"下拉刷新",@"模型登录", @"模型个人中心", @"WebBrige测试", @"普通WebView测试", @"弹出测试"
    NSArray *controllers = @[[MEDStatusController class], [MEDRefreshListController class], [MZModelTypeLoginController class], [MZBaseSettingController class], [MZJSBridgeController class], [MEDWebTestController class],[MEDPopViewListController class]];
    Class controller = controllers[indexPath.row];
    UIViewController *viewController = [[controller alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}



- (void)testYYText {
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight+50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth));
    }];
    label.textColor = [UIColor orangeColor];
    
    // 富文本操作
    //    NSString *pricrStr  = @"¥13.02~¥34.41";
    //    NSString *pricrStr  = @"¥1233.02";
    NSString *pricrStr  = @"¥";
    label.attributedText = [FSPriceAttributedStringTool priceAttributedStringWithString:pricrStr];
    
}

- (NSMutableAttributedString *)priceAttributedStringWith:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(string.length-2, 2)];
    return attributedString;
}

- (void)testRichtext
{
    
    UILabel *richTextLabel = [[UILabel alloc] init];
    [self.view addSubview:richTextLabel];
    
    [richTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight+50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth));
    }];
    
    
    NSString *richText = @"¥13.02~¥34.41";
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:richText];
    
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 1)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(5, 6)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 6)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12    ] range:NSMakeRange(6, 7)];
    richTextLabel.attributedText = attriStr;
}

/*测试分类方式设置按钮*/
- (void)configCategoryButton
{
    UIButton *edgeBtn = [[HYEdgeInsetsButton alloc] init];
    [self.view addSubview:edgeBtn];
    [edgeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight+50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@49);
        make.width.equalTo(@(kScreenWidth/2));
    }];
    edgeBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [edgeBtn setBackgroundColor:[UIColor whiteColor]];
    [edgeBtn setTitle:@"首页" forState:UIControlStateNormal];
    [edgeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [edgeBtn setImage:[UIImage imageNamed:@"首页-2"] forState:UIControlStateNormal];
    
    [edgeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];
}

/* 另一种自定义Button */
- (void)configEdgeButton
{
    HYEdgeInsetsButton *edgeBtn = [[HYEdgeInsetsButton alloc] init];
    [self.view addSubview:edgeBtn];
    [edgeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight+50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@49);
        make.width.equalTo(@(kScreenWidth/2));
    }];
    edgeBtn.scaleClose = YES;
    edgeBtn.titleLabel.font = [UIFont systemFontOfSize:50.0];
    edgeBtn.edgeInsetsStyle = HYButtonEdgeInsetsStyleImageLeft;
    edgeBtn.imageTitleSpace = 5;
    [edgeBtn setBackgroundColor:[UIColor whiteColor]];
    [edgeBtn setTitle:@"首页" forState:UIControlStateNormal];
    [edgeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [edgeBtn setImage:[UIImage imageNamed:@"首页-2"] forState:UIControlStateNormal];
    
    HYEdgeInsetsButton *edgeBtnOne = [[HYEdgeInsetsButton alloc] init];
    [self.view addSubview:edgeBtnOne];
    edgeBtnOne.scaleClose = YES;
    [edgeBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(edgeBtn.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
    }];
    edgeBtnOne.titleLabel.font = [UIFont systemFontOfSize:15.0];
    edgeBtnOne.edgeInsetsStyle = HYButtonEdgeInsetsStyleImageLeft;
    edgeBtnOne.imageTitleSpace = 5;
    [edgeBtnOne setBackgroundColor:[UIColor whiteColor]];
    [edgeBtnOne setTitle:@"北京" forState:UIControlStateNormal];
    [edgeBtnOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [edgeBtnOne setImage:[UIImage imageNamed:@"区域"] forState:UIControlStateNormal];
    
}


/*测试布局按钮*/
- (void)configTestButton {
    
    FSButton *leftButton = [[FSButton alloc] init];
    [self.view addSubview:leftButton];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight+50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    leftButton.buttonStyle = FSButtonImaegTypeLeft;
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    //    [button setBackgroundColor:[UIColor lightGrayColor]];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"区域"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(pushToNextView) forControlEvents:UIControlEventTouchUpInside];
    
    FSButton *rightButton = [[FSButton alloc] init];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftButton.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    rightButton.buttonStyle = FSButtonImaegTypeRight;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rightButton setTitle:@"收起" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    
    FSButton *homeButton = [[FSButton alloc] init];
    [self.view addSubview:homeButton];
    [homeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@50);
        make.width.equalTo(self.view).multipliedBy(0.5);
    }];
    homeButton.buttonStyle = FSButtonImaegTypeLeft;
    homeButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [homeButton setTitle:@"首页" forState:UIControlStateNormal];
    [homeButton setBackgroundColor:[UIColor whiteColor]];
    [homeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homeButton setImage:[UIImage imageNamed:@"首页-2"] forState:UIControlStateNormal];
    
    FSButton *serviceButton = [[FSButton alloc] init];
    [self.view addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton.mas_bottom).offset(50);
        make.left.equalTo(homeButton.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(self.view).multipliedBy(0.5);
    }];
    serviceButton.buttonStyle = FSButtonImaegTypeLeft;
    serviceButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [serviceButton setTitle:@"联系客服" forState:UIControlStateNormal];
    [serviceButton setBackgroundColor:[UIColor orangeColor]];
    [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serviceButton setImage:[UIImage imageNamed:@"首页-2hei"] forState:UIControlStateNormal];
    
    
}

- (void)pushToNextView {
    MEDStatusController *statusTest = [[MEDStatusController alloc] init];
    [self.navigationController pushViewController:statusTest animated:YES];
}

@end
