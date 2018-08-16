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


}

#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - LazyGet
static NSString *FSChoseZoneCollectionCellID = @"FSChoseZoneCollectionCellID";

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

#pragma mark - SetData
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;

}

#pragma mark - Event

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {

    FSChoseZoneCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FSChoseZoneCollectionCellID forIndexPath:indexPath];
    FSChoseZoneMData *choseZoneGroup = [self.dataArray by_ObjectAtIndex:indexPath.section];
    FSChoseZoneMData *choseZone = [choseZoneGroup.items by_ObjectAtIndex:indexPath.row];
    NSLog(@"显示的数信息:%@", choseZone);

    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath {
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath {
}

@end
