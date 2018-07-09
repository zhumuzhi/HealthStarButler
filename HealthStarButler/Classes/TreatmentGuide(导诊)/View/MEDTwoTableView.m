//
//  MEDTwoTableView.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/11.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDTwoTableView.h"

#import "MEDLeftTableViewCell.h"
#import "MEDRightTableViewCell.h"

#import "MEDAllBodyModel.h"

#define LEFT_TABLE      (@"leftTable")
#define RIGHT_TABLE     (@"rightTable")

#define LeftTableHW 80

@implementation MEDTwoTableView
{
    NSInteger _rightCellNum;
    NSMutableArray *_rightArray;
    NSMutableArray *_selectRight;
    BOOL _isShouRight;
    
    NSMutableArray *selectedCell;
    
    MEDAllBodyModel *_allBodyModel;
    MEDHeadModel *_headModel;
    MEDChestModel *_chestModel;
    MEDBellyModel *_bellyModel;
    MEDLimbsModel *_limbsModel;
}

-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    self=[super initWithFrame:frame];
    if (self) {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCellText:) name:@"removeSymptomCell" object:nil];

        _block = selectIndex;
        //左边选中文字颜色
        self.leftSelectColor=[UIColor blackColor];
        self.leftSelectBgColor=[UIColor whiteColor];
//        _leftSelectIndex = 0;
        _rightSelectIndex = 100;
        
        _rightCellNum = 6;
        
//        _rightArray = [NSMutableArray arrayWithObjects:@"发热", @"失眠", @"抽搐惊厥", @"食欲不振", @"乏力虚汗", @"黄疸", nil];
        
        switch (_leftSelectIndex) {
            case 0:
            {
                _rightArray = [NSMutableArray arrayWithObjects:@"发热", @"失眠", @"抽搐惊厥", @"食欲不振", @"乏力虚汗", @"黄疸", nil];
            }
                break;

            case 1:
            {
                _rightArray = [NSMutableArray arrayWithObjects:@"水肿", @"头疼", @"咳嗽咳痰", @"眩晕", @"咳血", @"晕厥", @"发绀" , nil];
            }
                break;

            case 2:
            {
                _rightArray = [NSMutableArray arrayWithObjects:@"胸疼", @"皮肤黏膜出血", @"呼吸困难", @"呕血", @"心悸", @"肿块", @"恶心呕吐", @"腰背疼", nil];
            }
                break;

            case 3:
            {
                _rightArray = [NSMutableArray arrayWithObjects: @"便血", @"血尿", @"腹疼", @"尿频、尿急与尿痛", @"腹泻", @"少尿、无尿", @"便秘", @"多尿", @"肿块", nil];
            }
                break;

            case 4:
            {
                _rightArray = [NSMutableArray arrayWithObjects:@"关节疼", @"皮肤黏膜出血", @"水肿", @"肿块", @"疼痛", @"感觉消退", nil];
            }
                break;

            default:
                break;
        }

        
        _selectRight = [NSMutableArray array];
        selectedCell = [NSMutableArray array];
        
        /**
         左边的视图
         */
        self.leftTablew = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LeftTableHW, frame.size.height-kTabBarHeight-kNavigationHeight)];
        //self.leftTablew.scrollEnabled = NO;
        
        self.leftTablew.showsVerticalScrollIndicator = NO;
        self.leftTablew.showsHorizontalScrollIndicator = NO;
        
        self.leftTablew.dataSource = self;
        self.leftTablew.delegate = self;
        
        //self.leftTablew.tableFooterView = [[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor = MEDGrayColor(243);//self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins = UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset = UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor = MEDGrayColor(232);
        
        UIView *view = [UIView new];
        view.height = 0.1;
        self.leftTablew.tableFooterView = view;
        
        /**
         右边的视图
         */
        //self.rightTablew = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftTablew.frame),0,kScreenWidth-kLeftWidth,frame.size.height-TabBar_HEIGHT-NavigationBar_HEIGHT)];
        self.rightTablew = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftTablew.frame),0,kScreenWidth-CGRectGetMaxX(_leftTablew.frame),frame.size.height-kTabBarHeight-kNavigationHeight)];
        
        self.rightTablew.separatorStyle = UITableViewCellSelectionStyleNone;
        self.rightTablew.dataSource = self;
        self.rightTablew.delegate = self;
        
        self.rightTablew.showsVerticalScrollIndicator = NO;
        self.rightTablew.showsHorizontalScrollIndicator = NO;
        
        self.rightTablew.tableFooterView = [[UIView alloc] init];
        [self addSubview:self.rightTablew];
        //self.rightTablew.backgroundColor = [UIColor yellowColor];
        if ([self.rightTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.rightTablew.layoutMargins = UIEdgeInsetsZero;
        }
        if ([self.rightTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.rightTablew.separatorInset = UIEdgeInsetsZero;
        }
        self.rightTablew.separatorColor = self.leftSeparatorColor;
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark - 移除选中cell - 通知触发

- (void)removeCellText:(NSNotification*) notification
{
    id obj = [notification object];
    
    NSString *cellTitle = (NSString *)obj;

    NSArray *rightArray1 = [NSArray arrayWithObjects:@"发热", @"失眠", @"抽搐惊厥", @"食欲不振", @"乏力虚汗", @"黄疸", nil];
    NSArray *rightArray2 = [NSArray arrayWithObjects:@"水肿", @"头疼", @"咳嗽咳痰", @"眩晕", @"咳血", @"晕厥", @"发绀" , nil];
    NSArray *rightArray3 = [NSArray arrayWithObjects:@"胸疼", @"皮肤黏膜出血", @"呼吸困难", @"呕血", @"心悸", @"肿块", @"恶心呕吐", @"腰背疼", nil];
    NSArray *rightArray4 = [NSArray arrayWithObjects: @"便血", @"血尿", @"腹疼", @"尿频、尿急与尿痛", @"腹泻", @"少尿、无尿", @"便秘", @"多尿", @"肿块", nil];
    NSArray *rightArray5 = [NSArray arrayWithObjects:@"关节疼", @"皮肤黏膜出血", @"水肿", @"肿块", @"疼痛", @"感觉消退", nil];
    
    //    11111111111
    NSIndexPath *path; // 右侧table对应的cell IndexPath
    if ([cellTitle isEqualToString:rightArray1[0]]) {
        [MEDAllBodyModel sharedAllBodyModel].faRe = YES;
        path = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray1[1]]) {
        [MEDAllBodyModel sharedAllBodyModel].shiMian = YES;
        path = [NSIndexPath indexPathForRow:1 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray1[2]]) {
        [MEDAllBodyModel sharedAllBodyModel].chouChu = YES;
        path = [NSIndexPath indexPathForRow:2 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray1[3]]) {
        [MEDAllBodyModel sharedAllBodyModel].shiYuBuZhen = YES;
        path = [NSIndexPath indexPathForRow:3 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray1[4]]) {
        [MEDAllBodyModel sharedAllBodyModel].faLiXuHan = YES;
        path = [NSIndexPath indexPathForRow:4 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray1[5]]) {
        [MEDAllBodyModel sharedAllBodyModel].huangDan = YES;
        path = [NSIndexPath indexPathForRow:5 inSection:0];
    }
    //    222222222222
    else if ([cellTitle isEqualToString:rightArray2[0]]){
        [MEDHeadModel sharedHeadModel].touJingShuiZhong = YES;
        path = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray2[1]]){
        [MEDHeadModel sharedHeadModel].touTong = YES;
        path = [NSIndexPath indexPathForRow:1 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray2[2]]){
        [MEDHeadModel sharedHeadModel].keSuKeTan = YES;
        path = [NSIndexPath indexPathForRow:2 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray2[3]]){
        [MEDHeadModel sharedHeadModel].xuanYun = YES;
        path = [NSIndexPath indexPathForRow:3 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray2[4]]){
        [MEDHeadModel sharedHeadModel].keXue = YES;
        path = [NSIndexPath indexPathForRow:4 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray2[5]]){
        [MEDHeadModel sharedHeadModel].yunJue = YES;
        path = [NSIndexPath indexPathForRow:5 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray2[6]]){
        [MEDHeadModel sharedHeadModel].faGan = YES;
        path = [NSIndexPath indexPathForRow:6 inSection:0];
    }
    //    333333333333
    else if ([cellTitle isEqualToString:rightArray3[0]]){
        [MEDChestModel sharedChestModel].xiongTong = YES;
        path = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[1]]) {
        [MEDChestModel sharedChestModel].xiongBupiFuNianMoChuXue = YES;
        path = [NSIndexPath indexPathForRow:1 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[2]]) {
        [MEDChestModel sharedChestModel].huxiKunNan = YES;
        path = [NSIndexPath indexPathForRow:2 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[3]]) {
        [MEDChestModel sharedChestModel].ouXue = YES;
        path = [NSIndexPath indexPathForRow:3 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[4]]) {
        [MEDChestModel sharedChestModel].xinJi = YES;
        path = [NSIndexPath indexPathForRow:4 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[5]]) {
        [MEDChestModel sharedChestModel].xiongBuZhongKuai = YES;
        path = [NSIndexPath indexPathForRow:5 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[6]]) {
        [MEDChestModel sharedChestModel].eXinOuTu = YES;
        path = [NSIndexPath indexPathForRow:6 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray3[7]]) {
        [MEDChestModel sharedChestModel].yaoBeiTeng = YES;
        path = [NSIndexPath indexPathForRow:7 inSection:0];
    }
    //    444444444444
    else if ([cellTitle isEqualToString:rightArray4[0]]){
        [MEDBellyModel sharedBellyModel].bianXue = YES;
        path = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[1]]) {
        [MEDBellyModel sharedBellyModel].xueNiao = YES;
        path = [NSIndexPath indexPathForRow:1 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[2]]) {
        [MEDBellyModel sharedBellyModel].fuTeng = YES;
        path = [NSIndexPath indexPathForRow:2 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[3]]) {
        [MEDBellyModel sharedBellyModel].niaoPinNiaoJi = YES;
        path = [NSIndexPath indexPathForRow:3 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[4]]) {
        [MEDBellyModel sharedBellyModel].fuXie = YES;
        path = [NSIndexPath indexPathForRow:4 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[5]]) {
        [MEDBellyModel sharedBellyModel].shaoNiaoWuNiao = YES;
        path = [NSIndexPath indexPathForRow:5 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[6]]) {
        [MEDBellyModel sharedBellyModel].bianMi = YES;
        path = [NSIndexPath indexPathForRow:6 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[7]]) {
        [MEDBellyModel sharedBellyModel].duoNiao = YES;
        path = [NSIndexPath indexPathForRow:7 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray4[8]]) {
        [MEDBellyModel sharedBellyModel].fuBuZhongKuai = YES;
        path = [NSIndexPath indexPathForRow:8 inSection:0];
    }
    //    55555555555555
    else if ([cellTitle isEqualToString:rightArray5[0]]){
        [MEDLimbsModel sharedLimbsModel].guanJieTeng = YES;
        path = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray5[1]]){
        [MEDLimbsModel sharedLimbsModel].SiZhiPiFuNianMoChuXue = YES;
        path = [NSIndexPath indexPathForRow:1 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray5[2]]){
        [MEDLimbsModel sharedLimbsModel].siZhishuiZhong = YES;
        path = [NSIndexPath indexPathForRow:2 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray5[3]]){
        [MEDLimbsModel sharedLimbsModel].siZhiZhongKuai = YES;
        path = [NSIndexPath indexPathForRow:3 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray5[4]]){
        [MEDLimbsModel sharedLimbsModel].siZhiTengTong = YES;
        path = [NSIndexPath indexPathForRow:4 inSection:0];
    } else if ([cellTitle isEqualToString:rightArray5[5]]){
        [MEDLimbsModel sharedLimbsModel].ganJueXiaoTui = YES;
        path = [NSIndexPath indexPathForRow:5 inSection:0];
    }


    NSIndexPath *leftpath; // 左侧table对应的cell IndexPath
    if ([rightArray1 containsObject:cellTitle]) {
        leftpath = [NSIndexPath indexPathForRow:0 inSection:0];
    }else if ([rightArray2 containsObject:cellTitle]) {
        leftpath = [NSIndexPath indexPathForRow:1 inSection:0];
    }else if ([rightArray3 containsObject:cellTitle]) {
        leftpath = [NSIndexPath indexPathForRow:2 inSection:0];
    }else if ([rightArray4 containsObject:cellTitle]) {
        leftpath = [NSIndexPath indexPathForRow:3 inSection:0];
    }else if ([rightArray5 containsObject:cellTitle]) {
        leftpath = [NSIndexPath indexPathForRow:4 inSection:0];
    }

    // 左侧选择
    if ([_leftTablew.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_leftTablew.delegate tableView:_leftTablew didSelectRowAtIndexPath:leftpath];
    }

    if ([_rightTablew.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_rightTablew.delegate tableView:_rightTablew didSelectRowAtIndexPath:path];
    }

//    拿到右侧cell
//    MEDRightTableViewCell *cell = [_rightTablew dequeueReusableCellWithIdentifier:RIGHT_TABLE];
//    // 根据右侧cell让tableView选择cell
//    [self selectTable:_rightTablew andCell:cell andIndexPath:path];  // 问题应该出在这里
//    [_rightTablew reloadData];

    // 拿到右侧的所有可见cell
//    NSArray *cellArr = [_rightTablew visibleCells];
//    NSInteger num = 0;
//    for (MEDRightTableViewCell *cellcell in cellArr) {
//        if ([cellcell.title.text isEqualToString:cellTitle]) {
//            num++;
//        }
//    }
//    if (num != 0) {
//        [_rightTablew reloadData];
//    }
}

#pragma mark - TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger num;
    
    if (tableView == _leftTablew) {
        num = 5;
    } else {
        num = _rightCellNum;
    }
    
    return num;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cellReturn;
    
    if (tableView == _leftTablew) {
        
        MEDLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LEFT_TABLE];
        
        if (!cell) {
            
            cell = [[MEDLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LEFT_TABLE];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //左边带文字的图片
        NSArray *iconImageSelect = [NSArray arrayWithObjects:@"tab_quanshen_xuanzhong", @"tab_toujingbu_xuanzhong", @"tab_xiongbu_xuanzhong", @"tab_fubu_xuanzhong", @"tab_sizhi_xuanzhong", nil];
        NSArray *iconImageUnSelect = [NSArray arrayWithObjects:@"tab_quanshen", @"tab_toujingbu", @"tab_xiongbu", @"tab_fubu", @"tab_sizhi", nil];
        
        NSArray *partName = [NSArray arrayWithObjects:@"全身症状", @"头颈部症状", @"胸部症状", @"腹部症状", @"四肢症状", nil];
        
        if (indexPath.row == _leftSelectIndex) {
            //MYLog(@"设置左 点中%ld",(long)indexPath.row);
            [self setLeftTablewCellSelected:YES withCell:cell];
            [cell addIconImageView:[iconImageSelect objectAtIndex:indexPath.row]];
            [cell addPartName:[partName objectAtIndex:indexPath.row]];
            cell.backgroundColor = [UIColor whiteColor];
        }
        else{
            [self setLeftTablewCellSelected:NO withCell:cell];
            
            //MYLog(@"设置左 不点中%ld",(long)indexPath.row);
            [cell addIconImageView:[iconImageUnSelect objectAtIndex:indexPath.row]];
            [cell addPartName:[partName objectAtIndex:indexPath.row]];
            cell.backgroundColor = MEDGrayColor(243);
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        cellReturn = cell;
        
    } else {
        
        MEDRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RIGHT_TABLE];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[MEDRightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RIGHT_TABLE];
            cell.selectedImage.hidden = YES;
        }
        
        if (indexPath.row % 2 == 0 ) {
            cell.backgroundColor = [UIColor whiteColor];
        } else {
            cell.backgroundColor = MEDGrayColor(249);
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addTitleText:[_rightArray objectAtIndex:indexPath.row]];
        
        switch (_leftSelectIndex) {
            case 0:
            {
                BOOL isShowImage = false;
                _allBodyModel = [MEDAllBodyModel sharedAllBodyModel];
                
                switch (indexPath.row) {
                    case 0:
                    {
                        isShowImage = _allBodyModel.faRe;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 1:
                    {
                        isShowImage = _allBodyModel.shiMian;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 2:
                    {
                        isShowImage = _allBodyModel.chouChu;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 3:
                    {
                        isShowImage = _allBodyModel.shiYuBuZhen;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 4:
                    {
                        isShowImage = _allBodyModel.faLiXuHan;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 5:
                    {
                        isShowImage = _allBodyModel.huangDan;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
            }
                break;
                
            case 1:
            {
                BOOL isShowImage = false;
                _headModel = [MEDHeadModel sharedHeadModel];
                
                switch (indexPath.row) {
                    case 0:
                    {
                        isShowImage = _headModel.touJingShuiZhong;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 1:
                    {
                        isShowImage = _headModel.touTong;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 2:
                    {
                        isShowImage = _headModel.keSuKeTan;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 3:
                    {
                        isShowImage = _headModel.xuanYun;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 4:
                    {
                        isShowImage = _headModel.keXue;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 5:
                    {
                        isShowImage = _headModel.yunJue;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 6:
                    {
                        isShowImage = _headModel.faGan;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 2:
            {
                BOOL isShowImage = false;
                _chestModel = [MEDChestModel sharedChestModel];
                
                switch (indexPath.row) {
                    case 0:
                    {
                        isShowImage = _chestModel.xiongTong;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 1:
                    {
                        isShowImage = _chestModel.xiongBupiFuNianMoChuXue;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 2:
                    {
                        isShowImage = _chestModel.huxiKunNan;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 3:
                    {
                        isShowImage = _chestModel.ouXue;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 4:
                    {
                        isShowImage = _chestModel.xinJi;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 5:
                    {
                        isShowImage = _chestModel.xiongBuZhongKuai;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 6:
                    {
                        isShowImage = _chestModel.eXinOuTu;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 7:
                    {
                        isShowImage = _chestModel.yaoBeiTeng;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 3:
            {
                BOOL isShowImage = false;
                _bellyModel = [MEDBellyModel sharedBellyModel];
                
                switch (indexPath.row) {
                    case 0:
                    {
                        isShowImage = _bellyModel.bianXue;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 1:
                    {
                        isShowImage = _bellyModel.xueNiao;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 2:
                    {
                        isShowImage = _bellyModel.fuTeng;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 3:
                    {
                        isShowImage = _bellyModel.niaoPinNiaoJi;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 4:
                    {
                        isShowImage = _bellyModel.fuXie;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 5:
                    {
                        isShowImage = _bellyModel.shaoNiaoWuNiao;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 6:
                    {
                        isShowImage = _bellyModel.bianMi;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 7:
                    {
                        isShowImage = _bellyModel.duoNiao;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 8:
                    {
                        isShowImage = _bellyModel.fuBuZhongKuai;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 4:
            {
                BOOL isShowImage = false;
                _limbsModel = [MEDLimbsModel sharedLimbsModel];
                
                switch (indexPath.row) {
                    case 0:
                    {
                        isShowImage = _limbsModel.guanJieTeng;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 1:
                    {
                        isShowImage = _limbsModel.SiZhiPiFuNianMoChuXue;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 2:
                    {
                        isShowImage = _limbsModel.siZhishuiZhong;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 3:
                    {
                        isShowImage = _limbsModel.siZhiZhongKuai;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 4:
                    {
                        isShowImage = _limbsModel.siZhiTengTong;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    case 5:
                    {
                        isShowImage = _limbsModel.ganJueXiaoTui;
                        [self setRightTablewCellSelected:isShowImage withCell:cell];
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
                if (indexPath.row == _rightSelectIndex) {
                    NSLog(@"设置右 点中:%ld",(long)indexPath.row);
                    [self setRightTablewCellSelected:isShowImage withCell:cell];
                }
            }
                break;
                
            default:
                break;
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        cellReturn = cell;
    }
    
    return cellReturn;
}

#pragma mark--TablewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height;
    if (tableView == _leftTablew) {
        height = LeftTableHW;
    } else {
        height = 40;
    }
    
    return height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTablew) {
        MEDLeftTableViewCell * cell=(MEDLeftTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        [self setLeftTablewCellSelected:YES withCell:cell];
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        if (tableView == _leftTablew) {
            _select++;
            _leftSelectIndex = indexPath.row;
            
            [_rightTablew cellForRowAtIndexPath:indexPath];
        } else {
            
            _rightSelectIndex = indexPath.row;
        }
        
        NSArray *rightArray;
        [_rightArray removeAllObjects];
        
        switch (_leftSelectIndex) {
            case 0:
            {
                rightArray = [NSArray arrayWithObjects:@"发热", @"失眠", @"抽搐惊厥", @"食欲不振", @"乏力虚汗", @"黄疸", nil];
            }
                break;
                
            case 1:
            {
                rightArray = [NSArray arrayWithObjects:@"水肿", @"头疼", @"咳嗽咳痰", @"眩晕", @"咳血", @"晕厥", @"发绀" , nil];
            }
                break;
                
            case 2:
            {
                rightArray = [NSArray arrayWithObjects:@"胸疼", @"皮肤黏膜出血", @"呼吸困难", @"呕血", @"心悸", @"肿块", @"恶心呕吐", @"腰背疼", nil];
            }
                break;
                
            case 3:
            {
                rightArray = [NSArray arrayWithObjects: @"便血", @"血尿", @"腹疼", @"尿频、尿急与尿痛", @"腹泻", @"少尿、无尿", @"便秘", @"多尿", @"肿块", nil];
            }
                break;
                
            case 4:
            {
                rightArray = [NSArray arrayWithObjects:@"关节疼", @"皮肤黏膜出血", @"水肿", @"肿块", @"疼痛", @"感觉消退", nil];
            }
                break;
            default:
                break;
        }

        [_rightArray addObjectsFromArray:rightArray];
        _rightCellNum = _rightArray.count;
        
        [self.rightTablew reloadData];
        [self.leftTablew reloadData];
        
    } else {
        MEDRightTableViewCell * cell=(MEDRightTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [self setRightTablewCellSelected:YES withCell:cell];
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        cell.isShowSelect = YES;
        
        [self selectTable:tableView andCell:cell andIndexPath:indexPath];
        
         if (!cell.selectedImage.hidden) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectSymptomCell" object:selectedCell];
            NSLog(@"SymRTable-selectedCell--:%@",selectedCell);
         }
        [self.rightTablew reloadData];
    }
}

#pragma mark - 添加Cell通知

- (void)selectTable:(UITableView *)tableView andCell:(MEDRightTableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTablew) {
        _leftSelectIndex = indexPath.row;
    } else {
        _rightSelectIndex = indexPath.row;
        switch (_leftSelectIndex) {
            case 0:
            {
                _allBodyModel = [MEDAllBodyModel sharedAllBodyModel];
                switch (_rightSelectIndex) {
                    case 0:
                    {
                        if (_allBodyModel.faRe) {
                            _allBodyModel.faRe = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _allBodyModel.faRe = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 1:
                    {
                        if (_allBodyModel.shiMian) {
                            _allBodyModel.shiMian = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _allBodyModel.shiMian = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        if (_allBodyModel.chouChu) {
                            _allBodyModel.chouChu = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _allBodyModel.chouChu = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 3:
                    {
                        if (_allBodyModel.shiYuBuZhen) {
                            _allBodyModel.shiYuBuZhen = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _allBodyModel.shiYuBuZhen = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 4:
                    {
                        if (_allBodyModel.faLiXuHan) {
                            _allBodyModel.faLiXuHan = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _allBodyModel.faLiXuHan = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 5:
                    {
                        if (_allBodyModel.huangDan) {
                            _allBodyModel.huangDan = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _allBodyModel.huangDan = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 1:
            {
                _headModel = [MEDHeadModel sharedHeadModel];
                switch (_rightSelectIndex) {
                    case 0:
                    {
                        if (_headModel.touJingShuiZhong) {
                            _headModel.touJingShuiZhong = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.touJingShuiZhong = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 1:
                    {
                        if (_headModel.touTong) {
                            _headModel.touTong = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.touTong = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        if (_headModel.keSuKeTan) {
                            _headModel.keSuKeTan = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.keSuKeTan = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                        
                    }
                        break;
                        
                    case 3:
                    {
                        if (_headModel.xuanYun) {
                            _headModel.xuanYun = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.xuanYun = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 4:
                    {
                        if (_headModel.keXue) {
                            _headModel.keXue = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.keXue = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 5:
                    {
                        if (_headModel.yunJue) {
                            _headModel.yunJue = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.yunJue = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 6:
                    {
                        if (_headModel.faGan) {
                            _headModel.faGan = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _headModel.faGan = YES;
                            ////if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 2:
            {
                _chestModel = [MEDChestModel sharedChestModel];
                switch (_rightSelectIndex) {
                    case 0:
                    {
                        if (_chestModel.xiongTong) {
                            _chestModel.xiongTong = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.xiongTong = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 1:
                    {
                        if (_chestModel.xiongBupiFuNianMoChuXue) {
                            _chestModel.xiongBupiFuNianMoChuXue = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.xiongBupiFuNianMoChuXue = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        if (_chestModel.huxiKunNan) {
                            _chestModel.huxiKunNan = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.huxiKunNan = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 3:
                    {
                        if (_chestModel.ouXue) {
                            _chestModel.ouXue = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.ouXue = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 4:
                    {
                        if (_chestModel.xinJi) {
                            _chestModel.xinJi = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.xinJi = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 5:
                    {
                        if (_chestModel.xiongBuZhongKuai) {
                            _chestModel.xiongBuZhongKuai = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.xiongBuZhongKuai = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 6:
                    {
                        if (_chestModel.eXinOuTu) {
                            _chestModel.eXinOuTu = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.eXinOuTu = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 7:
                    {
                        if (_chestModel.yaoBeiTeng) {
                            _chestModel.yaoBeiTeng = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _chestModel.yaoBeiTeng = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 3:
            {
                _bellyModel = [MEDBellyModel sharedBellyModel];
                switch (_rightSelectIndex) {
                    case 0:
                    {
                        if (_bellyModel.bianXue) {
                            _bellyModel.bianXue = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.bianXue = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 1:
                    {
                        if (_bellyModel.xueNiao) {
                            _bellyModel.xueNiao = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.xueNiao = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        if (_bellyModel.fuTeng) {
                            _bellyModel.fuTeng = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.fuTeng = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 3:
                    {
                        if (_bellyModel.niaoPinNiaoJi) {
                            _bellyModel.niaoPinNiaoJi = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.niaoPinNiaoJi = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 4:
                    {
                        if (_bellyModel.fuXie) {
                            _bellyModel.fuXie = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.fuXie = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 5:
                    {
                        if (_bellyModel.shaoNiaoWuNiao) {
                            _bellyModel.shaoNiaoWuNiao = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.shaoNiaoWuNiao = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 6:
                    {
                        if (_bellyModel.bianMi) {
                            _bellyModel.bianMi = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.bianMi = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 7:
                    {
                        if (_bellyModel.duoNiao) {
                            _bellyModel.duoNiao = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.duoNiao = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 8:
                    {
                        if (_bellyModel.fuBuZhongKuai) {
                            _bellyModel.fuBuZhongKuai = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _bellyModel.fuBuZhongKuai = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 4:
            {
                _limbsModel = [MEDLimbsModel sharedLimbsModel];
                switch (_rightSelectIndex) {
                    case 0:
                    {
                        if (_limbsModel.guanJieTeng) {
                            _limbsModel.guanJieTeng = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _limbsModel.guanJieTeng = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 1:
                    {
                        if (_limbsModel.SiZhiPiFuNianMoChuXue) {
                            _limbsModel.SiZhiPiFuNianMoChuXue = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _limbsModel.SiZhiPiFuNianMoChuXue = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        if (_limbsModel.siZhishuiZhong) {
                            _limbsModel.siZhishuiZhong = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _limbsModel.siZhishuiZhong = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 3:
                    {
                        if (_limbsModel.siZhiZhongKuai) {
                            _limbsModel.siZhiZhongKuai = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _limbsModel.siZhiZhongKuai = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 4:
                    {
                        if (_limbsModel.siZhiTengTong) {
                            _limbsModel.siZhiTengTong = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _limbsModel.siZhiTengTong = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    case 5:
                    {
                        if (_limbsModel.ganJueXiaoTui) {
                            _limbsModel.ganJueXiaoTui = NO;
                            [selectedCell removeObject:cell.title.text];
                        } else {
                            _limbsModel.ganJueXiaoTui = YES;
                            //if (cell)
                            [selectedCell addObject:cell.title.text];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
        _rightSelectIndex = indexPath.row;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)setLeftTablewCellSelected:(BOOL)selected withCell:(MEDLeftTableViewCell*)cell
{
    [self.rightTablew reloadData];
}

#pragma mark 设置右侧cell的选中图标
-(void)setRightTablewCellSelected:(BOOL)selected withCell:(MEDRightTableViewCell*)cell
{
    if (!selected) {
        cell.selectedImage.hidden = YES;
    } else {
        cell.selectedImage.hidden = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
