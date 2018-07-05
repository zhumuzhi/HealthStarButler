//
//  MEDBloodPressureFrame.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/11/8.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDBloodPressureFrame.h"
#import "MEDBloodpressureModel.h"


@implementation MEDBloodPressureFrame

- (void)setBloodPressure:(MEDBloodpressureModel *)bloodPressure {
    _bloodPressure = bloodPressure;
    
    CGFloat imageFX = 10;
    CGFloat imageFY = 10;
    CGFloat imageFW = 10;
    CGFloat imageFH = 10;
    self.imageF = CGRectMake(imageFX, imageFY, imageFW, imageFH);
    
    CGFloat dateFX = imageFX + 10;
    CGFloat dateFY = imageFY;
    CGFloat dateFW = 80;
    CGFloat dateFH = 20;
    self.dateF = CGRectMake(dateFX, dateFY, dateFW, dateFH);
    
    CGFloat typeFX = dateFX + dateFW + 10;
    CGFloat typeFY = imageFY;
    CGFloat typeFW = 40;
    CGFloat typeFH = 20;
    self.typeF = CGRectMake(typeFX, typeFY, typeFW, typeFH);
    
    CGFloat systolicFX = typeFX;
    CGFloat systolicFY = 0;
    CGFloat systolicFW = 30;
    CGFloat isystolicFH = 20;
    self.systolicF = CGRectMake(systolicFX, systolicFY, systolicFW, isystolicFH);
    
    CGFloat separatorFX = 0;
    CGFloat separatorFY = 0;
    CGFloat separatorFW = 10;
    CGFloat separatorFH = 20;
    self.separatorF = CGRectMake(separatorFX, separatorFY, separatorFW, separatorFH);

    CGFloat diastolicFX = 0;
    CGFloat diastolicFY = 0;
    CGFloat diastolicFW = 30;
    CGFloat diastolicFH = 20;
    self.separatorF = CGRectMake(diastolicFX, diastolicFY, diastolicFW, diastolicFH);
    
    CGFloat unitFX = 0;
    CGFloat unitFY = 0;
    CGFloat unitFW = 45;
    CGFloat unitFH = 20;
    self.separatorF = CGRectMake(unitFX, unitFY, unitFW, unitFH);
    
    CGFloat heartRateFX = 0;
    CGFloat heartRateFY = 0;
    CGFloat heartRateFW = 100;
    CGFloat heartRateFH = 20;
    self.separatorF = CGRectMake(heartRateFX, heartRateFY, heartRateFW, heartRateFH);

    
    
}



@end
