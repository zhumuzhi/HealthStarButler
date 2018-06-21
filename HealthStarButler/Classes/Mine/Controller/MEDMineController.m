//
//  MEDMineController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDMineController.h"
#import "AppDelegate.h"

@interface MEDMineController ()<UITableViewDelegate , UITableViewDataSource>

{
    /** 用户名 */
    NSString *_userNameStr;
    /** 用户头像url */
    NSString *_photoUrlStr;
    /** 用户性别标识 */
    NSNumber *_personSex;
}

@property (nonatomic, weak) UIView *headView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MEDMineController

#pragma mark - Lazy

- (UIView *)headView {

    if (!_headView) {

        //HeadView
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        self.headView = headView;
        //背景
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        backImage.image = [UIImage imageNamed:@"mine_Head"];
        [self.headView addSubview:backImage];

        // 头像
        CGFloat iconW = 70;
        CGFloat iconX = backImage.size.width - (iconW*0.5);
        CGFloat iconY = backImage.size.height - (iconW*0.5);
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconW)];
        [backImage addSubview:icon];

        // 用户名
        CGSize userNameSize = [@"超长的以防不够用的用户名标题占位计算字符串" sizeWithFont:[UIFont systemFontOfSize:14]];

        CGFloat userNameX = SCREEN_WIDTH/2 - userNameSize.width/2;
        CGFloat userNameY = CGRectGetMaxY(icon.frame) + 10;
        CGFloat usernameW = userNameSize.width;
        CGFloat usernameH = userNameSize.height;

        UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(userNameX, userNameY, usernameW, usernameH)];
        [backImage addSubview:userName];

    }
    return _headView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    [self navigationConfig];
    
    [self setupUI];
}

#pragma mark - configUI
/** Navigation */
- (void)navigationConfig
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"退出" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.frame = self.view.frame;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
}



#pragma mark --UITableViewDelegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
////    cell.textLabel.text = self.nameList[indexPath.row];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//}

#pragma mark - 网络请求
- (void)getUserInfon    {
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [params setValue:userModel.uid forKey:@"uid"];
    }

    NSLog(@"个人中心网络请求的参数:%@",params);

    [MEDDataRequest GET:MED_GET_USERINFO params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //MYLog(@"个人中心-GET个人信息-返回数据:%@",responseObject);

        if ([responseObject[@"status"] integerValue] == Status_OK) {
            //            dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict = responseObject[@"data"];

            NSLog(@"个人中心--生日信息:%@", dict[@"birthday"]);

            //根据网络请求重新为用户名赋值
            _userNameStr = [dict objectForKey:@"user_name"];
            CGSize userNameLabelSize = [_userNameStr sizeWithFont:MEDSYSFont(14)];
            CGFloat userNameLabelX = SCREEN_WIDTH/2 - userNameLabelSize.width/2;
//            _userNameLable.text = _userNameStr;

            //根据网络请求重新为用户头像赋值
            _photoUrlStr = dict[@"userPhoto"];
            NSString *photoStr = [NSString stringWithFormat:@"%@", _photoUrlStr];
            NSString *_placeholdStr;
            switch ([_personSex intValue]) {
                case 1:
                    _placeholdStr = @"txm";
                    break;
                case 2:
                    _placeholdStr = @"txw";
                    break;
                default:
                    _placeholdStr = @"tx1";
                    break;
            }
//            [self.headBtn setBackgroundImage:[UIImage imageNamed:_photoUrlStr] forState:UIControlStateNormal];
//
//            if(![[photoStr class] isKindOfClass:[NSNull class]]){
//                [self.headBtn sd_setImageWithURL:[NSURL URLWithString:photoStr] forState:UIControlStateNormal];
//                [MEDUserModel sharedUserModel].userPhoto = photoStr;
//            }

            //            }
            //            });
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取个人信息失败:%@",error);
    }];
}



#pragma mark - Event
/** 点击退出 */
- (void)clickQuitButton
{
    MEDWeakSelf(self);
    [MEDAlertMananger presentAlertWithTitle:@"退出" message:@"确认退出" actionTitle:@[@"确认"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
        NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
        
        if (buttonIndex==1) {
            [weakself.navigationController popViewControllerAnimated:NO];
            //保存登录信息
            [kUserDefaults setObject:LoginFailed forKey:Login];
            //切换打开程序后至登录页面(根据登录信息判断)
            [kAppDelegate mainTabBarSwitch];
        }
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSLog(@"个人中心收到内存警告");
    
}


@end
