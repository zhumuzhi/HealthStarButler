//
//  FSURL.h
//  FangShengyun
//
//  Created by mac on 2018/6/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#ifndef FSURL_h
#define FSURL_h

#pragma mark -------------------- BaseURl --------------------
#define kBaseUrl @"https://t.fsyuncai.com"
#define kPath(url) [NSString stringWithFormat:@"%@%@",kBaseUrl,url]

#pragma mark -------------------- 登录 --------------------
/** 验证码 */
#define kVerifyCode kPath(@"/membership/getImgVerifyCode.jhtml")
/** 登录 */
#define kLogin kPath(@"/membership/login.jhtml")

/** 一级分类 */
#define kCategoryByParam kPath(@"/product/category/categoryByParam")
/** 二级分类 */
#define kAllCategory  kPath(@"/product/category/allCategory")
/** 商品列表 */
#define kSearchSpuByNSame kPath(@"/search/SearchByValue.jhtml")
/** 商品介绍 */
#define kGoodDetails kPath(@"/product/product/skuDetailList")
/** 商品规格 */
#define kSpecifications kPath(@"/product/product/skuShopDetailInformation")
/** 智能搜索 */
#define kSmartSearch kPath(@"/search/queryStringAuto.jhtml")
/** 点击搜索 */
#define kClickSearch kPath(@"/search/queryString.jhtml")

#endif /* FSURL_h */
