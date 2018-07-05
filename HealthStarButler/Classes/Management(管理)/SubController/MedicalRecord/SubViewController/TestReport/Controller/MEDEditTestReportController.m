//
//  MEDEditTestReportController.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/8/4.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import "MEDEditTestReportController.h"

//TestReport
#import "MEDTestReportModel.h"
#import "MEDDetectionReportFile.h"

#import "MEDCommonAddCell.h"
#import "MEDPersonalDatePickView.h"

//PhotoView
#import "TZTestCell.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
//#import <AssetsLibrary/AssetsLibrary.h>

//PhotoView

@interface MEDEditTestReportController ()<UITableViewDelegate,
                                        UITableViewDataSource,
                                        UITextFieldDelegate,

                                        UICollectionViewDataSource,
                                        UICollectionViewDelegate,
                                        TZImagePickerControllerDelegate
                                        >
{
//相册
    /** 选中的photo */
    NSMutableArray *_selectedPhotos;
    /** 选中的Assets */
    NSMutableArray *_selectedAssets;
    CGFloat _itemWH;
    CGFloat _margin;
    NSInteger  _maxNum;            //最大张数
    NSUInteger _columnNum;         //行数
//相册
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *coverButton; //遮罩按钮
@property (nonatomic, assign) NSInteger edit;
//相册
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MEDEditTestReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = MEDRandomColor;
    [self setupNavigation]; //设置导航栏
    [self.view addSubview:self.tableView];
    
    [self configCollectionView];
    _selectedPhotos = [[NSMutableArray alloc] initWithArray:self.testReportModel.detectionReportFile copyItems:YES];
 
    _maxNum = 9;
    _columnNum = 4;
}

#pragma mark - CollectionViewUI
- (void)configCollectionView {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.width - 2 * _margin - 4) / 3 - _margin;
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
        
        //cell.imageView.image = _selectedPhotos[indexPath.row];
        //cell.asset = _selectedAssets[indexPath.row];
        
        //SD赋值
        MEDTestReportModel *reportModel = self.testReportModel;
        NSArray *fileArray = reportModel.detectionReportFile;
//        NSArray *fileArray = fileModel.fle
        MEDDetectionReportFile *filesModel = fileArray[indexPath.row];
        NSLog(@"模型中获取的图片路径:%@", filesModel.filePath);
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:filesModel.filePath] placeholderImage:[UIImage imageNamed:@"list_wushoucang"]];
        
        cell.deleteBtn.hidden = NO;
    }
    
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        [self pushTZImagePickerController];
    }else {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        
        imagePickerVc.maxImagesCount = _maxNum;       //最大张数
        imagePickerVc.allowPickingOriginalPhoto = NO; //是否允许选择原图
        imagePickerVc.isSelectOriginalPhoto = NO;
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}


- (void)pushTZImagePickerController {
    if (_maxNum <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxNum columnNumber:_columnNum delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
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


#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    NSMutableArray *arry = [NSMutableArray arrayWithArray:photos];
    for (int i = 0; i<arry.count; i++) {
        UIImage *image = arry[i];
        [_selectedPhotos addObject:image];
    }
    
    
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    // 1.打印图片名字
    // 2.图片位置信息
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
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


//tableView_Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 240 + 64) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(64 , 0, 0, 0);
        
        _tableView.scrollEnabled =NO;
        _tableView.separatorColor = MEDLightGray;
        _tableView.backgroundColor = [UIColor brownColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - 设置导航栏
- (void)setupNavigation {
    self.title = @"检测报告";
    UIButton *saveTreatmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveTreatmentBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveTreatmentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    saveTreatmentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    saveTreatmentBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [saveTreatmentBtn addTarget:self action:@selector(saveTreatmentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveTreatmentBtn];
    self.navigationController.view.backgroundColor = MEDBlue;
}

- (void)saveTreatmentBtnClick {
    NSLog(@"保存参数详情为:%@", self.testReportModel);
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
            cell.detailTextLabel.textColor = MEDRGBA(204, 204, 209, 1);
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
            cell.detailTextLabel.textColor = MEDRGBA(204, 204, 209, 1);
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
    popView.x = SCREEN_WIDTH - popViewWith - 20;
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

@end
