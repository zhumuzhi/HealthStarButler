//
//  MEDManagementController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDManagementController.h"
#import "MEDManageVerticalCell.h"
#import "MEDManageHorizontalCell.h"

@interface MEDManagementController () <UICollectionViewDataSource, UICollectionViewDelegate>

/** 是否有疾病 */
@property (nonatomic, assign) BOOL isHaveDisease;
/** CollectionView */
@property (nonatomic, strong) UICollectionView *manageCollectionView;
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *collectionData;

@end

NSString *const kManageVerticalCellID = @"MEDManageVerticalCell";
NSString *const kManageHorizontalCellID = @"MEDManageHorizontalCell";

NSString *const kManageCollectionHeaderVID = @"manageCollectionHeaderVID";
NSString *const kManageCollectionFooterVID = @"manageCollectionFooterVID";

@implementation MEDManagementController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self.view addSubview:self.manageCollectionView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self isShowDiseaseQuestionnaire];
}


#pragma mark - NetWork
- (void)isShowDiseaseQuestionnaire
{
    NSString *dataStr = [kUserDefaults objectForKey:UserInfo];
    //从UserDefaults 中获取用户信息
    NSDictionary *userInfoDict = [self dictionaryWithJsonString:dataStr];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    userModel = [MEDUserModel mj_objectWithKeyValues:userInfoDict];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:userModel.uid forKey:UserId];
    
    [MEDDataRequest POST:diseaseQuestionnaire_Whether params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (StatusSuccessful(responseObject)) {
            NSString *dataNum = responseObject[@"data"];
            if ([dataNum integerValue] == 0) { //没有问卷
                self.isHaveDisease = NO;
            }else {
                self.isHaveDisease = YES;
            }

            [self.manageCollectionView reloadData];
            
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"判断是否有疾病请求失败,原因:%@", error);
        [self.manageCollectionView reloadData];
        
    }];
    
}




#pragma mark - UI Config
/** 设置Navigation */
- (void)setupNavigation {
    
    self.title = @"管理";
    self.navigationItem.title = @"健康管理";
    
    [self setupPersonNavigationItem];
    
}

#pragma mark - UICollectionViewDataSource
// 返回Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //    MEDLog(@"一共返回%ld组数据", self.collectionData.count);
    return self.collectionData.count;
}

// 每个Section返回ItemCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 2){
        return 4;
    }else if(section == 1) {
        return 3;
    }else{
        return self.isHaveDisease == YES?5:4;
    }
}

// 每个ItemCell的具体样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        MEDManageVerticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kManageHorizontalCellID forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        //赋值
        cell.imageView.image = [UIImage imageNamed:[self.collectionData[indexPath.section][indexPath.row] objectForKey:@"image"]];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", [self.collectionData[indexPath.section][indexPath.row] objectForKey:@"title"]];
        return cell;
        
    }else {
        
        MEDManageHorizontalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kManageVerticalCellID forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        //赋值
        cell.imageView.image = [UIImage imageNamed:[self.collectionData[indexPath.section][indexPath.row] objectForKey:@"image"]];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", [self.collectionData[indexPath.section][indexPath.row] objectForKey:@"title"]];
        
        return cell;
    }
}

// 设置Setion的Header和Footer(Supplementary View)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kManageCollectionHeaderVID forIndexPath:indexPath];
        header.backgroundColor = MEDRGB(243, 243, 243);
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kManageCollectionFooterVID forIndexPath:indexPath];
        footer.backgroundColor = MEDRGB(243, 243, 243);
        return footer;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2*0.5);
    } else if(indexPath.section == 1) {
        return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
    }else{
        if (self.isHaveDisease == YES) {
            if (indexPath.row==0||indexPath.row==1) {
                return CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2*0.5);
            }else{
                return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
            }
        }else{
            return CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/3);
        }
    }
}

//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//动态设置某个分区HeaderView大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 10);
}

//动态设置某个分区FooterView大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 0);
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld-Section中的第%ld-Row数据", indexPath.section, indexPath.row);

}

#pragma mark - Lazy

- (NSMutableArray *)collectionData
{
    
    NSMutableArray *tempData = [NSMutableArray array];
    NSMutableArray *sectionOne = [NSMutableArray array];
    NSArray *temp1 =   @[
                         @{@"title":@"健康调查问卷", @"image":@"tab_jiankangdiaochawenjuan"},
                         @{@"title":@"中医体质问卷", @"image":@"tab_zhongyitizhiwenjuan"},
                         @{@"title":@"疾病专项问卷", @"image":@"jibingzhuanxiangwenjuan"},
                         @{@"title":@"健康动态问卷", @"image":@"tab_jiankangdongtaiwenjuan"},
                         @{@"title":@"随访问卷", @"image":@"suifangwenjuan"}
                         ];
    NSArray *temp2 =   @[
                         @{@"title":@"健康调查问卷", @"image":@"tab_jiankangdiaochawenjuan"},
                         @{@"title":@"中医体质问卷", @"image":@"tab_zhongyitizhiwenjuan"},
                         @{@"title":@"健康动态问卷", @"image":@"tab_jiankangdongtaiwenjuan"},
                         @{@"title":@"随访问卷", @"image":@"suifangwenjuan"}
                         ];

    if (self.isHaveDisease == YES) {
        sectionOne = [NSMutableArray arrayWithArray:temp1];
    }else {
        sectionOne = [NSMutableArray arrayWithArray:temp2];
    }
    [tempData addObject:sectionOne];

    NSMutableArray *sectionTwo = [NSMutableArray arrayWithArray:@[
                                                                  @{@"title":@"健康评估", @"image":@"tab_jiankangpinggu"},
                                                                  @{@"title":@"健康方案", @"image":@"tab_jiankangfangan"},
                                                                  @{@"title":@"健康小结", @"image":@"tab_jiankangxiaojie"}
                                                                  ]];
    [tempData addObject:sectionTwo];

    NSMutableArray *sectionThree = [NSMutableArray arrayWithArray:@[
                                                                    @{@"title":@"体质报告", @"image":@"tab_tijianbaogao"},
                                                                    @{@"title":@"就诊记录", @"image":@"tab_jiuzhenjilu"},
                                                                    @{@"title":@"随访问卷", @"image":@"tab_yuanhousuifang"},
                                                                    @{@"title":@"敬请期待", @"image":@"tab_jingqingqidai"}
                                                                    
                                                                    ]];
    [tempData addObject:sectionThree];
    _collectionData = tempData;
    
    return _collectionData;
}

- (UICollectionView *)manageCollectionView {
    if (!_manageCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _manageCollectionView.collectionViewLayout = layout;
        
        _manageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _manageCollectionView.frame = CGRectMake(0, Navigation_Height, SCREEN_WIDTH, SCREEN_HEIGHT - Navigation_Height - TabBar_Height);
        _manageCollectionView.backgroundColor = MEDGrayColor(243);
        _manageCollectionView.showsVerticalScrollIndicator = NO;
        _manageCollectionView.delegate = self;
        _manageCollectionView.dataSource = self;
        
        [_manageCollectionView registerNib:[UINib nibWithNibName:@"MEDManageVerticalCell" bundle:nil] forCellWithReuseIdentifier:kManageVerticalCellID];
        [_manageCollectionView registerNib:[UINib nibWithNibName:@"MEDManageHorizontalCell" bundle:nil] forCellWithReuseIdentifier:kManageHorizontalCellID];
        
        [_manageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kManageCollectionHeaderVID];
        [_manageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kManageCollectionFooterVID];
    }
    return _manageCollectionView;
}



@end
