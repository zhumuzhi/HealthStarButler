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

static NSString *FSChoseZoneCollectionCellID = @"FSChoseZoneCollectionCellID";

#pragma mark - LazyGet
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLayout *flowLayout = [[UICollectionViewLayout alloc] init];
        UICollectionView*collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor lightGrayColor];
        [collectionView registerClass:[FSChoseZoneCollectionCell class] forCellWithReuseIdentifier:FSChoseZoneCollectionCellID];
    }
    return _collectionView;
}

#pragma mark - Event


#pragma mark - SetData
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
}

- (void)setChoseZoneData:(FSChoseZoneMData *)choseZoneData {
    _choseZoneData = choseZoneData;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.choseZoneData.items.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {

    FSChoseZoneCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FSChoseZoneCollectionCellID forIndexPath:indexPath];
    FSChoseZoneMData *choseZone = [self.choseZoneData.items by_ObjectAtIndex:indexPath.row];
    NSLog(@"显示的数信息:%@", choseZone);
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath {
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath {

}

@end
