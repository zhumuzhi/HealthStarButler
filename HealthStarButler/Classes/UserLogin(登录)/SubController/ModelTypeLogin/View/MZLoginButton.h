//
//  MZLoginButton.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZLoginButton;

typedef NSString* (^CountDownChanging)(MZLoginButton *MZLoginButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(MZLoginButton *MZLoginButton,NSUInteger second);

typedef void (^TouchedMZLoginButtonBlock)(MZLoginButton *button,NSInteger tag);

@interface MZLoginButton : UIButton
{
    NSInteger _second;
    NSUInteger _totalSecond;

    NSDate *_startDate;

    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedMZLoginButtonBlock _touchedLoginButtonBlock;
}

@property (nonatomic , strong)NSTimer *timer;

-(void)MZLoginButtonBlock:(TouchedMZLoginButtonBlock)touchedCountDownButtonBlock;

-(void)countDownChanging:(CountDownChanging)countDownChanging;

-(void)countDownFinished:(CountDownFinished)countDownFinished;

-(void)startCountDownWithSecond:(NSUInteger)second;
-(void)stopCountDown;

@end
