//
//  MEDPopViewListController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDPopViewListController.h"
#import "MEDAlertMananger.h"
#import "SCLAlertView.h"

#import "FFToast.h"
#import "PopView.h"

@interface MEDPopViewListController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) FFToast *customPopView;


@end

@implementation MEDPopViewListController

//MARK:- Lazy
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray arrayWithArray:@[@"系统Alert", @"系统ActionSheet", @"自定Alert-1", @"自定Alert-2",@"自定Dialog"]];
    } //自定ActionSheet
    return _datas;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        //layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGRect collectionFrame = CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight-kTabbarSafeBottomMargin);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        //_collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"弹出视图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MEDCollectionViewCellIdentifier];
}


//MARK:- UICollectionViewDataSource

static NSString *const MEDCollectionViewCellIdentifier = @"collection";

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MEDCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = MEDCommonBlue;
    
    
    UILabel *cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    cellTitle.textColor = [UIColor whiteColor];
    cellTitle.textAlignment = NSTextAlignmentCenter;
    cellTitle.numberOfLines = 0;
    
    cellTitle.text = [NSString stringWithFormat:@"%@", self.datas[indexPath.row]];
    [cell.contentView addSubview:cellTitle];
    
    return cell;
}

NSString *kSuccessTitle = @"Congratulations";
NSString *kErrorTitle = @"Connection error";
NSString *kNoticeTitle = @"Notice";
NSString *kWarningTitle = @"Warning";
NSString *kInfoTitle = @"Info";
NSString *kSubtitle = @"You've just displayed this awesome Pop Up View";
NSString *kButtonTitle = @"Done";
NSString *kAttributeTitle = @"Attributed string operation successfully completed.";


//MARK:- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:  //系统ActionSheet
        {
            NSLog(@"系统Alert");
            [MEDAlertMananger presentAlertWithTitle:@"标题" message:@"内容信息" actionTitle:@[@"确认"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
                NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
            }];
        }
            break;
        case 1:  //
        {
            NSLog(@"系统ActionSheet");
            //[self setupBaseActionSheetView];
            [MEDAlertMananger presentAlertWithTitle:@"标题" message:@"内容信息" actionTitle:@[@"空腹", @"餐前", @"餐后", @"睡前"] preferredStyle:UIAlertControllerStyleActionSheet handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
                NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
            }]; 
            
        }
            break;
        case 2:  //自定Alert-1
        {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            SCLButton *button = [alert addButton:@"First Button" target:self selector:@selector(firstButton)];
            button.buttonFormatBlock = ^NSDictionary* (void)
            {
                NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
                
                buttonConfig[@"backgroundColor"] = [UIColor whiteColor];
                buttonConfig[@"textColor"] = [UIColor blackColor];
                buttonConfig[@"borderWidth"] = @2.0f;
                buttonConfig[@"borderColor"] = [UIColor greenColor];
                
                return buttonConfig;
            };
            
            [alert addButton:@"Second Button" actionBlock:^(void) {
                NSLog(@"Second button tapped");
            }];
            
            [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:kButtonTitle duration:0.0f];
        }
            
            break;
            
        case 3:  //自定Alert-2
        {
            PopView *customToastParentView = [[[NSBundle mainBundle] loadNibNamed:@"PopView" owner:nil options:nil] lastObject];
            
            [customToastParentView.OKButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            _customPopView = [[FFToast alloc]initCentreToastWithView:customToastParentView autoDismiss:NO duration:0 enableDismissBtn:YES dismissBtnImage:nil];
            [_customPopView show];
        }
            
            break;
            
        default: //封装系统UIAlertController
        {
           [MEDAlertMananger presentAlertWithTitle:@"标题" message:@"内容信息" actionTitle:@[@"确认"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
                NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
            }];
            
            
        }
            break;
            
    }
}


- (void)okButtonClick {
    [_customPopView dismissCentreToast];
}

- (void)firstButton
{
    NSLog(@"First button tapped");
}


@end
