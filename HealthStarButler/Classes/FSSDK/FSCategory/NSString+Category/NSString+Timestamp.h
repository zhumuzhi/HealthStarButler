//
//  NSString+Timestamp.h
//  XFSSalesSecretary
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Timestamp)
+ (NSString *)timestampFromString:(NSString *)theTime;
+ (NSString *)timetimestampToString:(NSString *)timestamp;
 
@end
