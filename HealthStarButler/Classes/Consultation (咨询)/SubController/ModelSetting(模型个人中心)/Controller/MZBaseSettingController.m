//
//  MZBaseSettingController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/11.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZBaseSettingController.h"

#import "MZSettingGroup.h"
#import "MZSettingItem.h"

#import "MZSettingCell.h"

@interface MZBaseSettingController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allGroups;

@end

@implementation MZBaseSettingController

#pragma mark - SetData
- (void)add0SectionItems
{
    /** 只有文字*/
    MZSettingItem *title = [MZSettingItem itemWithImage:nil title:@"只有文字" type:MZSettingItemTypeNone desc:nil];

    /** 点击对应的行调整（其他可能只是在内部做一些事情，请自行操作） */
    title.operation = ^{
        UIViewController *view = [[UIViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    };

    /** 只有文字和左边的图片 */
    MZSettingItem *titleAndImage = [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"只有文字和图片" type:MZSettingItemTypeNone desc:nil];
    titleAndImage.operation = ^{
    };
    //分组
    MZSettingGroup *group = [[MZSettingGroup alloc] init];
    group.items = @[title, titleAndImage];
    [self.allGroups addObject:group];
}

#pragma mark - LazyGet

- (NSMutableArray *)allGroups
{
    if (!_allGroups) {
        _allGroups = [NSMutableArray array];
    }
    return _allGroups;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:SecondPageFrame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        self.view = _tableView;
    }
    return _tableView;
}

#pragma mark - LifeCycle

- (void)loadView
{
//    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"模型个人中心";

    [self add0SectionItems];
    self.view = self.tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MZSettingGroup *group = self.allGroups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个iCocosSettingCell
    MZSettingCell *cell = [MZSettingCell settingCellWithTableView:tableView];

    // 2.取出这行对应的模型（iCocosSettingItem）
    MZSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    MZSettingGroup *group = _allGroups[indexPath.section];
    MZSettingItem *item = group.items[indexPath.row];

    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}

// 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MZSettingGroup *group = _allGroups[section];

    return group.header;
}
// 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    MZSettingGroup *group = _allGroups[section];

    return group.footer;
}


// 返回每一组的footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    MZSettingGroup *group = _allGroups[section];
    return group.footerHeight;
}

// 返回每一组的header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    MZSettingGroup *group = _allGroups[section];
    return group.headerHeight;
}

@end
