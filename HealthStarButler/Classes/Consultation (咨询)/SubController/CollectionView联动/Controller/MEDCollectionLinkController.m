//
//  MEDCollectionLinkController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDCollectionLinkController.h"
#import "MEDLinkLeftTableViewCell.h"
#import "MEDCollectionViewCell.h"
#import "MEDCollectionCategoryModel.h"
#import "MEDCollectionViewFlowLayout.h"
#import "MEDCollectionViewHeaderView.h"

static float kLeftTableViewWidth = 80.f;
static float kCollectionViewMargin = 2.f;

@interface MEDCollectionLinkController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isScrollDown;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
@end

static NSString * const CollectionCellId = @"CollectionCellId";
static NSString * const TableViewCellId = @"TableViewCellId";
static NSString * const CollectionViewHeaderId = @"CollectionViewHeaderId";

@implementation MEDCollectionLinkController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = 0;
    _isScrollDown = YES;
    
    [self createTable];
    
    [self loadData];
}


#pragma mark - Lazy
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas {
    if (!_collectionDatas) {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, kScreenHeight-kTabbarSafeBottomMargin-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[MEDLinkLeftTableViewCell class] forCellReuseIdentifier:TableViewCellId];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        MEDCollectionViewFlowLayout *flowlayout = [[MEDCollectionViewFlowLayout alloc] init];
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowlayout.minimumInteritemSpacing = 2;
        flowlayout.minimumLineSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kCollectionViewMargin+kLeftTableViewWidth, kCollectionViewMargin, kScreenWidth-kLeftTableViewWidth-2*kCollectionViewMargin, kScreenHeight-2*kCollectionViewMargin-kTabbarSafeBottomMargin-64) collectionViewLayout:flowlayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[MEDCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellId];
        
        [_collectionView registerClass:[MEDCollectionViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionViewHeaderId];
    }
    return _collectionView;
}



#pragma mark - creatUI
- (void)createTable {
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}
#pragma mark - LoadData
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    
    for (NSDictionary *dict in categories) {
        
        MEDCollectionCategoryModel *model = [MEDCollectionCategoryModel objectWithDictionary:dict];
        [self.dataSource addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (MEDSubCategoryModel *s_model in model.subcategories) {
            [datas addObject:s_model];
        }
        [self.collectionDatas addObject:datas];
    }
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MEDLinkLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellId forIndexPath:indexPath];
    MEDCollectionCategoryModel *model = self.dataSource[indexPath.row];
    cell.name.text = model.name;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath.row;
    
    [self scrollToTopOfSection:_selectIndex animated:YES];
    
    //[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - 解决点击TableView后 CollectionView 的 Header 遮挡问题
- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:animated];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}


#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MEDCollectionCategoryModel *model = self.dataSource[section];
    return model.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellId forIndexPath:indexPath];
    MEDSubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
    cell.model = model;
//    cell.backgroundColor = MEDRGB(253, 212, 49);
    return cell;
}

// 设置Header或Footer视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // header
        reuseIdentifier = CollectionViewHeaderId;
    }
    
    MEDCollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MEDCollectionCategoryModel *model = self.dataSource[indexPath.section];
        view.title.text = model.name;
    }
    return view;
}


#pragma mark - UICollectionViewDelegateFlowLayout
// 此代理包含UICollectionViewDelegate
// Item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-kLeftTableViewWidth-4*kCollectionViewMargin)/3, (kScreenWidth-kLeftTableViewWidth- 4*kCollectionViewMargin)/3 + 30);
}
// HeaderView大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 30);
}

#pragma mark - UICollectionViewDelegate

// 将要展示某个头尾视图
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// 已经展示展示某个头尾视图
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
    
    if (self.collectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

@end
