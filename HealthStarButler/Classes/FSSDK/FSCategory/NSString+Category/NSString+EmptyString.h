//
//  NSString+EmptyString.h
//  FXMOnLineAPP
//
//  Created by GHome on 2018/1/17.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EmptyString)
- (void)isHaveEmptyString: (NSString *)string
                   result: (void(^)(bool isHave,NSRange range))result;
@end
