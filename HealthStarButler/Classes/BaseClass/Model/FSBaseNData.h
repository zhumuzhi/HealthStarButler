//
//  FSBaseNData.h
//  FangShengyun
//
//  Created by mac on 2018/6/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBaseReqNData : NSObject
/** 请求url */
@property (nonatomic , copy) NSString *url;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *parametes;
@end

@interface FSBaseResNData : NSObject
/**
 错误码
 
 0 操作成功!
 1010001 系统服务异常
 1010002 调用远程服务异常
 1010003 操作失败，请联系管理员！
 23 调用查询签约客户接口失败:每页条数pageSize参数不能为空!
 24 调用查询签约客户接口失败:每页条数pageSize参数不是正整数!
 90 调用查询签约客户接口失败:系统异常,请联系会员中心管理员!
 
 */

#define kGetDataSuccess 0
@property (nonatomic , assign) NSInteger totalPages;

@property (nonatomic , assign) NSInteger curPage;

@property (nonatomic , assign) NSInteger errorCode;
@property (nonatomic , copy) NSString *errorMessage;

/** 返回对象 */
@property (nonatomic , strong) NSDictionary *data;

@property (nonatomic , assign) NSInteger brandCode;
@property (nonatomic , strong) NSMutableArray *dataArray;
- (void)parse:(NSDictionary *)dictionary;
- (instancetype)initWithDict: (NSDictionary *)dict;



@end
