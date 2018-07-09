//
//  MEDDepartmentVC.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/17.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDDepartmentVC.h"
#import "RFQuiltLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "MEDSymptomVC.h"

#import "MEDGuideLayout.h"

@interface MEDDepartmentVC ()<UICollectionViewDataSource,UICollectionViewDelegate,RFQuiltLayoutDelegate,UICollectionViewDelegateFlowLayout>
{
    NSString *_titleStr;
    UIView *_backView;
    UIView *_collectionViewTitle;
    NSMutableArray *_diseaseNameArray;
    NSMutableArray *_diseaseIdArray;
}
@property (strong, nonatomic)  UICollectionView *collectionView;
@property (nonatomic) float height;
@end

@implementation MEDDepartmentVC


#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setNavigationTitle:_name];
    self.navigationItem.title = @"科室介绍";
    self.view.backgroundColor = MEDGrayColor(243);
    
    _diseaseNameArray = [NSMutableArray array];
    _diseaseIdArray = [NSMutableArray array];
    
    [self initUI];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_diseaseNameArray removeAllObjects];
    [_diseaseIdArray removeAllObjects];
    
    [self requestData];
}


- (void)requestData {
    
    [MEDProgressHUD showHUDStatusTitle:@""];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:_did forKey:DID];

    NSString *baseUrl = MED_DOMAIN_REQUEST;
    NSLog(@"智能导诊咨询参数:%@",parameter);
    
    //测试使用的带baseURL的请求
    [MEDDataRequest POST:MED_DEPARTMENT baseURL:baseUrl params:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"status"] integerValue] == Status_OK) {
            
            [MEDProgressHUD dismissHUD];
            // MYLog(@"%@",responseObject[@"data"]);
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                [_diseaseNameArray addObject:[dic objectForKey:@"diseaseName"]];
                [_diseaseIdArray addObject:[dic objectForKey:@"diseaseId"]];
                
                // MYLog(@"%@",[[dic objectForKey:@"diseaseName"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
            }
            [self initConllectionView]; //创建conllectionView
        }
 
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MEDProgressHUD dismissHUDErrorTitle:@"加载失败"];
        NSLog(@"网络请求失败：%@",error);
    }];
}

- (void)initUI {
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationHeight+10, kScreenWidth, 50)];
    _backView.backgroundColor = [UIColor whiteColor];
    
    //科室标题
    UILabel *lable= [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, CELL_HEIGHT )];
    lable.text = _name;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = MEDGrayColor(102);
    lable.font = [UIFont systemFontOfSize:13];
    [_backView addSubview:lable];
    //线条
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, CGRectGetMaxY(lable.frame), kScreenWidth, 1 );
    line.backgroundColor = MEDGrayColor(243);
    [_backView addSubview:line];
    
    //科室介绍
    UILabel *detialLable = [[UILabel alloc]init];
    detialLable.text = [NSString stringWithFormat:@"%@",_detialStr];
    //高度w
    CGFloat contentW = self.view.bounds.size.width - detialLable.frame.origin.x  - 40 ;
    // label的字体 HelveticaNeue  Courier
    // detialLable.backgroundColor = [UIColor whiteColor];
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
    detialLable.font = fnt;
    detialLable.textColor = MEDGrayColor(102);
    detialLable.numberOfLines = 0;
    detialLable.lineBreakMode = NSLineBreakByWordWrapping;
    // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
    CGRect tmpRect = [detialLable.text boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    // 高度H
    CGFloat contentH = tmpRect.size.height;
    //MYLog(@"调整后的显示宽度:%f,显示高度:%f",contentW,contentH);
    detialLable.frame = CGRectMake(20, CGRectGetMaxY(lable.frame)+10, contentW,contentH);
    [_backView addSubview:detialLable];
    
    _backView.frame = CGRectMake(0, kNavigationHeight, kScreenWidth,(contentH+CELL_HEIGHT+20));
    [self.view addSubview:_backView];
    
}


- (void)initConllectionView {
    
    _collectionViewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame) + 10, kScreenWidth, 45)];
    _collectionViewTitle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionViewTitle];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, CELL_HEIGHT)];
    title.text = @"常见疾病";
    title.textColor = MEDGrayColor(153);
    //    title.font = sysFont(14);
    title.textAlignment = NSTextAlignmentLeft;
    [_collectionViewTitle addSubview:title];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, (CELL_HEIGHT-0.5) , kScreenWidth, 1);
    lineView.backgroundColor = MEDGrayColor(243);
    [_collectionViewTitle addSubview:lineView];
    
    
    MEDGuideLayout *flow = [[MEDGuideLayout alloc] init];
    flow.minimumLineSpacing         = 7;
    flow.minimumInteritemSpacing    = 7;
    
    //    RFQuiltLayout *layout = [[RFQuiltLayout alloc]init];
    //    layout.direction = UICollectionViewScrollDirectionVertical;
    //    layout.blockPixels = CGSizeMake(20, 50);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionViewTitle.frame), kScreenWidth, kScreenHeight- CGRectGetMaxY(_collectionViewTitle.frame)) collectionViewLayout:flow];
    _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //    layout.delegate = self;
    [self.view addSubview:_collectionView];
    
}

//#pragma mark – RFQuiltLayoutDelegate
//- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *str = [_diseaseNameArray objectAtIndex:indexPath.row];
//    NSInteger w = str.length;
//    //CGSizeMake(CGFloat width, CGFloat height)
//    return CGSizeMake(w, 1);
//}
//- (UIEdgeInsets)insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
//    //UIEdgeInsetsMake(top, left, bottom, right
//    return UIEdgeInsetsMake(10, 10, 2, 10);
//}


- (UIEdgeInsets)insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    //UIEdgeInsetsMake(top, left, bottom, right
    //    return UIEdgeInsetsMake(10, 10, 2, 10);
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return _diseaseNameArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = _diseaseNameArray[indexPath.row];
    CGSize strSize = [str sizeWithFont:MEDSYSFont(13)] ;
    CGSize returnSize = CGSizeMake(strSize.width + 10, strSize.height +20) ;
    return returnSize;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    NSString *str = _diseaseNameArray[indexPath.row];
    CGSize strSize = [str sizeWithFont:MEDSYSFont(13)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, strSize.width+10, 35);
    
    button.layer.cornerRadius = 8.0;
    button.layer.borderColor = MEDGrayColor(189).CGColor;
    button.layer.borderWidth = 1.0f;
    
    button.tag = [[_diseaseIdArray objectAtIndex:indexPath.row] integerValue];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = MEDSYSFont(13);
    [button setTitle:[_diseaseNameArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [button setTitleColor:MEDGrayColor(140) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    
    //之前设计使用的UIlabel添加点击事件，设置了cell的背景颜色，暂时保留
    //    cell.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    //    cell.layer.cornerRadius = 8;
    //    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, cell.frame.size.width-25, 30)];
    //    lable.tag = [[_diseaseIdArray objectAtIndex:indexPath.row] integerValue];
    //    lable.userInteractionEnabled = YES;
    //    lable.font = [UIFont systemFontOfSize:12];
    //    lable.textAlignment = NSTextAlignmentCenter;
    //    //lable.layer.cornerRadius = 6;
    //    lable.text = [_diseaseNameArray objectAtIndex:indexPath.row];
    //    lable.textColor = rgb(140, 140, 140, 1);
    //    [cell addSubview:lable];
    //
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick:)];
    //    tap.numberOfTapsRequired = 1;
    //    [lable addGestureRecognizer:tap];
    
    return cell;
}


-(void)buttonClick:(UIButton *)button {
    [MEDProgressHUD showHUDStatusTitle:@""];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:@(button.tag) forKey:DISEASE_ID];
    
//    [MEDDataRequest POST:MED_SYMPTOM params:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([responseObject[@"status"] integerValue] == Status_OK) {
//            
//            [MEDProgressHUD dismissHUD];
//            //MYLog(@"%@",responseObject[@"data"]);
//            MEDSymptomVC *symptom = [[MEDSymptomVC alloc]init];
//            symptom.diseaseName = [[responseObject[@"data"] objectAtIndex:0] objectForKey:@"diseaseName"];
//            symptom.clinicalExplain = [[responseObject[@"data"] objectAtIndex:0] objectForKey:@"clinicalExplain"];
//            symptom.departmentName = _name;
//            [self.navigationController pushViewController:symptom animated:YES];
//        }
//        
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        [MEDProgressHUD dismissHUDErrorTitle:@"加载失败"];
//    }];
    //NSString *baseUrl = @"http://124.207.60.172:9999/app/";
//    NSString *baseUrl = @"http://miot.mmednet.com/shark/p/";
    NSString *baseUrl = MED_DOMAIN_REQUEST;
    NSLog(@"智能导诊疾病临床症状:%@",parameter);
    
    //带baseURL的请求
    [MEDDataRequest POST:MED_SYMPTOM baseURL:baseUrl params:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == Status_OK) {
            
            [MEDProgressHUD dismissHUD];
            //MYLog(@"%@",responseObject[@"data"]);
            MEDSymptomVC *symptom = [[MEDSymptomVC alloc]init];
            
            if ([responseObject[@"data"] count] != 0) {
                symptom.diseaseName = [[responseObject[@"data"] firstObject] objectForKey:@"diseaseName"];
            }

            if ([responseObject[@"data"] count] != 0) {
            symptom.clinicalExplain = [[responseObject[@"data"] firstObject] objectForKey:@"clinicalExplain"];
            }
            symptom.departmentName = _name;
            
            [self.navigationController pushViewController:symptom animated:YES];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MEDProgressHUD dismissHUDErrorTitle:@"加载失败"];
        
    }];
}


//之前设置label使用的点击方法 -- 未使用
-(void)btnClick:(UILongPressGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateRecognized){
        
        UILabel *lable = (UILabel *)gestureRecognizer.view;
        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
        
        [parameter setObject:@(lable.tag) forKey:DISEASE_ID];
        
        [MEDDataRequest POST:MED_SYMPTOM params:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"status"] integerValue] == Status_OK) {
                
                [MEDProgressHUD dismissHUD];
                //MYLog(@"%@",responseObject[@"data"]);
                
                MEDSymptomVC *symptom = [[MEDSymptomVC alloc]init];
                symptom.diseaseName = [[responseObject[@"data"] objectAtIndex:0] objectForKey:@"diseaseName"];
                symptom.clinicalExplain = [[responseObject[@"data"] objectAtIndex:0] objectForKey:@"clinicalExplain"];
                symptom.departmentName = _name;
                [self.navigationController pushViewController:symptom animated:YES];
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            //[MEDProgressHUD dismissHUDErrorTitle:@"请连接网络"];
            NSLog(@"网络请求失败：%@",error);
        }];
        //        [_diseaseNameArray removeObjectAtIndex:lable.tag];
        //        [lable.superview removeFromSuperview];
        //        [self.collectionView reloadData];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
