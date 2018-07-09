//
//  MEDAddTestReportController.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/4.
//  Copyright © 2017年 mmednet. All rights reserved.
//  添加检测报告

#import "MEDAddTestReportController.h"

#import "MEDTestReportModel.h"

#import "MEDCommonAddCell.h"
#import "MEDPersonalDatePickView.h"

// -------- photoView --------

#import "TZTestCell.h"
#import "LxGridViewFlowLayout.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImagePickerController.h"

#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "TZPhotoPreviewController.h"
#import "TZVideoPlayerController.h"
#import "TZGifPhotoPreviewController.h"

// -------- photoView --------
@interface MEDAddTestReportController ()<UITableViewDelegate,
                                        UITableViewDataSource,
                                        UITextFieldDelegate,
                                        //photo相关
                                        UINavigationControllerDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegate,
                                        TZImagePickerControllerDelegate,
                                        UIActionSheetDelegate,
                                        UIImagePickerControllerDelegate,
                                        UIAlertViewDelegate
                                        >
{
    /** 选中的photo */
    NSMutableArray *_selectedPhotos;
    /** 选中的Assets */
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;   //是否选择原图
    CGFloat _itemWH;
    CGFloat _margin;
    NSInteger  _maxNum;            //最大张数
    NSUInteger _columnNum;         //行数
}
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) CLLocation *location;
// -------- photoView --------

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *coverButton; //遮罩按钮
@property (nonatomic, assign) NSInteger edit;

@end

@implementation MEDAddTestReportController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = MEDRandomColor;
    [self setupNavigation]; //设置导航栏
    [self.view addSubview:self.tableView];
    
// -------- photoView --------
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    _maxNum = 9;
    _columnNum = 4;
    [self configCollectionView];
// -------- photoView --------
}

//tableView_Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth , 240) style:UITableViewStylePlain];
//        _tableView.contentInset = UIEdgeInsetsMake(64 , 0, 0, 0);

        _tableView.scrollEnabled =NO;
        _tableView.separatorColor = MEDLightGray;
        _tableView.backgroundColor = [UIColor brownColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (MEDTestReportModel *)testReportModel {
    if (_testReportModel == nil) {
        _testReportModel = [[MEDTestReportModel alloc] init];
        _testReportModel.detectionTime = @"请填写";
        _testReportModel.detectionReportType = 0;
        //_testReportModel.detectionOrgName = @"请填写";
        //_testReportModel.doctorName = @"请填写";
    }
    return _testReportModel;
}

#pragma mark - 设置导航栏
- (void)setupNavigation {
    self.title = @"添加检测报告";
    UIButton *saveTreatmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveTreatmentBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveTreatmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveTreatmentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    saveTreatmentBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [saveTreatmentBtn addTarget:self action:@selector(saveTreatmentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveTreatmentBtn];
//    self.navigationController.view.backgroundColor = MEDBlue;
}

- (void)saveTreatmentBtnClick {
    
    NSLog(@"保存参数详情为:%@", self.testReportModel);
    
    NSString *uid = @"676";

//#warning 需要传入图片数组
    
    NSLog(@"传入的图片数组为:%@",_selectedPhotos);
    //NSLog(@"传入的图片Assesst为:%@", _selectedAssets);
    
    NSLog(@"判断是否填写");
    return;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:uid forKey:@"uid"];
    
    NSString *URL = @"http://miot2.mmednet.com/app/medical/uploadReportFile";
    
    [MEDDataRequest startMultiPartUploadTaskWithSubUrl:URL imagesArray:_selectedPhotos parameterOfimages:@"file" parametersDict:params compressionRatio:.5 succeedBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *responseOb = [self dictionaryWithJsonString:responseObject[@"data"]];
        NSMutableString *photosIDStr = [[NSMutableString alloc] init];
        int i =0;
        for (NSDictionary *dic in responseOb) {
            [photosIDStr appendString:dic[@"drfId"]];
            i ++;
            if ([responseOb count]>=1 && i!=[responseOb count]){
                [photosIDStr appendString:@","];
            }
        }
        [self sendTestReportDataWithPhotosID:photosIDStr];  //提交报告文件
        
    } failedBlock:^(NSURLSessionDataTask *task, NSError *error) {
        //self.view.userInteractionEnabled = YES;
        //sender.userInteractionEnabled = YES;
        //[MEDProgressHUD dismissHUDErrorTitle:@"上传失败"];
    } uploadProgressBlock:^(NSProgress *progress) {
        
        //NSLog(@"%f",1.0 * progress.completedUnitCount / progress.totalUnitCount);
        NSString *progressSrting = [NSString stringWithFormat:@"正处上传%.2f%%",1.0 * progress.completedUnitCount / progress.totalUnitCount*100];
        NSLog(@"进度:%@", progressSrting);
    }];
    
    NSLog(@"发送网络请求");
    
    NSLog(@"如果请求成功，返回上级页面，如果失败，提示不做任何操作");
    
}

- (void)sendTestReportDataWithPhotosID:(NSString *)photosID {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSString *uid = @"676";
    
    NSString *detectionTimeStr = self.testReportModel.detectionTime;
    NSInteger detectionReportType = self.testReportModel.detectionReportType;
    NSString *detectionOrgName = self.testReportModel.detectionOrgName;
    NSString *doctorName = self.testReportModel.doctorName;
    
    [param setObject:uid forKey:@"uid"];                            //uid
    [param setObject:detectionTimeStr forKey:@"detectionTimeStr"];  //检测时间
    if (detectionReportType == 1) {                                 //检测类别
        [param setObject:@"1" forKey:@"detectionReportType"];
    } else if (detectionReportType == 2) {
        [param setObject:@"2" forKey:@"detectionReportType"];
    }
    [param setObject:detectionOrgName forKey:@"detectionOrgName"];  //检测机构
    [param setObject:doctorName forKey:@"doctorName"];              //医生姓名
    [param setValue:photosID forKey:@"drfId"];                      //图片ID
    
    NSString *URL = @"http://miot2.mmednet.com/app/medical/addDetectionReport";
    [MEDDataRequest POST:URL params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject[@"status"] == Status_OK) {
            NSLog(@"提交报告后返回的数据为:%@", responseObject[@"data"]);
            NSLog(@"返回操作");
        }else {
            NSLog(@"提交失败，请检查网络再次提交！");
        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            });
//        });
         [self.navigationController popViewControllerAnimated:YES];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"网络请求失败，请检测网络后再次提交");
        NSLog(@"%@",error);
    }];
}


#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak __typeof(&*self)weakSelf = self;
    
    NSString  *identifier = [NSString stringWithFormat:@"InputStrTableViewCellIdentifier%ld",indexPath.row];
    
    MEDCommonAddCell *commonCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!commonCell) {
        commonCell =[[MEDCommonAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) { //就诊时间
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"检测时间";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.text = self.testReportModel.detectionTime;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        if (self.edit == 2) {
            cell.detailTextLabel.textColor = MEDCommonGray;
        }else {
            cell.detailTextLabel.textColor = MEDRGB(204, 204, 209);
        }
        
        return cell;
        
    } else if (indexPath.row==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"检测类别";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        if (self.testReportModel.detectionReportType == 1) {
            cell.detailTextLabel.text = @"化验单";
            cell.detailTextLabel.textColor = MEDCommonGray;
        }else if (self.testReportModel.detectionReportType == 2) {
            cell.detailTextLabel.text = @"医学影像";
            cell.detailTextLabel.textColor = MEDCommonGray;
        }else {
            cell.detailTextLabel.text = @"请填写";
            cell.detailTextLabel.textColor = MEDRGB(204, 204, 209);
        }
        return cell;
        
    } else if (indexPath.row==2){
        NSString *text = self.testReportModel.detectionOrgName;
        if (text == nil) {
            text = nil;
        }
        commonCell.textField.tag = indexPath.row;
        commonCell.textField.delegate = self;
        [commonCell setCellInfo:@"检测机构" withInputDesc:@"请填写" withKeybordType:0 withText:text  WithReturnBlock:^(NSString *result) {
            weakSelf.testReportModel.detectionOrgName = result;
            NSLog(@"填写后模型为:%@", weakSelf.testReportModel.detectionOrgName);
        }];
        return commonCell;
        
    } else{
        NSString *text = self.testReportModel.doctorName;
        if (text == nil) {
            text = nil;
        }
        commonCell.textField.tag = indexPath.row;
        commonCell.textField.delegate = self;
        [commonCell setCellInfo:@"医生姓名" withInputDesc:@"请填写" withKeybordType:0 withText:text WithReturnBlock:^(NSString *result) {
            weakSelf.testReportModel.doctorName = result;
        }];
        return commonCell;
    }

}


#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.row == 0) { //弹出时间键盘
        [self setupDatePickerView];
    }else if(indexPath.row == 1) {
        UITableViewCell *clickCell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self setupPopView:clickCell.detailTextLabel];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSeparatorWithTarget:cell Inset:UIEdgeInsetsZero];
}


- (void)setSeparatorWithTarget:(id)target Inset:(UIEdgeInsets)inset {
    [target setSeparatorInset:inset];
    if ([target respondsToSelector:@selector(setLayoutMargins:)]) {
        [target setLayoutMargins:inset];
    }
}


#pragma mark - Event

#pragma mark 就诊时间
- (void)setupDatePickerView { //就诊时间
    MEDPersonalDatePickView *datePickVC = [[MEDPersonalDatePickView alloc] initWithFrame:self.view.frame];
    datePickVC.date = [NSDate date]; //默认时间
    datePickVC.fontColor = [UIColor whiteColor];
    datePickVC.mode = UIDatePickerModeDateAndTime;
    datePickVC.dateFormatter = @"yyyy-MM-dd HH:mm:ss";
    __weak __typeof(&*self)weakSelf = self;
    datePickVC.completeBlock = ^(NSString *selectDate) { //日期回调
        NSLog(@"选中的日期为:%@", selectDate);
        weakSelf.testReportModel.detectionTime = selectDate;
        weakSelf.edit = 2;
        [weakSelf.tableView reloadData];
    };
    [datePickVC configuration];//根据配置属性设置datePicker
    [[[UIApplication sharedApplication].delegate window] addSubview:datePickVC];
}

#pragma mark 就诊类别
- (void)setupPopView:(UIView *)targetView { //就诊类别
    
    CGFloat popViewWith = 100;
    UIView *popView = [[UIView alloc] init];
    popView.frame = CGRectMake(0, 0, popViewWith, popViewWith);
    popView.backgroundColor = [UIColor whiteColor];
    
    UIButton *outpatientBtn = [[UIButton alloc] init];
    outpatientBtn.tag = 1;
    [outpatientBtn setTitle:@"化验单" forState:UIControlStateNormal];
    [outpatientBtn setTitleColor:MEDBlack forState:UIControlStateNormal];
    outpatientBtn.frame = CGRectMake(0, 0, popViewWith, 50);
    [outpatientBtn addTarget:self action:@selector(popButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:outpatientBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 49.5, popViewWith, 0.5);
    lineView.backgroundColor = MEDLightGray;
    [outpatientBtn addSubview:lineView];
    
    UIButton *hospitalizationBtn = [[UIButton alloc] init];
    hospitalizationBtn.tag = 2;
    [hospitalizationBtn setTitle:@"医学影像" forState:UIControlStateNormal];
    [hospitalizationBtn setTitleColor:MEDBlack forState:UIControlStateNormal];
    hospitalizationBtn.frame = CGRectMake(0, 50, popViewWith, 50);
    [hospitalizationBtn addTarget:self action:@selector(popButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:hospitalizationBtn];
    
    UIButton *coverButton = [[UIButton alloc] init];
    coverButton.size = [UIScreen mainScreen].bounds.size;
    coverButton.backgroundColor = [UIColor blackColor];
    coverButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [coverButton addTarget:self action:@selector(popViewHide) forControlEvents:UIControlEventTouchUpInside];
    self.coverButton = coverButton;
    [coverButton addSubview:popView];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [targetView.superview convertRect:targetView.frame toView:window];
    popView.x = kScreenWidth - popViewWith - 20;
    popView.y = CGRectGetMaxY(rect);
    [window addSubview:coverButton];
}

- (void)popViewHide {
    [self.coverButton removeFromSuperview];
}

- (void)popButtonClick:(UIButton *)btn {
    if (btn.tag == 1) {
        NSLog(@"化验单");
        self.testReportModel.detectionReportType = 1;
        [self.coverButton removeFromSuperview];
        [self.tableView reloadData];
    }else if(btn.tag == 2) {
        NSLog(@"医学影像");
        self.testReportModel.detectionReportType = 2;
        [self.coverButton removeFromSuperview];
        [self.tableView reloadData];
    }
}


#pragma mark - CollectionViewUI
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, self.view.width, self.view.height-260) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        
        //外部选择拍照
        //        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
        //        [sheet showInView:self.view];
        
        //内部选择相机拍照
        [self pushTZImagePickerController];
        
    } else { // preview photos or video / 预览照片或者视频
        
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
        } else if ([asset isKindOfClass:[PHAsset class]]) {
            //            ALAsset *alAsset = asset;
            //            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
        }
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        
        imagePickerVc.maxImagesCount = _maxNum;       //最大张数
        imagePickerVc.allowPickingOriginalPhoto = NO; //是否允许选择原图
        
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    if (_maxNum <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxNum columnNumber:_columnNum delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    if (_maxNum > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = YES;
    // 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.circleCropRadius = 100;
    imagePickerVc.isStatusBarDefault = NO;
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
#pragma mark - 到这里为止
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
        weakSelf.location = location;
    } failureBlock:^(NSError *error) {
        weakSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
    
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];

                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    return YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(id)asset {
    
    return YES;
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

#pragma mark - LxGridViewDataSource
// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    [_collectionView reloadData];
}


#pragma mark - property

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
