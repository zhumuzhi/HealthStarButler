//
//  NSString+Parameter.h
//  XFSSalesApp
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Parameter)
/**
 将url中带的参数转为字典

 @param urlStr url
 @return 返回字典
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;
@end
