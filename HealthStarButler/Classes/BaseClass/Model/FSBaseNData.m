//
//  FSBaseNData.m
//  FangShengyun
//
//  Created by mac on 2018/6/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSBaseNData.h"

@implementation FSBaseReqNData
- (instancetype)init {
    if (self == [super init]) {
        
    }
    return self;
}

- (NSMutableDictionary *)parametes {
    if (_parametes == nil) {
        _parametes = [NSMutableDictionary dictionary];
    }
    return _parametes;
}

@end
@implementation FSBaseResNData
- (instancetype)initWithDict: (NSDictionary *)dict {
    self = [self init];
    if (self) {
        [self parse:dict];
    }
    return self;
}

- (void)parse:(NSDictionary *)dictionary {
    dispatch_async(dispatch_get_main_queue(), ^{
//        KAlert(nil, dictionary.mj_JSONString);

    });
    NSString *errorCode = dictionary[@"errorCode"];
    self.errorCode = errorCode.boolValue;
    NSString *totalPages = dictionary[@"totalPages"];
    self.totalPages = totalPages.integerValue;
    NSString *curPage = dictionary[@"curPage"];
    self.curPage = curPage.integerValue;
    NSString *errorMessage = dictionary[@"errorMessage"];
    self.errorMessage = errorMessage;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end

