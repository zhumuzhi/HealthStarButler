//
//  MEDSingleChooseController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDSingleChooseController.h"
#import "MEDTableChooseCell.h"

#define HeaderHeight 50
#define CellHeight 50
#define CellId @"SingleChooseId"

typedef void(^ChooseBlock) (NSString *chooseContent,NSIndexPath *indexPath);

@interface MEDSingleChooseController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,strong)NSString *chooseContent;
@property(nonatomic,strong)NSIndexPath *currentSelectIndex;

@property(nonatomic,copy)ChooseBlock block;

@property (nonatomic, strong) UIBarButtonItem *editItem;


@end

@implementation MEDSingleChooseController

//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigation];
    [self.view addSubview:self.tableView];
    
    self.block = ^(NSString *chooseContent, NSIndexPath *indexPath) {
        NSLog(@"数据：%@ :第%ld行",chooseContent,indexPath.row);
    };
}


//MARK:- Navigation
- (void)setupNavigation {
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    editItem.tintColor = [UIColor whiteColor];
    self.editItem = editItem;
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addData)];
    addItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItems = @[editItem, addItem];
}


//MARK:- Add
- (void)addData {
    NSUInteger CurrentCount = self.dataArray.count;
    for (int i=1; i<=2; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%lu",CurrentCount+i]];
    }
    [self.tableView reloadData];
}


//MARK:- Edit
- (void)editClick {
    self.tableView.editing = !self.tableView.editing;
    if (self.tableView.editing) {
        self.editItem.title = @"完成";
    }else {
        self.editItem.title = @"编辑";
    }
}


//MARK:- Lazy
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        _dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
    }
    return _dataArray;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_tableView.editing = YES;
    }
    return _tableView;
}


//MARK:- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [NSString stringWithFormat:@"cellId%ld", (long)indexPath.row];
    
    MEDTableChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[MEDTableChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    if ([self.chooseContent isEqualToString:cell.titleLabel.text]) {
        [cell updateCellWithState:YES];
    }else {
        [cell updateCellWithState:NO];
    }
    return cell;
}

//MARK:- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_currentSelectIndex!=nil && _currentSelectIndex != indexPath) {
        NSIndexPath *beforIndexPath = [NSIndexPath indexPathForRow:_currentSelectIndex.row inSection:0];
        
        MEDTableChooseCell *cell = [tableView cellForRowAtIndexPath:beforIndexPath];
        [cell updateCellWithState:NO];
    }
    MEDTableChooseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateCellWithState:!cell.isSelected];
    self.chooseContent = cell.titleLabel.text;
    _currentSelectIndex = indexPath;
    _block(self.chooseContent, indexPath);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
