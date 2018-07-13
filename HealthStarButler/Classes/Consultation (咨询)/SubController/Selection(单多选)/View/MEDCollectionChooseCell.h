//
//  MEDCollectionChooseCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/28.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDCollectionChooseCell : UICollectionViewCell

@property (nonatomic, retain) UILabel * titleLab;
@property (nonatomic, retain) UIButton * selectIconBtn;
@property (nonatomic, assign) BOOL isSelected;

-(void)UpdateCellWithState:(BOOL)select;

@end
