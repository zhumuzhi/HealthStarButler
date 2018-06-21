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

@property (nonatomic, weak) UIImageView *backImage;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *userName;

@end

@implementation MEDMineHeadView

#pragma mark - SetData

- (void)setUserModel:(MEDUserModel *)userModel {
    _userModel = userModel;

    _userModel.sex;

    // 头像赋值
    NSString *placeholder = userModel.userPhoto;


    [self.icon sd_setImageWithURL:[NSURL URLWithString:placeholder] placeholderImage:[UIImage imageNamed:@"placeholder"]];

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
        [backImage addSubview:icon];
        self.icon = icon;
        // 用户名
        UILabel *userName = [[UILabel alloc] init];
        [backImage addSubview:userName];
        self.userName = userName;
    }
    return self;
}


#pragma mark - SetFrame
- (void)layoutSubviews
{
    [super layoutSubviews];

    //头像
    CGFloat iconW = 70;
    CGFloat iconX = self.width - (iconW*0.5);
    CGFloat iconY = self.height - (iconW*0.5);
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconW)];

    // 用户名
    CGSize userNameSize = [@"超长的以防不够用的用户名标题占位" sizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat userNameX = SCREEN_WIDTH/2 - userNameSize.width/2;
    CGFloat userNameY = CGRectGetMaxY(icon.frame) + 10;
    CGFloat usernameW = SCREEN_WIDTH;
    CGFloat usernameH = userNameSize.height;
    self.userName.frame = CGRectMake(userNameX, userNameY, usernameW, usernameH);
}



@end
