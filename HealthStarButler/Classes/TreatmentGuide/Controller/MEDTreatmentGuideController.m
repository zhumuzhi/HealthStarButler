//
//  MEDTreatmentGuideController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  智能导诊

#import "MEDTreatmentGuideController.h"

#import "MEDGuidanceVC.h"
#import "RFQuiltLayout.h"

#import "MEDSymptomCell.h"
#import "MEDSymptomTitleCell.h"
#import "MEDAllBodyModel.h"
#import "MEDTwoTableView.h"

#import "MEDGuidanceTagView.h"

#define Margin 5
#define LeftTableHW 80
#define symptomBackViewH 30
#define collectionPad 30


@interface MEDTreatmentGuideController ()<MEDGuidanceTagDelegate>
{
    UITableView *_tableView;
    UIView *_symptomBackView;
    CGFloat _max_X, _max_Y, _max_width;
    CGFloat _maxHeight;
}
//@property (strong, nonatomic)  UICollectionView *collectionView;
@property (nonatomic) NSMutableArray* dataArray;
@property (nonatomic) float height;

@property (nonatomic, strong) MEDGuidanceTagView *tagListView;
@property (assign, nonatomic) TagStateType     tagStateType; //标签的模式状态（显示、选择、编辑）

@end

@implementation MEDTreatmentGuideController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"选症状";
    self.view.backgroundColor = MEDGrayColor(243);
    [self configNavigation];


    [self initTwoTableView];
    [_dataArray removeAllObjects];

    [self initModel];
    [self initConlectionView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCellText:) name:@"selectSymptomCell" object:nil];
}

- (void)reInitIntellectGuidance {
    for (UIView *subview in self.view.subviews) {
        [subview removeFromSuperview];
    }
    _height = 20;
    [self initTwoTableView];
    [_dataArray removeAllObjects];
    [self initModel];
    [self initConlectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self reInitIntellectGuidance];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:(BOOL)animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 添加cell 刷新SymptomCollection - 通知触发
- (void)addCellText:(NSNotification*) notification
{
    if(_dataArray.count>10) {
        [self showAleart];
    }
    id obj = [notification object];
    if (obj!=nil) {
        NSMutableArray *arr = (NSMutableArray*)obj;
        _dataArray = arr;
    }
//    if (_tagListView.frame.size.height<=30) {
//        _height = 56;
//    } else {
//        if ((_maxHeight)>=30) {
//            _height = (_maxHeight+28) ;
//        }
//    }
//
//    if (_dataArray.count == 0) {
//        _height = 20;
//    }
//    [_tagListView reloadData:_dataArray];
    [_tagListView removeFromSuperview];
    [self initConlectionView];
}

#pragma mark - configUI

#pragma mark  CofigNavigation
- (void)configNavigation {
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 44, 44);
    //[addButton.titleLabel setFont:sysFont(14)];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];

//    [commitButton addClickAction:@selector(commitClick) WithTarget:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:commitButton];
}

#pragma mark ConfigChooseCollectionView
- (void)initConlectionView
{
    CGFloat collectionY = Navigation_Height+Margin;

    self.tagStateType = TagStateEdit; //编辑模式

    _tagListView = [[MEDGuidanceTagView alloc] initWithFrame:CGRectMake(0, collectionY, SCREEN_WIDTH, 43)];

    self.tagListView.delegate = self;
    [self.tagListView creatUI:_dataArray];   //传入Tag数组初始化界面
    self.tagListView.tagArrkey = @"name";   //如果传的是字典的话，那么key为必传得
    self.tagListView.is_can_addTag = NO;    //如果是要有最后一个按钮是添加按钮的情况，那么为Yes
    self.tagListView.tagCornerRadius = 10;  //标签圆角的大小，默认10
    self.tagListView.tagStateType = self.tagStateType;  //标签模式，默认显示模式
    //刷新数据
    [self.tagListView reloadData:_dataArray andTime:0];

    [self.view addSubview:_tagListView];

    _twoTable.frame = CGRectMake(0, CGRectGetMaxY(_tagListView.frame)+Margin, SCREEN_WIDTH, SCREEN_HEIGHT- Navigation_Height- CGRectGetMaxY(_tagListView.frame)-Margin);

    _twoTable.leftTablew.frame = CGRectMake(0, 0, LeftTableHW , SCREEN_HEIGHT- Navigation_Height- CGRectGetHeight(_tagListView.frame)-TabBar_Height-CELL_HEIGHT);

    _twoTable.rightTablew.frame = CGRectMake(CGRectGetMaxX(_twoTable.leftTablew.frame),0,SCREEN_WIDTH-_twoTable.leftTablew.frame.size.width,SCREEN_HEIGHT- Navigation_Height- CGRectGetHeight(_tagListView.frame)-TabBar_Height-CELL_HEIGHT);
    //此处将 twoTable 提到最前方
    [self.view bringSubviewToFront:_twoTable];
}

- (void)initTwoTableView
{
    _twoTable = [[MEDTwoTableView alloc] initWithFrame:CGRectMake(0, Navigation_Height+CGRectGetHeight(_tagListView.frame), SCREEN_WIDTH, SCREEN_HEIGHT) WithData:nil withSelectIndex:^(NSInteger left, NSInteger right,NSString *str) {
        //  NSLog(@"点击的 菜单%@",info.meunName);
    }];
    [self.view addSubview:_twoTable];
}


#pragma mark- TagView 代理
//标签的点击事件
-(void)tagList:(MEDGuidanceTagView *)taglist clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.tagStateType == TagStateEdit) {//删除Tag
        [self deleteTagRequest:buttonIndex];
    }else if (self.tagStateType == TagStateSelect){ //选择tag
        NSLog(@"选中类型的tag");
    }
}

#pragma mark- 删除Tag
-(void)deleteTagRequest:(NSInteger)index{
    NSLog(@"tag代理点击事件，点击第%ld个",index);
    if (self.dataArray.count>0) {
        NSString *removeCellStr = [self.dataArray objectAtIndex:index];
        [self.dataArray removeObjectAtIndex:index];
        [self.tagListView reloadData:self.dataArray andTime:0];
        //刷新界面，删除选中View与table，根据dataArray数据重构页面
        [self addCellText:nil];
        // 通知Table根据疾病str移除对应选中cell
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSymptomCell" object:removeCellStr];
    }
}

#pragma mark - commitRequest

- (void)commitClick
{
    NSLog(@"提交数据");

    [MEDProgressHUD showHUDStatusTitle:@""];

    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];

    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [parameter setValue:userModel.uid forKey:@"user_id"];
    }
    [parameter setObject:[self arrayChangeString] forKey:S_ID];
    NSString *baseUrl = MED_DOMAIN_REQUEST;
    //NSLog(@"智能导诊信息的参数:%@",parameter);
    NSString *sid = parameter[@"sid"];
    if (sid.length == 0) {
        [MEDProgressHUD dismissHUDErrorTitle:@"您还未选择任何症状"];
        return;
    }

    [MEDDataRequest POST:MED_INTELLECT baseURL:baseUrl params:parameter success:^(NSURLSessionDataTask *task, id responseObject) {

        [MEDProgressHUD dismissHUD];
        NSLog(@"%@",responseObject[@"data"]);
        NSArray *parameterArray = @[responseObject[@"data"],self->_dataArray];

        //        [[[NSNotificationCenter defaultCenter]postNotificationName:@"pushToGuidanceSuggest" object:parameterArray];

        [self pushToGuidanceSuggest:parameterArray];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MEDProgressHUD dismissHUDErrorTitle:@"智能导诊网络请求失败"];
    }];

}

//选症状点击提交跳转方法
- (void)pushToGuidanceSuggest:(NSArray *)parameterArray {
    NSArray *array = parameterArray;
    MEDGuidanceVC *guidance = [[MEDGuidanceVC alloc]init];
    guidance.dataArray = [array firstObject];
    guidance.symptomArray = [array lastObject];
    guidance.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:guidance animated:YES];
}

#pragma mark - 提示弹窗
- (void)showAleart {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"导诊提示"message:@"您不适症状过多，建议立即就医" preferredStyle:UIAlertControllerStyleAlert ];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Model

- (void)initModel
{
    MEDAllBodyModel *allBodyModel = [MEDAllBodyModel sharedAllBodyModel];
    allBodyModel.faRe = NO;
    allBodyModel.shiMian = NO;
    allBodyModel.chouChu = NO;
    allBodyModel.shiYuBuZhen = NO;
    allBodyModel.faLiXuHan = NO;
    allBodyModel.huangDan = NO;

    MEDHeadModel *headModel = [MEDHeadModel sharedHeadModel];
    headModel.touJingShuiZhong = NO;
    headModel.touTong = NO;
    headModel.keSuKeTan = NO;
    headModel.xuanYun = NO;
    headModel.keXue = NO;
    headModel.yunJue = NO;
    headModel.faGan = NO;

    MEDChestModel *chestModel = [MEDChestModel sharedChestModel];
    chestModel.xiongTong = NO;
    chestModel.xiongBupiFuNianMoChuXue = NO;
    chestModel.huxiKunNan = NO;
    chestModel.ouXue = NO;
    chestModel.xinJi = NO;
    chestModel.xiongBuZhongKuai = NO;
    chestModel.eXinOuTu = NO;
    chestModel.yaoBeiTeng = NO;

    MEDBellyModel *bellyModel = [MEDBellyModel sharedBellyModel];
    bellyModel.bianXue = NO;
    bellyModel.xueNiao = NO;
    bellyModel.fuTeng = NO;
    bellyModel.niaoPinNiaoJi = NO;
    bellyModel.fuXie = NO;
    bellyModel.shaoNiaoWuNiao = NO;
    bellyModel.bianMi = NO;
    bellyModel.duoNiao = NO;
    bellyModel.fuBuZhongKuai = NO;

    MEDLimbsModel *limbsModel = [MEDLimbsModel sharedLimbsModel];
    limbsModel.guanJieTeng = NO;
    limbsModel.SiZhiPiFuNianMoChuXue = NO;
    limbsModel.siZhishuiZhong = NO;
    limbsModel.siZhiZhongKuai = NO;
    limbsModel.siZhiTengTong = NO;
    limbsModel.ganJueXiaoTui = NO;

    [_dataArray removeAllObjects];
    [_twoTable.rightTablew reloadData];
    [_twoTable.leftTablew reloadData];
}

- (NSString*)arrayChangeString
{
    NSString *str;
    NSMutableArray *tempArr = [NSMutableArray array];

    for (NSInteger i = 0; i < _dataArray.count; i++) {
        if ([_dataArray[i] isEqualToString:@"发热"]) {
            [tempArr addObject:@(faRe)];
        } else if ([_dataArray[i] isEqualToString:@"抽搐惊厥"]){
            [tempArr addObject:@(chouChu)];
        } else if ([_dataArray[i] isEqualToString:@"乏力虚汗"]){
            [tempArr addObject:@(faLiXuHan)];
        } else if ([_dataArray[i] isEqualToString:@"失眠"]){
            [tempArr addObject:@(shiMian)];
        } else if ([_dataArray[i] isEqualToString:@"食欲不振"]){
            [tempArr addObject:@(shiYuBuZhen)];
        } else if ([_dataArray[i] isEqualToString:@"黄疸"]){
            [tempArr addObject:@(huangDan)];
        } else if ([_dataArray[i] isEqualToString:@"水肿"]){
            [tempArr addObject:@(touJingShuiZhong)];
        } else if ([_dataArray[i] isEqualToString:@"头疼"]){
            [tempArr addObject:@(touTong)];
        } else if ([_dataArray[i] isEqualToString:@"咳嗽咳痰"]){
            [tempArr addObject:@(keSuKeTan)];
        } else if ([_dataArray[i] isEqualToString:@"眩晕"]){
            [tempArr addObject:@(xuanYun)];
        } else if ([_dataArray[i] isEqualToString:@"咳血"]){
            [tempArr addObject:@(keXue)];
        } else if ([_dataArray[i] isEqualToString:@"晕厥"]){
            [tempArr addObject:@(yunJue)];
        } else if ([_dataArray[i] isEqualToString:@"发绀"]){
            [tempArr addObject:@(faGan)];
        } else if ([_dataArray[i] isEqualToString:@"胸疼"]){
            [tempArr addObject:@(xiongTong)];
        } else if ([_dataArray[i] isEqualToString:@"皮肤黏膜出血"]){
            [tempArr addObject:@(xiongBupiFuNianMoChuXue)];
        } else if ([_dataArray[i] isEqualToString:@"呼吸困难"]){
            [tempArr addObject:@(huxiKunNan)];
        } else if ([_dataArray[i] isEqualToString:@"呕血"]){
            [tempArr addObject:@(ouXue)];
        } else if ([_dataArray[i] isEqualToString:@"心悸"]){
            [tempArr addObject:@(xinJi)];
        } else if ([_dataArray[i] isEqualToString:@"肿块"]){
            [tempArr addObject:@(xiongBuZhongKuai)];
        } else if ([_dataArray[i] isEqualToString:@"恶心呕吐"]){
            [tempArr addObject:@(eXinOuTu)];
        } else if ([_dataArray[i] isEqualToString:@"腰背疼"]){
            [tempArr addObject:@(yaoBeiTeng)];
        } else if ([_dataArray[i] isEqualToString:@"便血"]){
            [tempArr addObject:@(bianXue)];
        } else if ([_dataArray[i] isEqualToString:@"血尿"]){
            [tempArr addObject:@(xueNiao)];
        } else if ([_dataArray[i] isEqualToString:@"腹疼"]){
            [tempArr addObject:@(fuTeng)];
        } else if ([_dataArray[i] isEqualToString:@"尿频、尿急与尿痛"]){
            [tempArr addObject:@(niaoPinNiaoJi)];
        } else if ([_dataArray[i] isEqualToString:@"腹泻"]){
            [tempArr addObject:@(fuXie)];
        } else if ([_dataArray[i] isEqualToString:@"少尿、无尿"]){
            [tempArr addObject:@(shaoNiaoWuNiao)];
        } else if ([_dataArray[i] isEqualToString:@"便秘"]){
            [tempArr addObject:@(bianMi)];
        } else if ([_dataArray[i] isEqualToString:@"多尿"]){
            [tempArr addObject:@(duoNiao)];
        } else if ([_dataArray[i] isEqualToString:@"肿块"]){
            [tempArr addObject:@(fuBuZhongKuai)];
        } else if ([_dataArray[i] isEqualToString:@"关节疼"]){
            [tempArr addObject:@(guanJieTeng)];
        } else if ([_dataArray[i] isEqualToString:@"皮肤黏膜出血"]){
            [tempArr addObject:@(SiZhiPiFuNianMoChuXue)];
        } else if ([_dataArray[i] isEqualToString:@"水肿"]){
            [tempArr addObject:@(siZhishuiZhong)];
        } else if ([_dataArray[i] isEqualToString:@"肿块"]){
            [tempArr addObject:@(siZhiZhongKuai)];
        } else if ([_dataArray[i] isEqualToString:@"疼痛"]){
            [tempArr addObject:@(siZhiTengTong)];
        } else if ([_dataArray[i] isEqualToString:@"感觉消退"]){
            [tempArr addObject:@(ganJueXiaoTui)];
        }
    }

    str = [tempArr componentsJoinedByString:@","];

    return str;
}



@end
