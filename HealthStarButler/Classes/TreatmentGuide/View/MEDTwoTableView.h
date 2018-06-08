//
//  MEDTwoTableView.h
//  健康之星管家
//
//  Created by 夏帅 on 15/11/11.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SymptomType) {
//    全身
    faRe = 1,
    chouChu,
    faLiXuHan,
    shiMian,
    shiYuBuZhen,
    huangDan,
    
//    头颈
    touJingShuiZhong,
    keSuKeTan,
    keXue,
    faGan,
    touTong,
    xuanYun,
    yunJue,
    
//    胸部
    xiongTong,
    huxiKunNan,
    xinJi,
    eXinOuTu,
    xiongBupiFuNianMoChuXue,
    ouXue,
    xiongBuZhongKuai,
    yaoBeiTeng,
    
//    腹部
    bianXue,
    fuTeng,
    fuXie,
    bianMi,
    fuBuZhongKuai,
    
//    四肢
    guanJieTeng,
    SiZhiPiFuNianMoChuXue,
    siZhishuiZhong,
    siZhiTengTong,
    siZhiZhongKuai,
    ganJueXiaoTui,
    
//    腹部
    xueNiao,
    niaoPinNiaoJi,
    shaoNiaoWuNiao,
    duoNiao,
};


@interface MEDTwoTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UITableView * rightTablew;
@property (assign, nonatomic) NSInteger select;

@property (nonatomic, assign) SymptomType selectType;

@property(copy,nonatomic,readonly) id block;

/*
 *  左右table锁定第几个为首选项
 */
@property(assign,nonatomic) NSInteger leftSelectIndex;
@property(assign,nonatomic) NSInteger rightSelectIndex;

/**
 *  左边背景颜色
 */
@property(strong,nonatomic) UIColor * leftBgColor;
/**
 *  左边点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftSelectColor;
/**
 *  左边点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftSelectBgColor;

/**
 *  左边未点中文字颜色
 */

@property(strong,nonatomic) UIColor * leftUnSelectColor;
/**
 *  左边未点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectBgColor;
/**
 *  tablew 的分割线
 */
@property(strong,nonatomic) UIColor * leftSeparatorColor;

-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray*)data withSelectIndex:(void(^)(NSInteger left,NSInteger right,id info))selectIndex;

@end
