//
//  MZLoginButton.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZLoginButton.h"

@implementation MZLoginButton

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - touche action

-(void)MZLoginButtonBlock:(TouchedMZLoginButtonBlock)touchedCountDownButtonBlock
{
    _touchedLoginButtonBlock = [_touchedLoginButtonBlock copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(MZLoginButton *)sender{
    if (_touchedLoginButtonBlock) {
        _touchedLoginButtonBlock(sender, sender.tag);
    }
}

#pragma mark - count down method

-(void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];

    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;


    if (_second< 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            [self setTitle:_countDownChanging(self,_second) forState:UIControlStateNormal];
            [self setTitle:_countDownChanging(self,_second) forState:UIControlStateDisabled];

        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];

        }
    }
}

-(void)stopCountDown
{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateNormal];
                    [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateDisabled];

                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];

                }
            }
        }
    }
}

#pragma mark  -  block

-(void)countDownChanging:(CountDownChanging)countDownChanging
{

}

-(void)countDownFinished:(CountDownFinished)countDownFinished
{

}




@end
