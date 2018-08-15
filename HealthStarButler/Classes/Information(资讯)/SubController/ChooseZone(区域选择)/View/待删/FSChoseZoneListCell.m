//
//  FSChoseZoneListCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/15.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSChoseZoneListCell.h"

// Model
#import "FSChoseZoneMData.h"
// View
//#import "FSChoseZoneHeader.h"  显示标签A,B,C等Header
#import "FSChoseZoneCell.h"


@interface FSChoseZoneListCell ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSChoseZoneListCell

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - ConfigUI
- (void)configUI {

    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - SetData
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - Event

#pragma mark - LazySet
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;// 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO; //关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"ListCell-cell中显示%zu组数据", self.dataArray.count);
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FSChoseZoneMData *choseZoneGruop = [self.dataArray by_ObjectAtIndex:section];
    NSLog(@"ListCell-每组显示%zu行数据", choseZoneGruop.items.count);
    return choseZoneGruop.cities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    FSChoseZoneMData *choseZoneGroup = [self.dataArray by_ObjectAtIndex:indexPath.section];
    FSChoseZoneMData *choseZone = [choseZoneGroup.cities by_ObjectAtIndex:indexPath.row];
    cell.textLabel.text = choseZone.cityName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
