//
//  MEDBaseViewController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDBaseViewController.h"

@interface MEDBaseViewController ()

@end

@implementation MEDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MEDGrayColor(243);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setupPersonNavigationItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"nav_mine"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"nav_mine"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton addTarget:self action:@selector(clickMineButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)clickMineButton {
    
    MEDMineController *mimeController = [[MEDMineController alloc] init];
    [self.navigationController pushViewController:mimeController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    if (!jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
