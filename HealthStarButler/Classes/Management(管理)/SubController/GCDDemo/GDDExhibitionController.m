//
//  GDDExhibitionController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "GDDExhibitionController.h"

@interface GDDExhibitionController ()

@property (weak, nonatomic) IBOutlet UIButton *hideImageViewButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GDDExhibitionController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configNavigation];
    
    self.hideImageViewButton.hidden = YES;
}

#pragma mark - config UI
- (void)configNavigation {
    self.navigationItem.title = @"GCD展示";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - ButtonClick

/** 串行同步 */
- (IBAction)syncSerialAction:(id)sender {
    [self syncSerial];
}

/** 串行异步 */
- (IBAction)asyncSerialAction:(id)sender {
    [self asyncSerial];
}
/** 并发同步 */
- (IBAction)syncConcurrentAvtion:(id)sender {
    [self syncConcurrent];
}
/** 并发异步 */
- (IBAction)asyncCOncurrent:(id)sender {
    [self asyncConcurrent];
}
/** 主队列同步*/
- (IBAction)syncMainAction:(id)sender {
    [self syncMain];
}
/** 主队列异步 */
- (IBAction)asyncMainAction:(id)sender {
    [self asyncMain];
}

/** 线程通信 */
- (IBAction)communicationAction:(id)sender {
    [self communication];
}

/** 栅栏 */
- (IBAction)barrierAction:(id)sender {
    [self barrier];
}



/**  */
- (IBAction)applyAction:(id)sender {
}

/** 组 */
- (IBAction)groupAction:(id)sender {
}

/** 隐藏图片 */
- (IBAction)hideImageView:(id)sender {
    self.imageView.hidden = YES;
    self.hideImageViewButton.hidden = YES;
}

#pragma mark - GCD Method

static NSTimeInterval interval = 1;

#pragma mark 同步并发
/**  同步并发 同步执行(sync) + 并发队列(concurrent)*/
- (void)syncConcurrent {
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"syncConcurrent---begin");
    // 创建队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    // 追加任务1
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<2; ++i) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务1线程---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    // 追加任务2
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<2; ++i) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务2线程---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    // 追加任务3
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<2; ++i) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务3线程---%@", [NSThread currentThread]); // 打印当前线程
        }
        
    });
    NSLog(@"syncConcurrent---end");
}
#pragma mark 异步并发
/** 异步并发 异步执行(async) + 并发队列(concurrent) */
- (void)asyncConcurrent {
    
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"asyncConcurrent---begin");
    // 创建队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    // 异步执行
    // 追加任务1
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务1线程---%@", [NSThread currentThread]);
        }
    });
    // 追加任务2
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务2线程---%@", [NSThread currentThread]);
        }
    });
    // 追加任务3
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务3线程---%@", [NSThread currentThread]);
        }
    });
    NSLog(@"asyncConcurrent---end");
}

#pragma mark 同步串行
/** 同步串行 同步执行(sync) + 串行队列(serial) */
- (void)syncSerial {
    
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"syncSerial---begin");
    // 创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("syncSerial", DISPATCH_QUEUE_SERIAL);
    // 同步执行
    // 追加任务任务1
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务1线程---%@", [NSThread currentThread]);
        }
    });
    // 任务2
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务2线程---%@", [NSThread currentThread]);
        }
    });
    // 任务3
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务3线程---%@", [NSThread currentThread]);
        }
    });
    NSLog(@"syncSerial---end");
}

#pragma mark 异步串行
/** 异步串行 异步执行(async) + 串行队列(serial) */
- (void)asyncSerial {
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"asyncSerial---begin");
    // 创建队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 异步执行
    // 任务1
    dispatch_async(serialQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务1线程---%@", [NSThread currentThread]); //打印线程
        }
    });
    
    // 任务2
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务2线程---%@", [NSThread currentThread]);
        }
    });
    // 任务3
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务3线程---%@", [NSThread currentThread]);
        }
        
    });
    NSLog(@"asyncSerial---end");
}

#pragma mark 同步主队列
/** 同步主队列 同步执行(sync) + 主队列(mainQueue)即串行队列 */
- (void)syncMain {
    
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"syncMain---begin");
    
    // 获取队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 同步执行
    // 任务1
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval]; //耗时操作
            NSLog(@"任务1线程---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    // 任务2
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务2线程---%@", [NSThread currentThread]);
        }
    });
    // 任务3
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务2线程---%@", [NSThread currentThread]);
        }
    });
    NSLog(@"syncMain---end");
}

#pragma mark 异步主队列
/** 异步主队列 异步执行(async) + 主队列(mainQueue)即串行队列 */
- (void)asyncMain {
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"asyncMian---begin");
    // 获取队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 异步执行
    // 任务1
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务1线程---%@", [NSThread currentThread]); // 打印线程
        }
    });
    // 任务2
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务2线程---%@", [NSThread currentThread]);
        }
    });
    // 任务3
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:interval];
            NSLog(@"任务3线程---%@", [NSThread currentThread]);
        }
    });
    NSLog(@"asyncMian---end");
}

#pragma mark 线程间通信
/** 线程间通信 */
- (void)communication {
    // 获取全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(globalQueue, ^{
        // 异步追加任务
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        // 耗时操作放在这里，例如下载图片。（运用线程休眠两秒来模拟耗时操作）
        [NSThread sleepForTimeInterval:interval];
        NSString *picURLStr = @"http://qimg.hxnews.com/2018/0428/1524871671797.jpg";
        NSURL *picURL = [NSURL URLWithString:picURLStr];
        NSData *picData = [NSData dataWithContentsOfURL:picURL];
        UIImage *image = [UIImage imageWithData:picData];
        
        // 回到主线程
        dispatch_async(mainQueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:interval];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
            // 在主线程上添加图片
            self.imageView.image = image;
            self.imageView.hidden = NO;
            self.hideImageViewButton.hidden = NO;
        });
    });
}

#pragma mark 栅栏
/** 栅栏方法 dispatch_barrier_async */
- (void)barrier {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("someconcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务1---%@",[NSThread currentThread]); // 打印当前线程
        }
    });
    
    dispatch_async(concurrentQueue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:interval]; // 模拟耗时操作
            NSLog(@"任务2---%@",[NSThread currentThread]); // 打印当前线程
        }
    });
    
    dispatch_barrier_async(concurrentQueue, ^{
        // 追加任务 barrier
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
        }
    });
    
    dispatch_async(concurrentQueue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"任务3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(concurrentQueue, ^{
        // 追加任务4
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"任务4---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
}

#pragma mark 延时方法
- (void)after {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
}





@end
