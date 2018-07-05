//
//  MEDMonitorController.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 监测类型 */
typedef NS_ENUM(NSInteger, MEDMoitorType) {
    MEDMoitorTypeBloodPressure,  //血压
    MEDMoitorTypeBloodGlucose,   //血糖
    MEDMoitorTypeBloodOxygen,    //血氧
    MEDMoitorTypeWeight,         //体重
    MEDMoitorTypeSport,          //运动
    MEDMoitorTypeSleep,          //睡眠
    MEDMoitorTypeWaistline,      //腰围
    MEDMoitorTypeTemperature     //体温
};

@interface MEDMonitorController : UIViewController

@property (nonatomic , assign)MEDMoitorType moitorType;

@property(nonatomic ,strong)UIScrollView *scrollView ;
@property(nonatomic ,strong)UIScrollView *scrollLabel ;

@end
