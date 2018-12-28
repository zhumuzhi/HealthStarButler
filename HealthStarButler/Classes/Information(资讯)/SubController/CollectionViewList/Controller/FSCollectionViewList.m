//
//  FSCollectionViewList.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/28.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSCollectionViewList.h"

#import "FSGroupingCollectionController.h"   //分组及添加索引
#import "FSAddSectionOrCellController.h"     //添加/删除cell或section
#import "FSAddHeaderViewController.h"        //添加headerView
#import "FSCycleViewController.h"            //循环轮播
#import "FSWaterLayoutListTableController.h" //cell多选
#import "FSReorderController.h"              //流水布局常见形式
#import "FSMultiSelectCellController.h"      //长按拖动排序

@interface FSCollectionViewList ()

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *classNames;

@end

@implementation FSCollectionViewList

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CollectionView 使用总结";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.nameArray = @[@"分组及添加索引",@"添加/删除cell或section",@"添加headerView",@"循环轮播",@"cell多选",@"流水布局常见形式",@"长按拖动排序"];
    
    self.classNames = @[@"FSGroupingCollectionController",@"FSAddSectionOrCellController",@"FSAddHeaderViewController",@"FSCycleViewController",@"FSWaterLayoutListTableController",@"FSReorderController",@"FSMultiSelectCellController"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.nameArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    id ObjectVC = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:ObjectVC animated:YES];
}

@end
