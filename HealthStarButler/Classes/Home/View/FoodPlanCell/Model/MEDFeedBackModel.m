//
//  MEDFeedBackModel.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDFeedBackModel.h"

@implementation MEDFeedBackModel


- (void)feedBackDataWithDict:(NSDictionary *)dict{
    
    NSDictionary *baseDict = dict[@"data"];
    
    _maxEnergyArray = [@[] mutableCopy];
    _minEnergyArray = [@[] mutableCopy];
    _userAllArray = [@[] mutableCopy];
    _foodNameArray = [@[] mutableCopy];
    
    _isFoodArray = [@[] mutableCopy];
    _isFoodImagArray = [@[] mutableCopy];
    _isOverproofArray = [@[] mutableCopy];
    _isRedArray = [@[] mutableCopy];
    _foodNumberArray = [@[] mutableCopy];
    _nomorFoodArray = [@[] mutableCopy];
    
    NSArray *foodLogDetailArr = baseDict[@"foodLogDetail"];
    _actualInputEneger = [NSString stringWithFormat:@"%@",baseDict[@"actualInputEneger"]];
    _inputEnergyMin = [NSString stringWithFormat:@"%@",baseDict[@"inputEnergyMin"]];
    _inputEnergyMax = [NSString stringWithFormat:@"%@",baseDict[@"inputEnergyMax"]];
    
    for (NSDictionary *dict in foodLogDetailArr) {
        [_maxEnergyArray addObject:[NSString stringWithFormat:@"%@",dict[@"maxWeight"]]];
        [_minEnergyArray addObject:[NSString stringWithFormat:@"%@",dict[@"minWeight"]]];
        [_userAllArray addObject:[NSString stringWithFormat:@"%@",dict[@"weight"]]];
        
        NSDictionary *foodType = dict[@"foodType"];
        [_foodNameArray addObject:[NSString stringWithFormat:@"%@",foodType[@"foodTypeName"]]];
    }
    
    [_foodNameArray addObject:@"主食"];
    
    
    if ([_actualInputEneger integerValue] > [_inputEnergyMax integerValue]) {
        _symbolImage = @"qwp_dyh";
        _allSumStr = @"您几天的总热量摄入超标，请适当运动。";
        _infoString = @" 食物摄入总量超标，长此以往多余的能量会以脂肪的形式贮存起来而导致肥胖，而肥胖又是导致高血压、糖尿病等慢性疾病“元凶”，为了您的健康，每天的食物摄入总量不宜过量。";
        CGFloat b = [_actualInputEneger integerValue]/[_inputEnergyMax floatValue]*100;
        _percentageFoodString = [NSString stringWithFormat:@"%.0f",b];
    }else if ([_actualInputEneger integerValue] < [_inputEnergyMin integerValue]){
        _symbolImage = @"qwp_xyh";
        _allSumStr = @"您几天的总热量摄入不足，请适当补充营养。";
        _infoString = @"食物摄入总量不足，身体会处于负平衡状态，长期摄入不足会出现身体消瘦、免疫力下降等状况，所以您需要保证每天食物摄入总量充足。";
        CGFloat b = [_inputEnergyMin integerValue] /[_actualInputEneger floatValue]*100;
        _percentageFoodString = [NSString stringWithFormat:@"%.0f",b];
    }else{
        _symbolImage = @"qwp_ydy";
        _allSumStr = @"您的摄入正常，请保持。";
        _infoString = @"";
        _percentageFoodString = [NSString stringWithFormat:@"0"];
        
    }
    
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"QWP_FoodList" ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:jsonPath];
    NSError *error;
    NSArray *questionnaireArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSDictionary *dictInfo = (NSDictionary*)questionnaireArr;
    
    NSArray *infoArray = dictInfo[@"foodGrade"];
    NSMutableArray *exceedArr = [@[] mutableCopy];
    NSMutableArray *insufficientArr = [@[] mutableCopy];
    NSMutableArray *normalArr = [@[] mutableCopy];
    NSMutableArray *foodImage = [@[] mutableCopy];
    for (NSDictionary *dict in infoArray) {
        [exceedArr addObject:dict[@"exceed"]];
        [insufficientArr addObject:dict[@"insufficient"]];
        [normalArr addObject:dict[@"normal"]];
        [foodImage addObject:dict[@"image"]];
    }
    
    
    
    for (int i = 0; i < _userAllArray.count; i++) {
        NSInteger weight = [_userAllArray[i] integerValue];
        NSInteger minWeight = [_minEnergyArray[i] integerValue];
        NSInteger maxWeight = [_maxEnergyArray[i] integerValue];
        
        if (weight > maxWeight) {
            [_isOverproofArray addObject:exceedArr[i]];
            [_isFoodImagArray addObject:foodImage[i]];
            [_isRedArray addObject:@"1"];
            [_isFoodArray addObject:_foodNameArray[i]];
            [_foodNumberArray addObject:[NSString stringWithFormat:@"%zd",weight - maxWeight]];
        }else if (weight < minWeight){
            [_isOverproofArray addObject:insufficientArr[i]];
            [_isFoodImagArray addObject:foodImage[i]];
            [_isRedArray addObject:@"2"];
            [_isFoodArray addObject:_foodNameArray[i]];
            [_foodNumberArray addObject:[NSString stringWithFormat:@"%zd",minWeight - weight]];
            
        }else{
            [_nomorFoodArray addObject:_foodNameArray[i]];
        }
        
    }
    
    NSInteger zsWeight = [_userAllArray[0] integerValue]+[_userAllArray[1] integerValue];
    NSInteger zsMinWeight = [_minEnergyArray[0] integerValue]+[_minEnergyArray[1] integerValue];
    NSInteger zsMaxWeight = [_maxEnergyArray[0] integerValue]+[_maxEnergyArray[1] integerValue];
    
    
    if (zsWeight > zsMaxWeight) {
        [_isOverproofArray addObject:[exceedArr lastObject]];
        [_isFoodImagArray addObject:[foodImage lastObject]];
        [_isRedArray addObject:@"1"];
        [_isFoodArray addObject:[_foodNameArray lastObject]];
        [_foodNumberArray addObject:[NSString stringWithFormat:@"%zd",zsWeight - zsMaxWeight]];
        
    }else if (zsWeight < zsMinWeight){
        [_isOverproofArray addObject:[insufficientArr lastObject]];
        [_isFoodImagArray addObject:[foodImage lastObject]];
        [_isRedArray addObject:@"2"];
        [_isFoodArray addObject:[_foodNameArray lastObject]];
        [_foodNumberArray addObject:[NSString stringWithFormat:@"%ld",zsMinWeight - zsWeight]];
        
    }else{
        [_isOverproofArray addObject:[normalArr lastObject]];
        [_nomorFoodArray addObject:[_foodNameArray lastObject]];
        
    }
    
}


@end
