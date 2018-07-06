//
//  MEDPersonModelController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDPersonModelController.h"
#import "GHFromModel.h"
#import "GHFromCell.h"

@interface MEDPersonModelController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MEDPersonModelController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - set

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GHFromCell class] forCellReuseIdentifier:@"GHFromCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GHFromCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHFromCell"];
    cell.fromModel = self.dataArray [indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHFromModel *fromModel =  self.dataArray [indexPath.row];
    return fromModel.cellHeight;
}


#pragma mark - UITableViewDelegate


- (NSMutableArray *)creatFromMData {
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *cellTypeNumArray =@[
                                 /** 头像 */
                                 @(GHFromCellType_icon),
                                 /** 姓名 */
                                 @(GHFromCellType_name),
                                 /** 性别 */
                                 @(GHFromCellType_sex),
                                 /** 电话号码 */
                                 @(GHFromCellType_phone),
                                 /** 备注 */
                                 @(GHFromCellType_content),
                                 ];
    NSArray *leftTitleArray = @[
                                @"头像",
                                @"姓名",
                                @"性别",
                                @"手机号码",
                                @"备注",
                                ];
    NSArray *placeholderArray = @[
                                  @"",
                                  @"请输入姓名",
                                  @"",
                                  @"请选择手机号码",
                                  @"请输入备注",
                                  ];
    NSArray *imageNameArray = @[
                                @"daikan",
                                @"setting_arrow",
                                @"",
                                @"",
                                @"",
                                ];
    NSArray *isShowStartArray = @[
                                  [NSNumber numberWithBool:YES],
                                  [NSNumber numberWithBool:YES],
                                  [NSNumber numberWithBool:YES],
                                  [NSNumber numberWithBool:NO],
                                  [NSNumber numberWithBool:YES],

                                  ];
    NSArray *cellHeightArray = @[
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],

                                 ];
    for (NSInteger index = 0; index < leftTitleArray.count; index++) {
        GHFromModel *fromModel = [[GHFromModel alloc] init];
        fromModel.leftTitle = leftTitleArray[index];
        NSNumber *isShowStartNum = isShowStartArray[index];
        NSNumber *cellHeightNum = cellHeightArray[index];
        NSNumber *cellTypeNum = cellTypeNumArray[index];

        fromModel.cellHeight = cellHeightNum.integerValue;
        fromModel.cellType = cellTypeNum.integerValue;
        fromModel.placeholder = placeholderArray [index];
        fromModel.imageName = imageNameArray[index];
        fromModel.isShowStar = isShowStartNum.integerValue;
        [dataArray addObject:fromModel];
    }
    return dataArray;
}





@end
