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
        NSLog(@"我是伪装成SectionHeader的Cell");
    };
    /** 只有文字和左边的图片 */
    MZSettingItem *titleAndImage = [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"只有文字和图片" type:MZSettingItemTypeNone desc:nil];
    titleAndImage.operation = ^{
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
    };
    //分组
    MZSettingGroup *group = [[MZSettingGroup alloc] init];
    group.items = @[title, titleAndImage];
    [self.allGroups addObject:group];
}

- (void)add1SectionItems
{
    /** 文字和右边剪头 */
    MZSettingItem *arrow= [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"文字和右边箭头" type:MZSettingItemTypeArrow desc:nil];
    arrow.operation = ^{
        
    };
    
    /** 文字和右边图片）*/
    MZSettingItem *image = [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"文字和右边图片）" type:MZSettingItemTypeImage image:[UIImage imageNamed:@"02.png"]];
    image.operation = ^{
        
    };
    
    /** 文字和右边图片 */
    MZSettingItem *desc = [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"文字和右边图片" type:MZSettingItemTypeArrow desc:@"描述文字"];
    desc.operation = ^{
        
    };
    /** 文字和右边图片 */
    MZSettingItem *placeholder = [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"文字和右边图片" type:MZSettingItemTypeArrow desc:@"颜色占位" detailLabelColor:[UIColor redColor]];
    placeholder.operation = ^{
        
    };
    //分组
    MZSettingGroup *group = [[MZSettingGroup alloc] init];
    group.items = @[arrow, image, desc, placeholder];
    [self.allGroups addObject:group];
}

- (void)add2SectionItems
{
    /** Switch控件 */
    MZSettingItem *documents = [MZSettingItem itemWithImage:[UIImage imageNamed:@"01.png"] title:@"Switch控件" type:MZSettingItemTypeSwitch desc:nil];
    documents.operation = ^{
        
    };
    //分组
    MZSettingGroup *group = [[MZSettingGroup alloc] init];
    group.items = @[documents];
    [self.allGroups addObject:group];
}

- (void)add3SectionItems
{
    /** 点击可输入文字 */
    MZSettingItem *documents = [MZSettingItem itemWithImage:nil title:@"点击可输入文字" type:MZSettingItemTypeTextField desc:nil];
    documents.operation = ^{
        
    };
    /** 文本占位（可输入） */
    MZSettingItem *arrow= [MZSettingItem itemWithTitle:@"文本占位（可输入）" type:MZSettingItemTypeTextField placeHolder:@"请输入您的手机号"];
    arrow.operation = ^{
        
    };
    //分组
    MZSettingGroup *group = [[MZSettingGroup alloc] init];
    group.items = @[documents, arrow];
    [self.allGroups addObject:group];
}


- (double)rowHeight
{
    return 60;
}

/** 多余行数据 */
- (void)add4SectionItems
{
    /** 我的订单 */
    MZSettingItem *dd0 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    MZSettingItem *dd1 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    MZSettingItem *dd2 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    MZSettingItem *dd3 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    MZSettingItem *dd4 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    MZSettingItem *dd5 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    MZSettingItem *dd6 = [MZSettingItem itemWithImage:nil title:nil type:MZSettingItemTypeTextField desc:nil];
    //分组
    MZSettingGroup *group = [[MZSettingGroup alloc] init];
    group.items = @[dd0, dd1, dd2, dd3, dd4, dd5, dd6];
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
    [self add1SectionItems];
    [self add2SectionItems];
    [self add3SectionItems];
    /** 多余数据行 */
    [self add4SectionItems];
    
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
    // 1.创建一个MZSettingCell
    MZSettingCell *cell = [MZSettingCell settingCellWithTableView:tableView];

    // 2.取出这行对应的模型（MZSettingItem）
    MZSettingGroup *group = self.allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 0.取出这行对应的模型
    MZSettingGroup *group = self.allGroups[indexPath.section];
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
    MZSettingGroup *group = self.allGroups[section];
    return group.header;
}
// 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    MZSettingGroup *group = self.allGroups[section];
    return group.footer;
}


// 返回每一组的footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    MZSettingGroup *group = self.allGroups[section];
    return group.footerHeight;
}

// 返回每一组的header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    MZSettingGroup *group = self.allGroups[section];
    return group.headerHeight;
}

@end
