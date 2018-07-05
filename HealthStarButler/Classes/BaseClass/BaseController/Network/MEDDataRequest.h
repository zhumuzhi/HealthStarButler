//
//  MEDDataRequest.h
//  yyy
//
//  Created by 朱慕之 on 16/6/12.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#import "MEDNetClient.h"

// 用户头像使用的宏定义
typedef void (^ImageSuccessBlock)(id responseObj);
typedef void (^ImageFailureBlock)(NSError *error);

#pragma mark - 宏定义
/**
 *  宏定义请求成功的block
 *  param response 请求成功返回的数据
 */
typedef void (^MEDResponseSuccess)(NSURLSessionDataTask * task,id responseObject);

/**
 *  宏定义请求失败的block
 *  @param error 报错信息
 */
typedef void (^MEDResponseFail)(NSURLSessionDataTask * task, NSError * error);

/**
 *  上传或者下载的进度
 *  @param progress 进度
 */
typedef void (^MEDProgress)(NSProgress *progress);


@interface MEDDataRequest : NSObject

#pragma mark - GET方法
/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)url
    params:(NSDictionary *)params success:(MEDResponseSuccess)success
      fail:(MEDResponseFail)fail;
/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)url baseURL:(NSString *)baseUrl
    params:(NSDictionary *)params success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail;

/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

#pragma mark - POST方法

+(void)POST:(NSString *)url
     params:(NSDictionary *)params
    success:(MEDResponseSuccess)success
       fail:(MEDResponseFail)fail;



//和上面的方法比较多传了一个参数（上传图片用这个，测试过，可以用）
+(void)POST:(NSString *)url
     params:(NSDictionary *)params
  imageFile:(NSArray *)imagefile
    success:(MEDResponseSuccess)success
       fail:(MEDResponseFail)fail;

/**
 *  含有baseURL的post方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)POST:(NSString *)url
    baseURL:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(MEDResponseSuccess)success
       fail:(MEDResponseFail)fail;



#pragma mark - UpLoad方法
/**
 *  普通路径上传文件
 *
 *  @param url      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
+(void)uploadWithURL:(NSString *)url
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(MEDProgress)progress
             success:(MEDResponseSuccess)success
                fail:(MEDResponseFail)fail;
/**
 *  含有跟路径的上传文件
 *
 *  @param url      请求网址路径
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
+(void)uploadWithURL:(NSString *)url
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(MEDProgress)progress
             success:(MEDResponseSuccess)success
                fail:(MEDResponseFail)fail;

#pragma mark - upLoad上传图片
/**
*  上传带图片的内容，允许多张图片上传（URL）POST
*
*  @param subUrl              请求地址
*  @param images              要上传的图片数组（注意数组内容需是图片）
*  @param parameter           图片数组对应的参数
*  @param parameters          其他参数字典
*  @param ratio               图片的压缩比例（0.0~1.0之间）
*  @param succeedBlock        成功的回调
*  @param failedBlock         失败的回调
*  @param uploadProgressBlock 上传进度的回调
*/
+ (void)startMultiPartUploadTaskWithSubUrl:(NSString *)subUrl
                                                imagesArray:(NSArray *)images
                                          parameterOfimages:(NSString *)parameter
                                             parametersDict:(NSDictionary *)parameters
                                           compressionRatio:(float)ratio
                                               succeedBlock:(void(^)(NSURLSessionDataTask *task, id responseObject))succeedBlock
                                                failedBlock:(void(^)(NSURLSessionDataTask *task, NSError *error))failedBlock
                                        uploadProgressBlock:(void(^)(NSProgress *progress))uploadProgressBlock;


#pragma mark - DownLoad方法

/**
 *  下载文件
 *
 *  @param url      请求网络路径
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(MEDProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail;


/**
 *  上传用户头像方法, 还需要调整
 */
+ (void)uploadUserToken:token
                    URL:(NSString *)url
          headImageData:(NSData *)imageData
                success:(ImageSuccessBlock)success
                failure:(ImageFailureBlock)failure;


@end
