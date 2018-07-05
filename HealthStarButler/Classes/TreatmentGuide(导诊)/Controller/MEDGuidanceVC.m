//
//  MEDGuidanceVC.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/13.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDGuidanceVC.h"
//#import "MEDBackButton.h"
#import "MEDSuggestCell.h" //页面调整后想使用的系统cell，此cell没有使用
//#import "MEDHealthConsultingVC.h"
#import "MEDDepartmentVC.h"

@interface MEDGuidanceVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_symptomTitle;
    UIView *_symptomView;
    UITableView *_tableView;
    BOOL _isShow2;
}

@end

#define NAVI_BACK_WIDTH     (isPad ? 50 : 70)
#define CELL_IDENTIFIER     (@"cell_identifier")

@implementation MEDGuidanceVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _isShow2 = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self viewWillDisappearShowBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"导诊建议";
    [self initSymptom];
    
    self.view.backgroundColor = MEDGrayColor(243);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_symptomView.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-Navigation_Height - 10) ];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
//    _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    _tableView.separatorColor =MEDGrayColor(243);
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
//最新版本去掉了问医生按钮，暂时保留
//    UIButton *asdDoc = [UIButton buttonWithType:UIButtonTypeCustom];
//    asdDoc.frame = CGRectMake(0, SCREEN_HEIGHT-TabBar_HEIGHT, SCREEN_WIDTH, TabBar_HEIGHT);
//    [asdDoc setBackgroundImage:[UIImage imageNamed:@"bj"] forState:UIControlStateNormal];
//    [asdDoc setTitle:@"问医生" forState:UIControlStateNormal];
//    [asdDoc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    asdDoc.titleLabel.font = [UIFont systemFontOfSize:12];
//    [asdDoc addTarget:self action:@selector(askDocClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:asdDoc];
    
}

- (void)initSymptom {
    
    //症状标题
    _symptomTitle = [[UIView alloc] initWithFrame:CGRectMake(0, Navigation_Height+10, SCREEN_WIDTH, CELL_HEIGHT )];
    _symptomTitle.backgroundColor = [UIColor whiteColor];
    UILabel *lable= [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, CELL_HEIGHT)];
    lable.text = @"您的症状:";
//    lable.font = sysFont(14);
    lable.textColor = MEDGrayColor(153);
    [_symptomTitle addSubview:lable];
    [self.view addSubview:_symptomTitle];
    
    //症状背景:
    _symptomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_symptomTitle.frame)+1, SCREEN_WIDTH, CELL_HEIGHT )];
    _symptomView.backgroundColor = [UIColor whiteColor];
    
    //选择症状标题
    NSString *_detialStr = [_symptomArray componentsJoinedByString:@"  "];
    UILabel *detialLable = [[UILabel alloc]init];
    detialLable.text = [NSString stringWithFormat:@"%@",_detialStr];
    //detialLable.textColor = [MEDResource getGreenColor];
    detialLable.textColor = MEDGrayColor(181);
    //CGFloat contentW = self.view.bounds.size.width - detialLable.frame.origin.x - 40;
    //label的字体 HelveticaNeue  Courier
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    detialLable.font = fnt;
    detialLable.numberOfLines = 0;
    detialLable.lineBreakMode = NSLineBreakByWordWrapping;
    // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
    CGRect tmpRect = [detialLable.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-CGRectGetMaxX(lable.frame)-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    // 高度H
    CGFloat contentH = tmpRect.size.height;
    //MYLog(@"调整后的显示宽度:%f,显示高度:%f",contentW,contentH);
    detialLable.frame = CGRectMake(20, 10, SCREEN_WIDTH-20,contentH - 5);
    
    _symptomView.frame = CGRectMake(0, CGRectGetMaxY(_symptomTitle.frame)+1, SCREEN_WIDTH,(contentH+20));
    [_symptomView addSubview:detialLable];
    
    [self.view addSubview:_symptomView];
}

//- (void)askDocClick {
//    _isShow2 = YES;
//    [self viewWillDisappearShowBar];
//    [self.navigationController popViewControllerAnimated:YES];
//    [APPDelegate.tabBarController setSelectedIndex:2];
//}


#pragma tableDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num;
    num = _dataArray.count;
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MEDSuggestCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
//    
//    if (!cell) {
//        cell = [[MEDSuggestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
//    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    
//    NSMutableArray *percent;
//    for (NSInteger i = 0; i<_dataArray.count; i++) {
//        [percent addObject:@(arc4random()%34)];
//    }
    
    NSString *title = [dic objectForKey:@"name"];
    cell.textLabel.text = title;
//    cell.textLabel.font = sysFont(14);
//    NSString *sub = [dic objectForKey:@"describe"];
    
//    [cell addPercent:[[percent objectAtIndex:indexPath.row] intValue] andTitle:title andSub:sub];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView  deselectRowAtIndexPath:indexPath animated:YES];
    MEDDepartmentVC *department = [[MEDDepartmentVC alloc]init];
    department.detialStr = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"describe"];
    department.did = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    department.name = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    [self.navigationController pushViewController:department animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEIGHT)];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, CELL_HEIGHT)];
    title.text = @"相匹配的科室:";
    title.textColor = MEDGrayColor(153);
//    title.font = sysFont(14);
    title.textAlignment = NSTextAlignmentLeft;
    [head addSubview:title];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, (CELL_HEIGHT-0.5) , SCREEN_WIDTH, 1);
    lineView.backgroundColor = MEDGrayColor(243);
    [head addSubview:lineView];
    
    return head;
}

//设置分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSeparatorWithTarget:cell Inset:UIEdgeInsetsZero];
}

- (void)setSeparatorWithTarget:(id)target Inset:(UIEdgeInsets)inset {
    [target setSeparatorInset:inset];
    if ([target respondsToSelector:@selector(setLayoutMargins:)]) {
        [target setLayoutMargins:inset];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
