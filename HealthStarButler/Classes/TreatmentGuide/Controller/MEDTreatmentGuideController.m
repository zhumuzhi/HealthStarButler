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


#define Margin 5
#define LeftTableHW 80
#define symptomBackViewH 30
#define collectionPad 30


@interface MEDTreatmentGuideController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RFQuiltLayoutDelegate>
{
    UITableView *_tableView;
    UIView *_symptomBackView;
    CGFloat _max_X, _max_Y, _max_width;
    CGFloat _maxHeight;
}
@property (strong, nonatomic)  UICollectionView *collectionView;
@property (nonatomic) NSMutableArray* dataArray;
@property (nonatomic) float height;

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
    if (_collectionView.frame.size.height<=30) {
        _height = 56;
    } else {
        if ((_maxHeight)>=30) {
            _height = (_maxHeight+28) ;
        }
    }

    if (_dataArray.count == 0) {
        _height = 20;
    }
    [_collectionView removeFromSuperview];
    //    _maxHeight = 0;
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

#pragma mark InitSymptomUI
- (void)initSymptomUI
{
    UILabel *symptomTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, Margin, 100, 21)];
    symptomTitle.text = @"您的症状:";
    symptomTitle.textColor = [UIColor blackColor];
    symptomTitle.textAlignment = NSTextAlignmentLeft;
    [_symptomBackView addSubview:symptomTitle];

    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, (CGRectGetMaxY(symptomTitle.frame) + Margin/2), SCREEN_WIDTH, 0.5)];
    line.backgroundColor = MEDGrayColor(242);
    [_symptomBackView addSubview:line];
}

#pragma mark ConfigChooseCollectionView
- (void)initConlectionView
{
    //    [_symptomBackView removeFromSuperview];
    ////    if (_dataArray.count != 0) {
    //    _symptomBackView = [[UIView alloc]init];
    //    _symptomBackView.frame = CGRectMake(0,Navigation_Height+Margin, SCREEN_WIDTH, symptomBackViewH);
    //    _symptomBackView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:_symptomBackView];
    //    [self initSymptomUI];

    RFQuiltLayout *layout = [[RFQuiltLayout alloc]init];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(20, 28);
    layout.delegate = self;

    //    CGFloat collectionY = CGRectGetMaxY(_symptomBackView.frame);
    CGFloat collectionY = Navigation_Height+Margin;

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, collectionY, self.view.frame.size.width, 0) collectionViewLayout:layout];

    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

    _collectionView.frame = CGRectMake(0, collectionY, self.view.frame.size.width, _height+collectionPad);
    [_collectionView reloadData];
    //    _twoTable.frame = CGRectMake(0, Navigation_Height+CGRectGetHeight(_collectionView.frame)+ CELL_HEIGHT+20, SCREEN_WIDTH, SCREEN_HEIGHT- Navigation_Height- CGRectGetHeight(_collectionView.frame)-TabBar_Height+CELL_HEIGHT-CELL_HEIGHT);
    _twoTable.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+Margin, SCREEN_WIDTH, SCREEN_HEIGHT- Navigation_Height- CGRectGetMaxY(_collectionView.frame)-Margin);

    _twoTable.leftTablew.frame = CGRectMake(0, 0, LeftTableHW , SCREEN_HEIGHT- Navigation_Height- CGRectGetHeight(_collectionView.frame)-TabBar_Height-CELL_HEIGHT);

    _twoTable.rightTablew.frame = CGRectMake(CGRectGetMaxX(_twoTable.leftTablew.frame),0,SCREEN_WIDTH-_twoTable.leftTablew.frame.size.width,SCREEN_HEIGHT- Navigation_Height- CGRectGetHeight(_collectionView.frame)-TabBar_Height-CELL_HEIGHT);
    //此处将 twoTable 提到最前方
    [self.view bringSubviewToFront:_twoTable];
}

- (void)initTwoTableView
{
    _twoTable = [[MEDTwoTableView alloc] initWithFrame:CGRectMake(0, Navigation_Height+CGRectGetHeight(_collectionView.frame), SCREEN_WIDTH, SCREEN_HEIGHT) WithData:nil withSelectIndex:^(NSInteger left, NSInteger right,NSString *str) {
        //  NSLog(@"点击的 菜单%@",info.meunName);
    }];
    [self.view addSubview:_twoTable];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    [_collectionView registerClass:[MEDSymptomCell class] forCellWithReuseIdentifier:identifier];

    [_collectionView registerNib:[UINib nibWithNibName:@"MEDSymptomTitleCell" bundle:nil]  forCellWithReuseIdentifier:@"MEDSymptomTitleCell"];

    if (indexPath.row == 0) {
        MEDSymptomTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MEDSymptomTitleCell" forIndexPath:indexPath];
        return cell;
    }else {

        MEDSymptomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.titlesLab.textColor = [UIColor blackColor];

        cell.titlesLab.text = [_dataArray objectAtIndex:indexPath.row];
        cell.delimgv.image = [UIImage imageNamed:@"deletImg"];
        cell.tag = indexPath.row;

        _maxHeight = cell.frame.origin.y>_maxHeight?cell.frame.origin.y:0;
        _max_Y = cell.frame.origin.y+30;

        UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removebtnClick:)];
        tapPress.numberOfTapsRequired = 1;
        cell.delimgv.userInteractionEnabled = YES;
        [cell.delimgv addGestureRecognizer:tapPress];
        return cell;
    }

}

#pragma mark RemoveChooseItem - 发送移除通知
-(void)removebtnClick:(UITapGestureRecognizer *)gestureRecognizer
{
    MEDSymptomCell *cell = (MEDSymptomCell *)gestureRecognizer.view;
    if (self.dataArray.count>0) {
        NSString *removeCellStr = [self.dataArray objectAtIndex:cell.tag];
        [self.dataArray removeObjectAtIndex:cell.tag];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSymptomCell" object:removeCellStr];
        [self addCellText:nil]; //刷新
    }
}

#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [_dataArray objectAtIndex:indexPath.row];
    NSString *wordStr = [NSString stringWithFormat:@".%@.",str];
    NSInteger w = wordStr.length;
    return CGSizeMake(w, 1);
}

- (UIEdgeInsets)insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(2, 2, 2, 2);
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
        NSArray *parameterArray = @[responseObject[@"data"],_dataArray];

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
