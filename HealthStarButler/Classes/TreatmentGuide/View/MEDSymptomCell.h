//
//  MEDSymptomCell.h
//  健康之星管家
//
//  Created by 朱慕之 on 2018/5/31.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDSymptomCell : UICollectionViewCell

@property(strong,nonatomic)UILabel * titlesLab;
@property(strong,nonatomic)UIImageView * delimgv;

-(instancetype)initWithFrame:(CGRect)frame;

@end
