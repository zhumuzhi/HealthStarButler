//
//  MEDDataRequest.m
//  yyy
//
//  Created by 朱慕之 on 16/6/12.
//  Copyright © 2016年 Meridian. All rights reserved.
//

// 此处的HUD提示应该移到View页面中

/*
 2017-08-19
 为了方便对接口网关做统一限流的处理  在统一的请求方法中增加参数 ： appversion apiversion apiplatform
 app端统一接口网关 ： http://api.mmednet.com
 appversion 统一取当前移动客户端的版本号 如1.8.0
 apiversion的值暂定为 v1
 apiplatform : 健康管家为 health  机器人为 robot
 */

#import "MEDNetClient.h"
#import "MEDDataRequest.h"

@implementation MEDDataRequest

#pragma mark - Private 配置

+ (MEDNetClient *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    MEDNetClient *manager = nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[MEDNetClient alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[MEDNetClient alloc] initWithBaseURL:url];
    }
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
     manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
    
    response.removesKeysWithNullValues = YES;
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    manager.requestSerializer.timeoutInterval = 60;// 请求超时时间是60秒
    
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
    
    return manager;
}

+ (id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

#pragma mark - GET方法

+ (void)GET:(NSString *)url params:(NSDictionary *)params
   success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail{
    //MYLog(@"GET网络请求的url--：%@",url);
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest
                             managerWithBaseURL:MED_DOMAIN_REQUEST sessionConfiguration:NO];
//    [manager.requestSerializer setValue:@"ios"forHTTPHeaderField:@"token-id"];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+ (void)GET:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
   success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail{
    
    //MYLog(@"GET+base网络请求的url--：%@",url);
    
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
//        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:baseUrl sessionConfiguration:NO];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
  
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}

#pragma mark - POST方法

+ (void)POST:(NSString *)url params:(NSDictionary *)params
    success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail{
    //MYLog(@"POST网络请求的url--：%@",url);
    if (![MEDNetStatusManager isNetWork]) {
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:MED_DOMAIN_REQUEST sessionConfiguration:NO];
    
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)POST:(NSString *)url params:(NSDictionary *)params imageFile:(NSArray *)imagefile success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail{
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:MED_DOMAIN_REQUEST sessionConfiguration:NO];
    //照着以前的老项目的方法
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        int i = 0;
        for (NSData *imageData  in imagefile)
        {
            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"tj%@%d",[formatter stringFromDate:[NSDate date]],i] mimeType:@"image/png"];
            i ++;
        }
        
         
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         fail(task,error);
    }];
    

}

+ (void)POST:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
    success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail{
    //MYLog(@"POST+Base网络请求的url--：%@",url);
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }
    
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:baseUrl sessionConfiguration:NO];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}


#pragma mark - UpLoad方法

+ (void)uploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(MEDProgress)progress success:(MEDResponseSuccess)success fail:(MEDResponseFail)fail{
    
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:MED_DOMAIN_REQUEST sessionConfiguration:NO];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

#pragma mark - 上传照片报错
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+ (void)uploadWithURL:(NSString *)url
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(MEDProgress)progress
             success:(MEDResponseSuccess)success
                fail:(MEDResponseFail)fail{
    
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:baseurl sessionConfiguration:YES];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MEDDataRequest responseConfiguration:responseObject];
        
        success(task,dic);
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}



#pragma mark - upLoad上传图片

+ (void)startMultiPartUploadTaskWithSubUrl:(NSString *)subUrl
                                                imagesArray:(NSArray *)images
                                          parameterOfimages:(NSString *)parameter
                                             parametersDict:(NSDictionary *)parameters
                                           compressionRatio:(float)ratio
                                               succeedBlock:(void(^)(NSURLSessionDataTask *task, id responseObject))succeedBlock
                                                failedBlock:(void(^)(NSURLSessionDataTask *task, NSError *error))failedBlock
                                        uploadProgressBlock:(void(^)(NSProgress *progress))uploadProgressBlock;
{
    
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:MED_DOMAIN_REQUEST sessionConfiguration:NO];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    
    NSLog(@"%@",parameters);
    
    [manager POST:subUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpeg",dateString,i];
            NSData *imageData;
            if (ratio > 0.0f && ratio < 1.0f) {
                imageData = UIImageJPEGRepresentation(image, ratio);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0f);
            }
            
            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            i++;
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        if (succeedBlock) {
            succeedBlock(task,result);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failedBlock) {
            failedBlock(task,error);
        }
        
    }];
    
}


#pragma mark - download方法


+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(MEDProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail{
    
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return nil;
    }
    
    MEDNetClient *manager = [self managerWithBaseURL:MED_DOMAIN_REQUEST sessionConfiguration:YES];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            fail(error);
        }else{
            
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}


#pragma mark - upload方法WithToken

+ (void)uploadUserToken:token
                    URL:(NSString *)url
          headImageData:(NSData *)imageData
                success:(ImageSuccessBlock)success
                failure:(ImageFailureBlock)failure
{
    
    
    if (![MEDNetStatusManager isNetWork]) {
        
        //[MEDProgressHUD dismissHUDErrorTitle:@"网络异常，请检查您的网络"];
        
        return;
    }

    
//    http://miot.mmednet.com/shark/p/user/upload/icon?user_id
    
    NSString *path = [NSString stringWithFormat:@"user/upload/icon?uid=%@",token];
    
    MEDNetClient *manager = [MEDDataRequest managerWithBaseURL:url sessionConfiguration:YES];
    NSString  * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"apiversion"];
    [manager.requestSerializer setValue:@"health" forHTTPHeaderField:@"apiplatform"];
    [manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData name:@"Filedata" fileName:@"avator.png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if (success) {
            
            if ([responseObject isKindOfClass:[NSData class]]) {
                
// 之前网络请求中未使用
//                NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                
//                success([jsonStr JSONValue]);
                
            } else {
                
                success(responseObject);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failure) {
            
            failure(error);
        }
    }];
}

@end
