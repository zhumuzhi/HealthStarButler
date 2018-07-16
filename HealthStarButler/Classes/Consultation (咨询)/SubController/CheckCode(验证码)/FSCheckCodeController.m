//
//  FSCheckCodeController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/16.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCheckCodeController.h"
#import "FSCheckCodeView.h"

@interface FSCheckCodeController ()<FSCheckCodeViewDelegate>

@property (nonatomic,strong) FSCheckCodeView *checkCodeView;//图形验证码

@end

@implementation FSCheckCodeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.checkCodeView];
}

- (FSCheckCodeView *)checkCodeView {
    if (!_checkCodeView) {
        _checkCodeView = [[FSCheckCodeView alloc]initWithFrame:CGRectMake(kScreenWidth/2-50.0, kScreenHeight/2-20.0, 100.0, 40.0)];
        [_checkCodeView setCodeStr:@"S3G9"];//设置验证码
        [_checkCodeView setDelegate:self];
    }
    return _checkCodeView;
}

#pragma mark - FSCheckCodeViewDelegate
- (void)didTapFSCheckCodeView:(FSCheckCodeView *)checkCodeView
{
//    NSLog(@"点击了图形验证码");
//    NSString *codeStr = [NSString arc4randomStringWithCount:4 minCount:3];
//    [self.checkCodeView setCodeStr:codeStr];

    [self.checkCodeView setCodeStr:@"MJ6H"];

}



@end
