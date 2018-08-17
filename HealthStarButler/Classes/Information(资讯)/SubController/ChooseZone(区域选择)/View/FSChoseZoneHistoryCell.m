//
//  FSChoseZoneHistoryCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/15.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSChoseZoneHistoryCell.h"
#import "FSChoseZoneMData.h"
/** 历史Cell */
#import "FSChoseZoneCollectionCell.h"

@interface FSChoseZoneHistoryCell ()<
                                UICollectionViewDataSource,
                                UICollectionViewDelegate
                                    >
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation FSChoseZoneHistoryCell

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
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Event

#pragma mark - SetData

- (void)setChoseZoneData:(FSChoseZoneMData *)choseZoneData {
    _choseZoneData = choseZoneData;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"每组返回%zd个数据", self.choseZoneData.items.count);
    return self.choseZoneData.items.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {

    FSChoseZoneCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FSChoseZoneCollectionCellID forIndexPath:indexPath];
    FSChoseZoneMData *choseZone = [self.choseZoneData.items by_ObjectAtIndex:indexPath.row];
    NSLog(@"显示的数信息:%@", choseZone);
    cell.choseZoneMData = choseZone;

    return cell;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"点击了:%ld", (long)indexPath.row);
}

static NSString *FSChoseZoneCollectionCellID = @"FSChoseZoneCollectionCellID";

#pragma mark - LazyGet
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kAutoWithSize(100), kAutoWithSize(30));
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 15, 10);
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[FSChoseZoneCollectionCell class] forCellWithReuseIdentifier:FSChoseZoneCollectionCellID];
    }
    return _collectionView;
}

@end
