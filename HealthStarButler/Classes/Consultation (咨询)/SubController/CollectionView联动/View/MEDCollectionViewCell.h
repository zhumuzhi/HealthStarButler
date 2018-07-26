//
//  MEDCollectionViewCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEDSubCategoryModel;

@interface MEDCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MEDSubCategoryModel *model;

@end
