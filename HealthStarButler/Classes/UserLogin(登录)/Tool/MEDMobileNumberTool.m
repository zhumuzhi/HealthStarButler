//
//  MEDMobileNumberTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDMobileNumberTool.h"

@implementation MEDMobileNumberTool

+ (BOOL)isMobileNumber:(NSString *)mobileNum onlyMobile:(BOOL)onlyMobile{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,184,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1([3-9])\\d{9}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,184,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2478]|7[0-9])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if ([regextestmobile evaluateWithObject:mobileNum]) {
        return YES;
    }else if([regextestcm evaluateWithObject:mobileNum]){
        return YES;
    }else if([regextestct evaluateWithObject:mobileNum]){
        return YES;
    }else if([regextestcu evaluateWithObject:mobileNum]){
        return YES;
    }else{
        if (!onlyMobile) {
            return [regextestphs evaluateWithObject:mobileNum];
        }
    }
    return NO;
}

@end
