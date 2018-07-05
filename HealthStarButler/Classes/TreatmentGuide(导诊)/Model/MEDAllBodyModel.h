//
//  MEDAllBodyModel.h
//  健康之星管家
//
//  Created by 夏帅 on 15/11/16.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDAllBodyModel : NSObject

@property (nonatomic, assign) BOOL  faRe;
@property (nonatomic, assign) BOOL  chouChu;
@property (nonatomic, assign) BOOL  faLiXuHan;
@property (nonatomic, assign) BOOL  shiMian;
@property (nonatomic, assign) BOOL  shiYuBuZhen;
@property (nonatomic, assign) BOOL  huangDan;

+(instancetype)sharedAllBodyModel;

@end

@interface MEDHeadModel : NSObject

@property (nonatomic, assign) BOOL  touJingShuiZhong;
@property (nonatomic, assign) BOOL  keSuKeTan;
@property (nonatomic, assign) BOOL  keXue;
@property (nonatomic, assign) BOOL  faGan;
@property (nonatomic, assign) BOOL  touTong;
@property (nonatomic, assign) BOOL  xuanYun;
@property (nonatomic, assign) BOOL  yunJue;

+(instancetype)sharedHeadModel;

@end

@interface MEDChestModel : NSObject

@property (nonatomic, assign) BOOL  xiongTong;
@property (nonatomic, assign) BOOL  huxiKunNan;
@property (nonatomic, assign) BOOL  xinJi;
@property (nonatomic, assign) BOOL  eXinOuTu;
@property (nonatomic, assign) BOOL  xiongBupiFuNianMoChuXue;
@property (nonatomic, assign) BOOL  ouXue;
@property (nonatomic, assign) BOOL  xiongBuZhongKuai;
@property (nonatomic, assign) BOOL  yaoBeiTeng;

+(instancetype)sharedChestModel;

@end

@interface MEDBellyModel : NSObject

@property (nonatomic, assign) BOOL  bianXue;
@property (nonatomic, assign) BOOL  fuTeng;
@property (nonatomic, assign) BOOL  fuXie;
@property (nonatomic, assign) BOOL  bianMi;
@property (nonatomic, assign) BOOL  fuBuZhongKuai;
@property (nonatomic, assign) BOOL  xueNiao;
@property (nonatomic, assign) BOOL  niaoPinNiaoJi;
@property (nonatomic, assign) BOOL  shaoNiaoWuNiao;
@property (nonatomic, assign) BOOL  duoNiao;

+(instancetype)sharedBellyModel;

@end

@interface MEDLimbsModel : NSObject

@property (nonatomic, assign) BOOL  guanJieTeng;
@property (nonatomic, assign) BOOL  SiZhiPiFuNianMoChuXue;
@property (nonatomic, assign) BOOL  siZhishuiZhong;
@property (nonatomic, assign) BOOL  siZhiTengTong;
@property (nonatomic, assign) BOOL  siZhiZhongKuai;
@property (nonatomic, assign) BOOL  ganJueXiaoTui;

+(instancetype)sharedLimbsModel;

@end
