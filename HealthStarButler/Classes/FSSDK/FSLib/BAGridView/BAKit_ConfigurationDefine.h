
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#ifndef BAKit_ConfigurationDefine_h
#define BAKit_ConfigurationDefine_h


#pragma mark - weak / strong
#define BAKit_WeakSelf        @BAKit_Weakify(self);
#define BAKit_StrongSelf      @BAKit_Strongify(self);

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@BAKit_Weakify`实现弱引用转换，`@BAKit_Strongify`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef BAKit_Weakify
#if DEBUG
#if __has_feature(objc_arc)
#define BAKit_Weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define BAKit_Weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define BAKit_Weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define BAKit_Weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@BAKit_Weakify(object)`实现弱引用转换，`@BAKit_Strongify(object)`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify(object)
 * [obj block:^{
 * @BAKit_Strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef BAKit_Strongify
#if DEBUG
#if __has_feature(objc_arc)
#define BAKit_Strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define BAKit_Strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define BAKit_Strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define BAKit_Strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#pragma mark - runtime
/*! runtime set */
#define BAKit_Objc_setObj(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

/*! runtime setCopy */
#define BAKit_Objc_setObjCOPY(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY)

/*! runtime get */
#define BAKit_Objc_getObj objc_getAssociatedObject(self, _cmd)

/*! runtime exchangeMethod */
#define BAKit_Objc_exchangeMethodAToB(methodA,methodB) method_exchangeImplementations(class_getInstanceMethod([self class], methodA), class_getInstanceMethod([self class], methodB));

#pragma mark - 简单警告框
/*! view 用 BAKit_ShowAlertWithMsg */
#define BAKit_ShowAlertWithMsg(msg) [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:(msg) delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil] show];
/*! VC 用 BAKit_ShowAlertWithMsg */
#define BAKit_ShowAlertWithMsg_ios8(msg) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];


CG_INLINE UIColor *
BAKit_Color_RGBA(u_char r,u_char g, u_char b, u_char a) {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

CG_INLINE UIColor *
BAKit_Color_RGB(u_char r,u_char g, u_char b) {
    return BAKit_Color_RGBA(r, g, b, 1.0);
}

#define BAKit_Color_Translucent    [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:0.5f]
#define BAKit_Color_White          [UIColor whiteColor]
#define BAKit_Color_Clear          [UIColor clearColor]
#define BAKit_Color_Black          [UIColor blackColor]
#define BAKit_Color_White          [UIColor whiteColor]
#define BAKit_Color_Red            [UIColor redColor]

/*! 灰色 */
#define BAKit_Color_Gray_1  BAKit_Color_RGB(53, 60, 70);
#define BAKit_Color_Gray_2  BAKit_Color_RGB(73, 80, 90);
#define BAKit_Color_Gray_3  BAKit_Color_RGB(93, 100, 110);
#define BAKit_Color_Gray_4  BAKit_Color_RGB(113, 120, 130);
#define BAKit_Color_Gray_5  BAKit_Color_RGB(133, 140, 150);
#define BAKit_Color_Gray_6  BAKit_Color_RGB(153, 160, 170);
#define BAKit_Color_Gray_7  BAKit_Color_RGB(173, 180, 190);
#define BAKit_Color_Gray_8  BAKit_Color_RGB(196, 200, 208);
#define BAKit_Color_Gray_9  BAKit_Color_RGB(216, 220, 228);
#define BAKit_Color_Gray_10 BAKit_Color_RGB(240, 240, 240);
#define BAKit_Color_Gray_11 BAKit_Color_RGB(248, 248, 248);


#define BAKit_ImageName(imageName)  [UIImage imageNamed:imageName]


/*!
 *  获取屏幕宽度和高度
 */
#define BAKit_SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define BAKit_SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define BAKit_BaseScreenWidth   320.0f
#define BAKit_BaseScreenHeight  568.0f

/*! 屏幕适配（5S标准屏幕：320 * 568） */
// iPhone 7 屏幕：375 * 667
//376/320 =
//667/568 =
#define BAKit_ScaleXAndWidth    BAKit_SCREEN_WIDTH/BAKit_BaseScreenWidth
#define BAKit_ScaleYAndHeight   BAKit_SCREEN_HEIGHT/BAKit_BaseScreenHeight

#define BAKit_ScreenScale ([[UIScreen mainScreen] scale])

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
BAKit_FlatSpecificScale(CGFloat floatValue, CGFloat scale) {
    scale = scale == 0 ? BAKit_ScreenScale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
BAKit_Flat(CGFloat floatValue) {
    return BAKit_FlatSpecificScale(floatValue, 0);
}

/// 将一个CGSize像素对齐
CG_INLINE CGSize
BAKit_CGSizeFlatted(CGSize size) {
    return CGSizeMake(BAKit_Flat(size.width), BAKit_Flat(size.height));
}

/// 创建一个像素对齐的CGRect
CG_INLINE CGRect
BAKit_CGRectFlatMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(BAKit_Flat(x), BAKit_Flat(y), BAKit_Flat(width), BAKit_Flat(height));
}

/**
 计算列数【根据 array.count、每行多少个 item，计算列数】
 
 @param array array
 @param rowCount 每行多少个 item
 @return 列数
 */
CG_INLINE NSInteger
BAKit_getColumnCountWithArrayAndRowCount(NSArray *array, NSInteger rowCount){
    NSUInteger count = array.count;
    
    NSUInteger i = 0;
    if (count % rowCount == 0)
    {
        i = count / rowCount;
    }
    else
    {
        i = count / rowCount + 1;
    }
    return i;
}


#endif /* BAKit_ConfigurationDefine_h */
