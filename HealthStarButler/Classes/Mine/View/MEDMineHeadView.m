//
//  MEDMineHeadView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDMineHeadView.h"
#import "MEDUserModel.h"

@interface MEDMineHeadView ()

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *userName;

@end

@implementation MEDMineHeadView

#pragma mark - SetData

- (void)setUserModel:(MEDUserModel *)userModel {
    _userModel = userModel;

    // 根据性别判断占位图
    NSInteger sex =  _userModel.sex;
    NSString *placeholder;
    switch (sex) {
        case 1:
            placeholder = @"iconMale";
            break;
        case 2:
            placeholder = @"iconFemale";
            break;
        default:
            placeholder = @"iconNone";
            break;
    }

    //头像赋值
    NSString *userPhoto = _userModel.userPhoto;
    if ([userPhoto isKindOfClass:[NSNull class]] || userPhoto == nil || [userPhoto length] < 1 || [userPhoto isEqualToString:@"<null>"] ? YES : NO) {
        self.icon.image = [UIImage imageNamed:placeholder];
    }else {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:userPhoto] placeholderImage:[UIImage imageNamed:placeholder]];
    }

    //姓名赋值
    self.userName.text = userModel.user_name;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化子控件
        //背景
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:backImage];
        self.backImage = backImage;
        backImage.image = [UIImage imageNamed:@"mine_Head"];
        // 头像
        UIImageView *icon = [[UIImageView alloc] init];
        icon.layer.cornerRadius = 35;
        icon.layer.masksToBounds = YES;
        [self addSubview:icon];
        self.icon = icon;
        // 用户名
        UILabel *userName = [[UILabel alloc] init];
        userName.textAlignment = NSTextAlignmentCenter;
        userName.font = [UIFont systemFontOfSize:14];
        [self addSubview:userName];
        self.userName = userName;
    }
    return self;
}


#pragma mark - SetFrame
- (void)layoutSubviews
{
    [super layoutSubviews];

    // backImage
    self.backImage .frame = self.frame;

    //头像
    CGFloat iconW = 70;
    CGFloat iconX = SCREEN_WIDTH/2 - (iconW*0.5);
    CGFloat iconY = (SCREEN_HEIGHT/3)/2 - (iconW*0.5);
    self.icon.frame = CGRectMake(iconX, iconY, iconW, iconW);

    // 用户名
    CGSize userNameSize = [@"超长的以防不够用的用户" sizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat userNameX = self.centerX - userNameSize.width/2 - 8;
    CGFloat userNameY = CGRectGetMaxY(self.icon.frame) + 10;
    CGFloat usernameW = userNameSize.width;
    CGFloat usernameH = userNameSize.height;
    self.userName.frame = CGRectMake(userNameX, userNameY, usernameW, usernameH);
}



@end
