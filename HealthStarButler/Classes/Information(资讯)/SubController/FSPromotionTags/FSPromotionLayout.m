//
//  FSPromotionLayout.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/27.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSPromotionLayout.h"

@interface FSPromotionLayout ()

/** 存放每一个item的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** count>0 表示换行 y 值计算方法改变 */
@property (nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation FSPromotionLayout

#pragma mark - Init
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - 计算布局
- (void)prepareLayout {
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    NSInteger iCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i<iCount; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
    [self.delegate getCollectionViewHeight:CGRectGetMaxY(((UICollectionViewLayoutAttributes*)[self.attrsArray lastObject]).frame)];
}

//返回collectionView内容区的宽度和高度，子类必须重载该方法，返回值代表了所有内容的宽度和高度，而不仅仅是可见范围的，collectionView通过该信息配置它的滚动范围，默认返回 CGSizeZero。
- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

//返回UICollectionViewLayoutAttributes 类型的数组，UICollectionViewLayoutAttributes 对象包含cell或view的布局信息。子类必须重载该方法，并返回该区域内所有元素的布局信息，包括cell,追加视图和装饰视图。
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

//返回指定indexPath的item的布局信息。子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.collectionView.frame.size.width;
    
    CGSize frameSize = [self.delegate waterFlowLayout:self heightForWidth:0.0 andIndexPath:indexPath];
    //计算每一个item的位置
    CGFloat x = CGRectGetMaxX(((UICollectionViewLayoutAttributes*)[self.attrsArray lastObject]).frame)+self.rowMargin;
    CGFloat y = 0;
    if (x+frameSize.width>width) {
        [self.sectionArray addObject:indexPath];
        x = self.rowMargin;
        y = CGRectGetMaxY(((UICollectionViewLayoutAttributes*)[self.attrsArray lastObject]).frame)+self.columnMargin;
    }
    else{
        if (self.sectionArray.count>0) {
            y = ((UICollectionViewLayoutAttributes*)[self.attrsArray lastObject]).frame.origin.y;
        }else{
            y = ((UICollectionViewLayoutAttributes*)[self.attrsArray lastObject]).frame.origin.y;
        }
    }
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //设置item的frame
    attrs.frame = CGRectMake(x, y, frameSize.width, frameSize.height);
    return attrs;
}

//该方法用来决定是否需要更新布局。如果collection view需要重新布局返回YES,否则返回NO,默认返回值为NO。子类重载该方法的时候，基于是否collection view的bounds的改变会引发cell和view布局的改变，给出正确的返回值。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}

#pragma mark - LazyGet
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}




@end
