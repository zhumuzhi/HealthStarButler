//
//  MEDCircleButton.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDCircleButton.h"

@implementation MEDCircleButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = MEDCommonBlue.CGColor;
    self.layer.cornerRadius = self.width * 0.5;
}

@end
