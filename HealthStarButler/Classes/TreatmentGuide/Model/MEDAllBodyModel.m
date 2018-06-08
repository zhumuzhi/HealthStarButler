//
//  MEDAllBodyModel.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/16.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDAllBodyModel.h"

@implementation MEDAllBodyModel

+(instancetype)sharedAllBodyModel
{
    static id instance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[MEDAllBodyModel alloc]init];
    });
    return instance;
}

@end

@implementation MEDHeadModel : NSObject

+(instancetype)sharedHeadModel
{
    static id instance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[MEDHeadModel alloc]init];
    });
    return instance;
}

@end

@implementation MEDChestModel : NSObject

+(instancetype)sharedChestModel
{
    static id instance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[MEDChestModel alloc]init];
    });
    return instance;
}

@end


@implementation MEDBellyModel : NSObject

+(instancetype)sharedBellyModel
{
    static id instance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[MEDBellyModel alloc]init];
    });
    return instance;
}

@end


@implementation MEDLimbsModel : NSObject

+(instancetype)sharedLimbsModel
{
    static id instance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[MEDLimbsModel alloc]init];
    });
    return instance;
}

@end