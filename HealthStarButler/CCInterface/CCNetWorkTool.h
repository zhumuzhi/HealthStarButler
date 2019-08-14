//
//  CCNetWorkTool.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2019/8/14.
//  Copyright © 2019 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 网络请求工具
 */
@interface CCNetWorkTool : NSObject


typedef NS_ENUM(NSInteger, HttpErrorType) {
    HttpErrorTypeNormal=0,//请求正常，无错误
    HttpErrorTypeURLConnectionError,//请求时出错，可能是URL不正确
    HttpErrorTypeStatusCodeError,//请求时出错，服务器未返回正常的状态码：200
    HttpErrorTypeDataNilError,//请求回的Data在解析前就是nil，导致请求无效，无法后续JSON反序列化。
    HttpErrorTypeDataSerializationError,//data在JSON反序列化时出错
    HttpErrorTypeNoNetWork,//无网络连接
    HttpErrorTypeServiceRetrunErrorStatus,//服务器请求成功，但抛出错误
};

//单位分钟
typedef NS_ENUM(NSInteger, HttpCacheExpiredTimeType) {
    HttpCacheExpiredTimeTypeNormal=0,/**<不设置过期时间*/
    HttpCacheExpiredTimeTypeThirtyMinutes=30,/**<30分钟*/
    HttpCacheExpiredTimeTypeOneDay=1440,/**<一天*/
    HttpCacheExpiredTimeTypeTwoDay=2880/**<两天*/
};

typedef NS_ENUM(NSInteger, HttpRequestType) {
    HttpRequestTypeGet=0,
    HttpRequestTypePost
};

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
