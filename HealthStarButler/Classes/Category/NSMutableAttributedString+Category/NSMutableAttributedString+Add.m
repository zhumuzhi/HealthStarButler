//
//  NSMutableAttributedString+Add.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "NSMutableAttributedString+Add.h"

@implementation NSMutableAttributedString (Add)

- (NSMutableAttributedString *(^)(NSString *, NSDictionary<NSString *,id> *))add {
    return ^NSMutableAttributedString * (NSString *string, NSDictionary <NSString *,id>*attrDic) {

        if ([[attrDic allKeys] containsObject:NSImageAttributeName] && [[attrDic allKeys] containsObject:NSImageBoundsAttributeName]) {
            NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            CGRect rect = CGRectFromString(attrDic[NSImageBoundsAttributeName]);
            attach.bounds = rect;
            attach.image = attrDic[NSImageAttributeName];

            [self appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
        }
        else {
            [self appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attrDic]];
        }

        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))addStr {
    return ^NSMutableAttributedString * (NSString *string) {
            NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            [self appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
        return self;
    };
}



@end

NSString *const NSImageAttributeName = @"NSImageAttributeName";
NSString *const NSImageBoundsAttributeName = @"NSImageBoundsAttributeName";
