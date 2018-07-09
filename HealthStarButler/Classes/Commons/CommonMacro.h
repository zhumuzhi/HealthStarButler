//
//  CommonMacro.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#endif /* CommonMacro_h */



#pragma mark -------------------- Log --------------------

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s (%d行):\n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

#ifdef DEBUG
#define NSLogFunc NSLog(@"=====Begin==========\n FILE: %@\n FUNC: %s\n LINE: %d\n", [NSString stringWithUTF8String:__FILE__].lastPathComponent, __PRETTY_FUNCTION__, __LINE__)

#else
#define NSLogFunc
#endif

#pragma mark -------------------- Frame --------------------
// 屏幕宽度
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)

// 是否iPhone X
#define  MED_iPhoneX        (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)

// 状态栏Height
#define KStatusBarHeight     (MED_iPhoneX ? 44.f : 20.f )
// 导航栏Height
#define kNavigationHeight   (KStatusBarHeight + 44.f)
// TabBar距离底部
#define kTabbarSafeBottomMargin  (MED_iPhoneX ? 34.f : 0.0f)
// TabBarHeight
#define kTabBarHeight       (kTabbarSafeBottomMargin + 49.f)

// TabBar一级页面Frame
#define NormalFrame CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight-kTabBarHeight)

/** 二级页面Frame(由一级页面Push有Navigation) */
#define SecondPageFrame CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight-kTabbarSafeBottomMargin)

#define CELL_HEIGHT 44

#pragma mark -------------------- Color --------------------

#define MEDRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define MEDRGB(r, g, b)    MEDRGBA((r), (g), (b), 255)
#define MEDGrayColor(v)    MEDRGB((v), (v), (v))
#define MEDRandomColor     MEDRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define ZB_COLOR_HEX(x)              ([UIColor colorWithHexColor:(x)])

//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#define MEDCommonBgColor   MEDGrayColor(206)    //待定
#define MEDCommonBlue      MEDRGB(28, 196, 225) //待定
#define MEDCommonBlack     MEDRGB(40, 40, 40)   //待定

#define MEDCommonGray      MEDGrayColor(102)      //待定 健康方案字体颜色
#define MEDCommonLightGray MEDGrayColor(170)      //待定 健康方案标题颜色

#define MEDBlue          MEDRGB(28,196,225)
#define MEDGray          MEDGrayColor(102)
#define MEDLightGray     MEDGrayColor(170)
#define MEDBlack         MEDGrayColor(40)

#pragma mark -------------------- 字体 --------------------
#define MEDSYSFont(f) [UIFont systemFontOfSize:f]
#define MEDSYSBoldFont(f) [UIFont boldSystemFontOfSize:f]

#pragma mark -------------------- NetStatus --------------------
#define Status     @"status"   //状态key
#define Status_OK  0           //状态成功
#define UserId     @"userId"   //userId 请求参数

#define NetStatusSuccessful(responseObject) ([responseObject[Status] integerValue] == Status_OK) //请求成功判断

#define Data     @"data"       //数据Key
#define DataInfo @"dataInfo"   //存放登陆之后的所有数据

#pragma mark -------------------- UserDefaults_Keys --------------------
#define LoginInfo  @"loginInfo"    //登录信息存储
#define UserInfo   @"userInfo"     //用户信息

//#define FirstLogin @"first_login"  //首次登录判断

#define Login      @"login"        //登录判断
#define LoginSuccessful @"1"       //登录成功
#define LoginFailed     @"0"       //登录失败

#define Identity   @"identity"     //身份判断
#define UID        @"uid"          //uid



#pragma mark -------------------- Other --------------------

// weakSelf
#define MEDWeakSelf(type)  __weak typeof(type) weak##type = type;
#define MEDStrongSelf(type)  __strong typeof(type) type = weak##type;

//NSUserDefaults
#define kUserDefaults       [NSUserDefaults standardUserDefaults]

//UIApplication
#define kApplication        [UIApplication sharedApplication]

//KeyWindow
#define kKeyWindow          [UIApplication sharedApplication].keyWindow

//AppDelegate
#define kAppDelegate        ((AppDelegate*)([UIApplication sharedApplication].delegate))

//rootViewController
#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

//通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
 #define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif

#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//获取当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer］

// 求两个数中的最大值
#define MAX_VALUE(X,Y) ((X) > (Y) ? (X) : (Y))

//NSString
#define NSLocalStr(strkey, table)        (NSLocalizedStringFromTable((@"" strkey) ,(@"" table) , @"not set") )



//G－C－D

//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
