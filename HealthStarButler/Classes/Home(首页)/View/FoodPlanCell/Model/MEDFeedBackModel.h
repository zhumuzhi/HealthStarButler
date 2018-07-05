//
//  MEDFeedBackModel.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDFeedBackModel : NSObject

@property (nonatomic,strong)NSMutableArray *maxEnergyArray;//全部数据的最大值
@property (nonatomic,strong)NSMutableArray *minEnergyArray;//全部数据的最小值
@property (nonatomic,copy)NSString *actualInputEneger;//用户填写的
@property (nonatomic,copy)NSString *inputEnergyMin;//用户每日最小摄入
@property (nonatomic,copy)NSString *inputEnergyMax;//用户每日最大射日
@property (nonatomic,strong)NSMutableArray *userAllArray;//用户填写的全部数据
@property (nonatomic,strong)NSMutableArray *foodNameArray;//全部名称
@property (nonatomic,copy)NSString *percentageFoodString;

@property (nonatomic,copy)NSString *symbolImage;//大于或者等于号
@property (nonatomic,copy)NSString *allSumStr;//总热量的大于或小于描述
@property (nonatomic,copy)NSString *infoString;//总热量的详细描述

@property (nonatomic,strong)NSMutableArray *exceedArray;//全部超标话术
@property (nonatomic,strong)NSMutableArray *insufficientArray;//全部不足话术
@property (nonatomic,strong)NSMutableArray *normalArray;//全部正常
@property (nonatomic,strong)NSMutableArray *isOverproofArray;//是否超标详细话术
@property (nonatomic,strong)NSMutableArray *isFoodArray;//超标的食物名称
@property (nonatomic,strong)NSMutableArray *isFoodImagArray;//超标食物照片
@property (nonatomic,strong)NSMutableArray *isRedArray;//颜色表示红色是超标

@property (nonatomic,strong)NSMutableArray *foodNumberArray;//超过的量
@property (nonatomic,strong)NSMutableArray *nomorFoodArray;//正常食物

- (void)feedBackDataWithDict:(NSDictionary *)dict;


@end
