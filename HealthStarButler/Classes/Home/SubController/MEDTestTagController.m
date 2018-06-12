//
//  MEDTestTagController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDTestTagController.h"

#import "MEDGuidanceTagView.h"

@interface MEDTestTagController () <MEDGuidanceTagDelegate>

@property (strong, nonatomic) MEDGuidanceTagView    *tagList;     //自定义标签Viwe
@property (strong, nonatomic) NSMutableArray   *tagArray;    //Tag数组
@property (assign, nonatomic) TagStateType     tagStateType; //标签的模式状态（显示、选择、编辑）

@end

@implementation MEDTestTagController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];

    [self creatUI];

}

-(void)creatUI{
    //Tag数据
//    _tagArray = [NSMutableArray arrayWithObjects:@"抽搐惊厥",@"食欲不振",@"咳嗽咳痰",@"尿频、尿急与尿痛",@"少尿、无尿",@"皮肤黏膜出血",@"感觉消退",@"恶心呕吐", nil];
    _tagArray = [NSMutableArray array];
//    _tagArray = [NSMutableArray arrayWithObjects:@"抽搐惊厥", nil];
    self.tagStateType = TagStateEdit; //编辑模式

    //TagView
    self.tagList = [[MEDGuidanceTagView alloc] initWithFrame:CGRectMake(0, Navigation_Height+5, SCREEN_WIDTH, 100)];
    self.tagList.delegate = self;
    [self.tagList creatUI:_tagArray];   //传入Tag数组初始化界面
    [self.view addSubview:self.tagList];

    //以下属性是可选的
    self.tagList.tagArrkey = @"name";   //如果传的是字典的话，那么key为必传得
    self.tagList.is_can_addTag = NO;    //如果是要有最后一个按钮是添加按钮的情况，那么为Yes
    self.tagList.tagCornerRadius = 12;  //标签圆角的大小，默认10
    self.tagList.tagStateType = self.tagStateType;  //标签模式，默认显示模式

    //刷新数据
    [self.tagList reloadData:_tagArray andTime:0];
}

#pragma mark- TagView 代理

//标签的点击事件
-(void)tagList:(MEDGuidanceTagView *)taglist clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (self.tagStateType == TagStateEdit) {
        //删除Tag
        [self deleteTagRequest:buttonIndex];
    }else if (self.tagStateType == TagStateSelect){
        //选择tag
    }
}

-(void)tagList:(MEDGuidanceTagView *)taglist heightForView:(float)listHeight{
    //这里设置TagView的高度
}

#pragma mark- 删除Tag
-(void)deleteTagRequest:(NSInteger)index{

    NSLog(@"代理事件，点击第%ld个",index);
    [self.tagArray removeObjectAtIndex:index];
    [self.tagList reloadData:self.tagArray andTime:0];
}
@end
