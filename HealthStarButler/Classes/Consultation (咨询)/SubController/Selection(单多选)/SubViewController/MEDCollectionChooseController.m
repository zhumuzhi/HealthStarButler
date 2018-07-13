//
//  MEDCollectionChooseController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/28.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#define ItemHeight 70
#define HeaderHeight 50
#define CellId @"CellId"

typedef void(^ChooseBlock)(NSString *chooseContent, NSIndexPath *indexPath);
typedef void(^MultChooseBlock)(NSString *chooseContent, NSMutableArray *chooseArray);

#import "MEDCollectionChooseController.h"
#import "MEDCollectionChooseCell.h"

@interface MEDCollectionChooseController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSMutableArray * dataArray;

/** 单选多选 */
@property (nonatomic, assign) BOOL isSingle;
/** 选中标记 */
@property (nonatomic, strong) NSIndexPath * selectIndex;
/** 多选数组 */
@property (nonatomic, strong) NSMutableArray * selectIndexs;

@property (nonatomic, strong) NSString * chooseContent;
@property (nonatomic, assign) BOOL ifAllSelected;
@property (nonatomic, assign) BOOL ifAllSelecteSwitch;

@property (nonatomic, strong) UICollectionReusableView *reusableview;

@property(nonatomic,strong) NSDictionary * cellidDict;//防止重用
@property (nonatomic, copy) ChooseBlock actionBlock;
@property (nonatomic, copy) MultChooseBlock multActionBlock;

@end

@implementation MEDCollectionChooseController

//MARK:- Lazy
- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10; //列距
        flowLayout.minimumLineSpacing = 10;
        
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight-kTabbarSafeBottomMargin) collectionViewLayout:flowLayout];
        _collectView.backgroundColor = [UIColor colorWithHexString:@"0xf7f7f7"];
        _collectView.showsVerticalScrollIndicator = NO;
        _collectView.scrollEnabled = YES;
        _collectView.delegate = self;
        _collectView.dataSource = self;
    
    }
    return _collectView;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        
    }
    return _dataArray;
}


//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectView.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigation];
    
    NSLog(@"%@", self.dataArray);
    [self.view addSubview:self.collectView];
    [self.collectView reloadData];
    
    self.actionBlock = ^(NSString *chooseContent, NSIndexPath *indexPath) {
        NSLog(@"数据:%@ -- 第%ld行", chooseContent, (long)indexPath.row);
    };
}

- (void)setupNavigation {
    self.navigationItem.title = @"单单单选";
    _isSingle = YES;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"多选" style:UIBarButtonItemStylePlain target:self action:@selector(navigationItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    rightItem.tintColor = [UIColor whiteColor];
}

- (void) navigationItemClick {
    _isSingle = !_isSingle;
    if (_isSingle) { //单选
        _selectIndex = nil;
        _collectView.allowsMultipleSelection = NO;
        self.navigationItem.rightBarButtonItem.title = @"多选";
        self.navigationItem.title = @"单单单选";
        [self.selectIndexs removeAllObjects];
        [self.collectView reloadData];
    }else {
        _collectView.allowsMultipleSelection = YES;
        self.navigationItem.title = @"多多多选";
        self.navigationItem.rightBarButtonItem.title = @"单选";
        [self.collectView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//MARK:- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [_cellidDict objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", CellId, [NSString stringWithFormat:@"%@", indexPath]] ;
        [_cellidDict setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        [_collectView registerClass:[MEDCollectionChooseCell class]  forCellWithReuseIdentifier:identifier];
    }
    MEDCollectionChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.titleLab.text = [self.dataArray objectAtIndex:indexPath.row];
    if (_isSingle) {
        if (indexPath == _selectIndex) {
            [cell UpdateCellWithState:YES];
        }else {
            [cell UpdateCellWithState:NO];
        }
    }else {
        if (_ifAllSelecteSwitch) {
            [cell UpdateCellWithState:_ifAllSelected];
            if (indexPath.row == self.dataArray.count-1) {
                _ifAllSelecteSwitch  = NO;
            }
        }
    }
    return cell;
}


//MARK:- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth-40)/3,ItemHeight);
}

//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake ( 10 , 10 , 10 , 10 );
}

//MARK:- UICollectionViewDelegate

/** 选中 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (_isSingle) {
        if (_selectIndex != nil && _selectIndex != indexPath) {
            MEDCollectionChooseCell * cell = (MEDCollectionChooseCell *)[collectionView cellForItemAtIndexPath:_selectIndex];
            [cell UpdateCellWithState:NO];
        }
        MEDCollectionChooseCell * cell = (MEDCollectionChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell UpdateCellWithState:!cell.isSelected];
        _selectIndex = indexPath;
        self.chooseContent = cell.titleLab.text;
        _actionBlock(self.chooseContent,indexPath);
    }else {
        MEDCollectionChooseCell * cell = (MEDCollectionChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell UpdateCellWithState:!cell.isSelected];
        if (cell.isSelected) {
            [_selectIndexs addObject:cell.titleLab.text];
        } else {
            [_selectIndexs removeObject:cell.titleLab.text];
        }
        if (_selectIndexs.count<self.dataArray.count) {
            _ifAllSelected = NO;
            UIButton * chooseIcon = (UIButton *)[_reusableview viewWithTag:10];
            chooseIcon.selected = _ifAllSelected;
        }
        //_multActionBlock(cell.titleLab.text, _selectIndexs);
    }
    
    // ************************************************************
    //    //使用双代理方法方式
    //    MEDCollectionChooseCell * cell = (MEDCollectionChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    _selectIndex = indexPath;
    //    if (indexPath == _selectIndex) {
    //        [cell UpdateCellWithState:YES];
    //    } else {
    //        [cell UpdateCellWithState:NO];
    //    }
    //    [self.collectView reloadData]; //为啥tableView不用刷新？？
    //    self.actionBlock(self.chooseContent, indexPath);
    // ************************************************************
}

/** 未选中 */
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    MEDCollectionChooseCell *cell = (MEDCollectionChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    if (_selectIndex == indexPath) {
//        [cell UpdateCellWithState:YES];
//    }
    
}

static NSString *HeaderId = @"HeaderId";
/** 设置HeaderView */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (_reusableview==nil) {
            _reusableview = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderId forIndexPath:indexPath];
            _reusableview.backgroundColor = [UIColor whiteColor];
            UILabel * HeaderTitleLab = [[UILabel alloc]init];
            HeaderTitleLab.text = @"全选";
            [_reusableview addSubview:HeaderTitleLab];
            [HeaderTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self->_reusableview.mas_left).offset(15);
                make.top.equalTo(self->_reusableview.mas_top).offset(0);
                make.height.mas_equalTo(self->_reusableview.mas_height);
            }];
            UIButton *chooseIcon = [UIButton buttonWithType:UIButtonTypeCustom];
            chooseIcon.tag = 10;
            [chooseIcon setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
            [chooseIcon setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
            chooseIcon.userInteractionEnabled = NO;
            [_reusableview addSubview:chooseIcon];
            [chooseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(HeaderTitleLab.mas_right).offset(10);
                make.right.equalTo(_reusableview.mas_right).offset(-15);
                make.top.equalTo(_reusableview.mas_top);
                make.height.mas_equalTo(_reusableview.mas_height);
                make.width.mas_equalTo(50);
            }];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAllClick:)];
            [_reusableview addGestureRecognizer:tap];
            
        }
    }
    return _reusableview;
}


///** 全选 */
- (void)chooseAllClick:(UITapGestureRecognizer *)TapGesture {
    _ifAllSelecteSwitch  = YES;
    UIButton *chooseButton = (UIButton *)[_reusableview viewWithTag:10];
    [chooseButton setSelected:!_ifAllSelected];
    _ifAllSelected = !_ifAllSelected;
    if (_ifAllSelected) {
        [_selectIndexs removeAllObjects];
        [_selectIndexs addObjectsFromArray:_dataArray];
    }else {
        [_selectIndexs removeAllObjects];
    }
    [_collectView reloadData];
    _multActionBlock(@"ALL", _selectIndexs);
}


@end
