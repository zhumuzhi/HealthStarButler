//
//  MEDSelectionListController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDSelectionListController.h"

#import "MEDSingleChooseController.h"
#import "MEDMultiSelectController.h"

#import "MEDNormalChooseController.h"
#import "MEDCollectionChooseController.h"

@interface MEDSelectionListController ()

@end

@implementation MEDSelectionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择列表";

    [self setupUI];
}

//MARK:- UI
- (void)setupUI {
    /** 使用Masory 好像不太适用于此类页面 */
    UIButton *tableSingleBtn = [self createBtnTitle:@"Table单选" Selector:@selector(typeButtonClick:)];
    tableSingleBtn.tag = 0;
    [self.view addSubview:tableSingleBtn];
    [tableSingleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *tableMultipleBtn = [self createBtnTitle:@"Table多选" Selector:@selector(typeButtonClick:)];
    tableMultipleBtn.tag = 1;
    [self.view addSubview:tableMultipleBtn];
    [tableMultipleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableSingleBtn.mas_left);
        make.right.equalTo(tableSingleBtn.mas_right);
        make.top.equalTo(tableSingleBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *tableSwitch = [self createBtnTitle:@"选择切换" Selector:@selector(typeButtonClick:)];
    tableSwitch.tag = 2;
    [self.view addSubview:tableSwitch];
    [tableSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableMultipleBtn.mas_left);
        make.right.equalTo(tableMultipleBtn.mas_right);
        make.top.equalTo(tableMultipleBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *collectionSingle = [self createBtnTitle:@"Collection单选" Selector:@selector(typeButtonClick:)];
    collectionSingle.tag = 3;
    [self.view addSubview:collectionSingle];
    [collectionSingle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableSwitch.mas_left);
        make.right.equalTo(tableSwitch.mas_right);
        make.top.equalTo(tableSwitch.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
}

/** 创建按钮 */
- (UIButton *)createBtnTitle:(NSString *)title Selector:(SEL)selector {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = MEDCommonBlue;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//MARK:- Event

- (void)typeButtonClick:(UIButton *)button {
    
    switch (button.tag) {
        case 0:
        {
            MEDSingleChooseController *single = [[MEDSingleChooseController alloc] init];
            [self.navigationController pushViewController:single animated:YES];
        }
            break;
        case 1:
        {
            MEDMultiSelectController *multiple = [[MEDMultiSelectController alloc] init];
            [self.navigationController pushViewController:multiple animated:YES];
        }
            break;
        case 2:
        {
            MEDNormalChooseController *single = [[MEDNormalChooseController alloc] init];
            [self.navigationController pushViewController:single animated:YES];
        }
            break;
        case 3:
        {
            MEDCollectionChooseController *CSingle = [[MEDCollectionChooseController alloc] init];
            [self.navigationController pushViewController:CSingle animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
