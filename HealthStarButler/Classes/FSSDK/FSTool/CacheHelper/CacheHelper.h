//
//  CacheHelper.h
//  XFSSalesApp
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDImageCache.h"

typedef void (^CacheCallBack)(BOOL result);
@interface CacheHelper : NSObject
@property (nonatomic , assign) NSInteger index;
+ (instancetype)sharedManager;


/**
 *  写入/更新缓存(同步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param URL    数据请求URL
 *
 *  @return 是否写入成功
 */
-(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL;

/**
 *  写入/更新缓存(异步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *  @param jsonResponse    要写入的数据(JSON)
 *  @param URL             数据请求URL
 *  @param completedBlock  异步完成回调(主线程回调)
 */
- (void)save_asyncJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL completed:(CacheCallBack)completedBlock;

/**
 *  获取缓存的对象(同步)
 *  @param URL 数据请求URL
 *  @return 缓存对象
 */
- (id)cacheJsonWithURL:(NSString *)URL;

/** 获取缓存路径 */
- (NSString *)cachePath;

/** 获取SD缓存 */
- (CGFloat)sdGetCacheSize;
/** 删除SD缓存 */
- (void)sdClearCache:(nullable SDWebImageNoParamsBlock)completion;

/** 清除所有缓存 */
- (BOOL)clearCache;
/** 获取缓存总大小(单位:M)*/
- (float)cacheSize;

- (id)readHistoryData;
- (void)saveHistoryDataWitheText: (NSString *)text;
/** 存储数据 */
- (void)saveDataWithObject: (id)object key: (NSString *)key
            cacheCallBack : (CacheCallBack)cacheCallBack;
/** 读取数据 */
- (id)readDataWithKey: (NSString *)Key;
/** 删除数据 */
- (void)deleteDataWithKey: (NSString *)Key;
/** 删除数据 */
- (void)deleteHistoryData;
@end
