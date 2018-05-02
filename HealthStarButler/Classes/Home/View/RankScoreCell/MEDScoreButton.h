//
//  MEDScoreButton.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/27.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDScoreButton : UIButton

@property (nonatomic, strong) UIImageView *btnImage;
@property (nonatomic, strong) UILabel *btnTitle;

- (void)initWithImage:(NSString *)image andTitle:(NSString *)title;

//新添加小红点
//@property(nonatomic,strong)UIView * redPointView;

@end
