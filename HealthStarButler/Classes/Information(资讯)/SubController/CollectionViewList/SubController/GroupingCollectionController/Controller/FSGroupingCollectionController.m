//
//  FSGroupingCollectionController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/28.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSGroupingCollectionController.h"
// Model
#import "FSGroupingModel.h"
// UI
#import "FSGroupingFlowLayout.h"
#import "FSGroupingCollectionCell.h"
#import "ZJCollectionViewRightIndex.h"



@interface FSGroupingCollectionController ()<UICollectionViewDataSource, UICollectionViewDelegate, ZJCollectionViewRightIndexDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *indexArray;

@property (nonatomic, strong) ZJCollectionViewRightIndex *collectionViewIndex;

@end

@implementation FSGroupingCollectionController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分组及添加索引";
    [self setDataArrayAndListArray];
    [self configUI];
}

#pragma mark - SetData

- (void)setDataArrayAndListArray {
    // 数据数组
    NSString *path = [[NSBundle mainBundle] pathForResource:@"allBrand" ofType:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *tempSections = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        FSGroupingModel *sectionModel = [FSGroupingModel mj_objectWithKeyValues:dict];
        
        NSArray *barnds = dict[@"brands"];
        NSMutableArray *tempRows = [NSMutableArray array];
        for (NSDictionary *dict in barnds) {
            FSGroupingModel *rowModel = [FSGroupingModel mj_objectWithKeyValues:dict];
            [tempRows addObject:rowModel];
        }
        sectionModel.items = tempRows;
        [tempSections addObject:sectionModel];
    }
    self.dataArray = tempSections;
    
    // 数据标题数组
    NSMutableArray *tempIndexs = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FSGroupingModel *groupingModel = obj;
        [tempIndexs addObject:groupingModel.brandKey];
    }];
    self.indexArray = [NSMutableArray arrayWithArray:tempIndexs];
    
    [self.collectionView reloadData];
}

#pragma mark - ConfigUI
- (void)configUI {
    self.collectionView.frame = CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight);
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.collectionViewIndex];
}

#pragma mark- ZJCollectionViewRightIndexDelegate
-(void)collectionViewIndex:(ZJCollectionViewRightIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title{
    if ([_collectionView numberOfSections]>index&&index>-1) {
        UICollectionViewLayoutAttributes *attributes = [_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
        CGRect rect = attributes.frame;
        [_collectionView setContentOffset:CGPointMake(_collectionView.frame.origin.x, rect.origin.y - 40) animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
static NSString *itemIdentifier = @"FSGroupingCollectionCellID";

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    FSGroupingModel *sectionModel = [self.dataArray by_ObjectAtIndex:section];
    return sectionModel.items.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    FSGroupingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    FSGroupingModel *sectionModel = [self.dataArray by_ObjectAtIndex:indexPath.section];
    FSGroupingModel *rowModel = [sectionModel.items by_ObjectAtIndex:indexPath.row];
    cell.rowModel = rowModel;
    return cell;
}


static NSString *groupingCollectionViewHeadID = @"FSGroupingCollectionViewHeadID";

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableHeaderView = nil;
        if (reusableHeaderView == nil) {
            reusableHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:groupingCollectionViewHeadID forIndexPath:indexPath];
            
            reusableHeaderView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
            UILabel *label = (UILabel *)[reusableHeaderView viewWithTag:100];
            if (!label) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 40)];
                label.tag = 100;
                [reusableHeaderView addSubview:label];
            }
            FSGroupingModel *sectionModel = self.dataArray[indexPath.section];
            label.text = sectionModel.name;
        }
        return reusableHeaderView;
    }
    return nil;
}

#pragma mark - LazyGet

- (ZJCollectionViewRightIndex *)collectionViewIndex{
    if (_collectionViewIndex == nil) {
        _collectionViewIndex = [[ZJCollectionViewRightIndex alloc] initWithFrame:CGRectMake(kScreenWidth - 20, 0, 20, kScreenHeight)];
        _collectionViewIndex.titleIndexes = self.indexArray;
        _collectionViewIndex.color = [UIColor blackColor];
        _collectionViewIndex.isSelectVisible = YES;
        CGRect rect = _collectionViewIndex.frame;
        rect.size.height = _collectionViewIndex.titleIndexes.count * 16;
        rect.origin.y = (kScreenHeight - rect.size.height) / 2 + 64;
        _collectionViewIndex.frame = rect;
        _collectionViewIndex.collectionDelegate = self;
    }
    return _collectionViewIndex;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        FSGroupingFlowLayout *flowLayout = [[FSGroupingFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[FSGroupingCollectionCell class] forCellWithReuseIdentifier:itemIdentifier];
        _collectionView = collectionView;
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:groupingCollectionViewHeadID];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)indexArray {
    if (_indexArray == nil) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}


@end
