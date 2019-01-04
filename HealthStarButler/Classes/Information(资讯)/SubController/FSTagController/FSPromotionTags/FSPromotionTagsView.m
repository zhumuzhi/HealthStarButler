//
//  FSPromotionTagsView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/27.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSPromotionTagsView.h"
#import "FSPromotionTagsCell.h"

@interface FSPromotionTagsView ()<UICollectionViewDataSource, UICollectionViewDelegate, FSPromotionLayoutDelegate>

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
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.promotionLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[FSPromotionTagsCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView = collectionView;
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArry.count;
}
- (__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    FSPromotionTagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.title.text = [self.itemArry by_ObjectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - WaterFlowLayoutDelegate
- (CGSize)waterFlowLayout:(FSPromotionLayout *)WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [self getSize:self.itemArry[indexPath.row]];
    CGSize tempSize = CGSizeMake(size.width, self.collectionView.size.height);
    size = tempSize;
    return size;
}

- (CGSize)getSize:(NSString *)str {
    UIFont *font = [UIFont systemFontOfSize:kFont(10)];
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize mySize = [str sizeWithAttributes:attrs];
    // 两侧总间距kAutoWithSize(14)
    CGSize tempSize = CGSizeMake(mySize.width+kAutoWithSize(14), mySize.height);
    mySize = tempSize;
    return mySize;
}

- (void)getCollectionViewHeight:(CGFloat)ccHeight {
//    [self.delegte getTableCellHeight:ccHeight];
//    self.collectionView.frame.size.height = ccHeight;
}

#pragma mark - SetData
- (void)setItemArry:(NSMutableArray *)itemArry {
    _itemArry = itemArry;
    [self.collectionView reloadData];
}

#pragma mark - LazyGet
- (FSPromotionLayout *)promotionLayout {
    if (_promotionLayout == nil) {
        _promotionLayout = [[FSPromotionLayout alloc] init];
        _promotionLayout.rowMargin = 10; // 行间距
        _promotionLayout.delegate = self;
//        _promotionLayout.columnCount = 4;
//        _promotionLayout.columnMargin = 2;
//        _promotionLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    }
    return _promotionLayout;
}

@end
