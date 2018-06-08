//
//  MEDNetStatusManager.h
//  MEDThyroid
//
//  Created by Harry on 16/2/19.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDNetStatusManager : NSObject

/**
 *  监视网络
 */
+(void)monitor;

/**
 *  当前网络是否可用
 *
 *  return 
 */
+(BOOL)isNetWork;
@end
