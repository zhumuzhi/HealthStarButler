//
//  NSOperationDemoController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/30.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "NSOperationDemoController.h"

@interface NSOperationDemoController ()

@end

@implementation NSOperationDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)testNSInvocationOperation {
    //创建NSInvocatioOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
    
    //开始执行操作
    [invocationOperation start];
    
}


- (void)invocationOperation {
    
    NSLog(@"NSInvocationOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    
}



@end
