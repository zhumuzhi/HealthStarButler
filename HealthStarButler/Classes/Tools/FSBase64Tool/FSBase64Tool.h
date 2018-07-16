//
//  FSBase64Tool.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/16.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBase64Tool : NSObject

/*
 使用示例
 NSString *str = [NSString stringWithFormat:@"YWE="];
 NSString *str1 = [NSString stringWithFormat:@"aa"];
 NSLog(@"resultStr========%@",[CommonFunc textFromBase64String:str]);   //使用类名进行调用
 NSLog(@"resultStr=========%@",[CommonFunc base64StringFromText:str1]);  //使用类名进行调用
 */


/*
 函数名称 : + (NSString *)base64StringFromString:(NSString *)string
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 返回参数 : (NSString *)    base64格式字符串
*/
+ (NSString *)base64StringFromString:(NSString *)string;

/*
 函数名称 : + (NSString *)stringFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 返回参数 : (NSString *)    文本
 */
+ (NSString *)stringFromBase64String:(NSString *)base64;



@end
