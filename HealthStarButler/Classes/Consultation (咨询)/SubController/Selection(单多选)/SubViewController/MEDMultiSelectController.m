//
//  MEDMultiSelectController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/21.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDMultiSelectController.h"
#import "MEDTableChooseCell.h"

#define HeaderHeight 50
#define CellHeight 50

typedef void(^ChooseBlock) (NSString *chooseContent,NSMutableArray *chooseArray);

@interface MEDMultiSelectController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSMutableArray *choosedArray;

@property(nonatomic,strong)NSString *chooseContent;
@property(nonatomic,strong)NSIndexPath * currentSelectIndex;

@property(nonatomic,copy)ChooseBlock block;

@property (nonatomic, assign) BOOL ifAllSelected;
@property (nonatomic, assign) BOOL ifAllSelecteSwitch;

@end

@implementation MEDMultiSelectController

//MARK:- Lazy
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        _dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
    }
    return _dataArray;
}


- (NSMutableArray *)choosedArray {
    if (!_choosedArray) {
        _choosedArray = [NSMutableArray array];
    }
    return _choosedArray;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self.view addSubview:self.tableView];
    self.block = ^(NSString *chooseContent, NSMutableArray *chooseArray) {
        NSLog(@"多选数据: %@ : %@", chooseContent, chooseArray);
    };
}


- (void)setupNavigation {
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addData)];
    addItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItems = @[addItem];
}


//MARK:- Add
- (void)addData {
    NSUInteger CurrentCount = self.dataArray.count;
    for (int i=1; i<=2; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%lu",CurrentCount+i]];
    }
    [self.tableView reloadData];
}


/** 创建Header */
- (UIView *)creatHeaderViewWithTitle:(NSString *)title {

    if (!_headerView) {
        _headerView = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeaderHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
        //headerB标题
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.text = title;
        [_headerView addSubview:titleLbl];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView.mas_left).offset(15);
            make.top.equalTo(_headerView.mas_top).offset(0);
            make.height.mas_equalTo(_headerView.mas_height);
        }];
        //选择按钮
        UIButton *chooseBtn = [[UIButton alloc] init];
        chooseBtn.tag = 10;
        [chooseBtn setImage:[UIImage imageNamed:@"table_SelectCheck"] forState:UIControlStateNormal];
        [chooseBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateSelected];
        chooseBtn.userInteractionEnabled = NO;
        [_headerView addSubview:chooseBtn];
        [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLbl.mas_right).offset(10);
            make.right.equalTo(_headerView.mas_right).offset(-15);
            make.top.equalTo(_headerView.mas_top);
            make.height.mas_equalTo(_headerView.mas_height);
            make.width.mas_equalTo(50);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAllClick:)];
        [_headerView addGestureRecognizer:tap];
    }
    
    return _headerView;
}


//MARK:- TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"cellId%ld",(long)indexPath.row];
    MEDTableChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MEDTableChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    if (_ifAllSelecteSwitch) {
        [cell updateCellWithState:_ifAllSelected];
        if (indexPath.row == self.dataArray.count-1) {
            _ifAllSelecteSwitch  = NO;
        }
    }
    
    return cell;
}


//MARK:- TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [self creatHeaderViewWithTitle:@"全选"];
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeaderHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //单个选择
    if (_currentSelectIndex!=nil && _currentSelectIndex != indexPath) {
        NSIndexPath *beforIndexPath = [NSIndexPath indexPathForRow:_currentSelectIndex.row inSection:0];
        
        MEDTableChooseCell *cell = [tableView cellForRowAtIndexPath:beforIndexPath];
        [cell updateCellWithState:NO];
    }
    MEDTableChooseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateCellWithState:!cell.isSelected];
    self.chooseContent = cell.titleLabel.text;

    //全选
    if (cell.isSelected) {
        [self.choosedArray addObject:cell.titleLabel.text];
    }else {
        [self.choosedArray removeObject:cell.titleLabel.text];
    }
    if (self.choosedArray.count < self.dataArray.count) {
        _ifAllSelected = NO;
        UIButton *chooseBtn = (UIButton *)[self.headerView viewWithTag:10];
        chooseBtn.selected = _ifAllSelected;
    }
    self.block(cell.titleLabel.text, _choosedArray);
}


//MARK:- 全选
- (void)chooseAllClick:(UITapGestureRecognizer *)tapGesture {
    //NSLog(@"选择所有数据");
    _ifAllSelecteSwitch = YES;
    
    UIButton *chooseBtn = (UIButton *)[self.headerView viewWithTag:10];
    [chooseBtn setSelected:!_ifAllSelected];
    _ifAllSelected = !_ifAllSelected;
    if (_ifAllSelected) {
        [self.choosedArray removeAllObjects];
        [self.choosedArray addObjectsFromArray:self.dataArray];
    }else {
        [self.choosedArray removeAllObjects];
    }
    [self.tableView reloadData];
    
    self.block(@"ALL", self.choosedArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
