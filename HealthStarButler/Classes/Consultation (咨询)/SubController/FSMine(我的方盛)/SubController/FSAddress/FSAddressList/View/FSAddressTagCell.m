//
//  FSAddressTagCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/15.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressTagCell.h"
// Model
#import "FSAddressListMData.h"
//View
#import "FSAddressItem.h"

@interface FSAddressTagCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation FSAddressTagCell

#pragma mark - setData
- (void)setRowMData:(FSAddressListMData *)rowMData {
    _rowMData = rowMData;
    
    self.dataArray = self.rowMData.items.mutableCopy;
    [self.collectionView reloadData];
}


#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - configUI
- (void)configUI {
    [self.contentView addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(kAutoWithSize(10), kAutoWithSize(5), kScreenWidth - 4*kAutoWithSize(10), kAutoWithSize(16));
}

#pragma mark - configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Event

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    FSAddressListMData *rowMData = [self.dataArray by_ObjectAtIndex:indexPath.row];
    NSString *stringID = [NSString stringWithFormat:@"FSAddressItemID%zd", indexPath.row];
    [self.collectionView registerClass:[FSAddressItem class] forCellWithReuseIdentifier:stringID];
    FSAddressItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:stringID forIndexPath:indexPath];
//    for (UIView *view in cell.contentView.subviews) {
//        if (view) {
//            [view removeFromSuperview];
//        }
//    }
    cell.rowMData = rowMData;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    FSAddressListMData *rowMData = [self.dataArray by_ObjectAtIndex:indexPath.row];
    return CGSizeMake(rowMData.tagWidth, kAutoWithSize(16));
}

#pragma mark - LazyGet
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake(30, kAutoWithSize(16));
        _flowLayout.minimumLineSpacing = kAutoWithSize(5);
        _flowLayout.minimumInteritemSpacing = kAutoWithSize(5);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
//        [collectionView registerClass:[<#code#> class] forCellWithReuseIdentifier:<#code#>];
    }
    return _collectionView;
}

@end
