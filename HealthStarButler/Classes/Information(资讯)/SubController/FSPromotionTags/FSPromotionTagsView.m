//
//  FSPromotionTagsView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/27.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSPromotionTagsView.h"
#import "FSPromotionTagsCell.h"

@interface FSPromotionTagsView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) FSPromotionLayout *promotionLayout;
@property (nonatomic, weak)   UICollectionView  *collectionView;

@end

@implementation FSPromotionTagsView

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

static NSString *cellIdentifier = @"FSPromotionTagsCellID";

#pragma mark - config UI & configration
- (void)configUI {
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.promotionLayout];
    collection.backgroundColor = [UIColor grayColor];
    collection.dataSource = self;
    collection.delegate = self;
    [collection registerClass:[FSPromotionTagsCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView = collection;
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

- (void)configration {

}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return self.itemArry.count;
}
- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    FSPromotionTagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.title = [self.itemArry by_ObjectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGSize)waterFlowLayout:(FSPromotionLayout *)WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath{
    return [self getSize:_itemArry[indexPath.row]];
}

- (CGSize)getSize:(NSString *)str{
    UIFont *font = [UIFont systemFontOfSize:kFont(30)];
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize mySize = [str sizeWithAttributes:attrs];
    return mySize;
}

- (void)getCollectionViewHeight:(CGFloat)ccHeight{
//    [self.delegte getTableCellHeight:ccHeight];
}

#pragma mark - SetData
- (void)setItemArry:(NSMutableArray *)itemArry{
    _itemArry = itemArry;
    [self.collectionView reloadData];
}

#pragma mark - LazyGet
- (FSPromotionLayout *)promotionLayout {
    if (_promotionLayout == nil) {
        _promotionLayout = [[FSPromotionLayout alloc] init];
        _promotionLayout.columnCount = 4;
        _promotionLayout.rowMargin = 2;
        _promotionLayout.columnMargin = 2;
        _promotionLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
//        _promotionLayout.delegate = self;
    }
    return _promotionLayout;
}

@end
