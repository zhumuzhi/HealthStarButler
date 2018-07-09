//
//  MEDPersonalData.m
//  健康之星管家
//
//  Created by 朱慕之 on 2016/12/8.
//  Copyright © 2016年 Meridian. All rights reserved.
//  个人资料


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#import "MEDPersonalData.h"

#import "MEDTPersonaliconCell.h"
#import "MEDPersonalDataModel.h"

#import "MEDPersonalDatePickView.h"

#import "MEDChangeNameController.h"

#import "ValuePickerView.h"

@interface MEDPersonalData ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,MEDChangeNameControllerDelegate>
{
    MEDTPersonaliconCell *_iconCell;
    NSInteger _netImage;
    UITableViewCell *cell;
    NSString *_pickerType;
    NSString *_photoUrlStr;
    NSString *_placeholdStr;
}
@property (nonatomic, strong) UITableView *personalTableView;
//@property (nonatomic, strong) MEDPersonalPickerView *pickerView;
@property (nonatomic, strong) MEDPersonalDataModel *personlModel;
//@property (nonatomic,strong) MEDInputAlertView *inputView;

@property (nonatomic, assign) BOOL changeName;
@property (nonatomic, assign) BOOL chageBirthday;
@property (nonatomic, strong) ValuePickerView *VPickerView;


@end

@implementation MEDPersonalData

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    
    [self setupUI];
    self.VPickerView = [[ValuePickerView alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.changeName == NO) {
        [self getPersonalData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //提交修改的个人信息
//    [self updatePersonalData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)setupUI {
    _personalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight)];
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    _personalTableView.tableFooterView = [UIView new];
    _personalTableView.backgroundColor = MEDGrayColor(243);
    _personalTableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_personalTableView];
}

#pragma mark - 网络请求

//进入页面刷新数据使用的网络请求
- (void)getPersonalData {
    
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [params setValue:userModel.uid forKey:@"uid"];
    }
//    MYLog(@"params:%@", params);
    [MEDDataRequest POST:MED_GET_USERINFO params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        MYLog(@"个人资料---用户信息:%@",responseObject);
        //给模型赋值
        NSDictionary *dict = responseObject[@"data"];
        self->_personlModel = [[MEDPersonalDataModel alloc] initWithDict:dict];
        self->_photoUrlStr = self->_personlModel.userPhoto;
    
        if (self->_personlModel.sex == nil ||[self->_personlModel.sex isEqual:NULL]||[self->_personlModel.sex stringValue].length == 0) {
        
            self->_personlModel.sex = @3;
            
        };
        switch ([self->_personlModel.sex intValue]) {
            case 1:
                self->_placeholdStr = @"txm";
                break;
            case 2:
                self->_placeholdStr = @"txw";
                break;
                
            default:
                self->_placeholdStr = @"tx1";
                break;
        }
        NSLog(@"个人资料--获取的生日值:%@", self->_personlModel.birthday);
        
        WS(weakSelf);
        [weakSelf.personalTableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}
//退出更新修改
- (void)updatePersonalData {
    self.changeName = NO;
    //NSString *url = [NSString stringWithFormat:@"%@user/update",MED_DOMAIN_REQUEST];
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [params setValue:userModel.uid forKey:@"uid"];
    }
    [params setValue:_personlModel.user_name forKey:@"name"];
    [params setValue:_personlModel.sex forKey:@"sex"];
    [params setValue:_personlModel.height forKey:@"height"];
    [params setValue:_personlModel.birthday forKey:@"birthday"];
    
    NSLog(@"个人资料上传的生日值:%@", _personlModel.birthday);

    NSLog(@"上传的参数params:%@", params);
    [MEDDataRequest POST:MED_UPDATE_USERINFO params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        MYLog(@"上传成功，返回信息:%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"上传失败，原因:%@",error);
        [MEDProgressHUD showHUDStatusTitle:@"更新个人资料失败"];
    }];
}

#pragma mark - UITableViewDataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // 头像
        _iconCell = [[MEDTPersonaliconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iconCell"];
        
        //设置cell标题
        [_iconCell.iconImageView setImage:[UIImage imageNamed:_placeholdStr]];
      
       if ([_photoUrlStr class] != [NSNull class]) {
            //设置图片
            [_iconCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:_photoUrlStr] ];
        }
        return _iconCell;
    }
    
    if (indexPath.section == 1){ // 姓名/性别/生日/身高
        static NSString *ID = @"cell";
        cell = [self.personalTableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1    reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"姓名" ;
            cell.detailTextLabel.text = _personlModel.user_name;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"性别";
            
            NSString *sexStr;
            if ([_personlModel.sex intValue] == 1) {
                sexStr = @"男";
            }else if ([_personlModel.sex intValue] == 2) {
                sexStr = @"女";
            }
            cell.detailTextLabel.text = sexStr;
        } else if (indexPath.row == 2) {
            NSLog(@"个人资料赋值时--的生日值:%@", _personlModel.birthday);
            cell.textLabel.text = @"出生日期";
            cell.detailTextLabel.text = _personlModel.birthday;
        }else if (indexPath.row == 3) {
            cell.textLabel.text = @"身高";
            if (_personlModel.height == nil) {
                cell.detailTextLabel.text = @" ";
            }else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@cm",_personlModel.height];
            }
       
        }
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 65;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }
    return .1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if(indexPath.row ==0) {            //上传头像
            UIActionSheet *imageSheet = [[UIActionSheet alloc]initWithTitle:@"请选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
            [imageSheet showInView:self.view];
           
        }
    }else if (indexPath.section == 1) {
        if(indexPath.row == 0) {           //姓名
            self.changeName = YES;
            MEDChangeNameController *change = [[MEDChangeNameController alloc] init];
            change.delegate = self;
            NSString *currentName = self.personlModel.user_name;
            change.currentName = currentName;
            [self.navigationController pushViewController:change animated:YES];
            self.hidesBottomBarWhenPushed = YES;
            
        }else if(indexPath.row == 1) {     //性别
            [self showSexPickerView];
        }else if(indexPath.row == 2) {     //生日
            [self prepareDatePickerView];
        }else if(indexPath.row == 3) {     //身高
            [self showheightPickerView];
 
        }
    }
}


#pragma mark - PickerViews

#pragma mark 性别
- (void)showSexPickerView {
    self.VPickerView.dataSource =@[@"男",@"女"];
    //self.VPickerView.pickerTitle = @"性别";
    NSNumber *sexType = self.personlModel.sex ;
    NSString *sexStr;
    if ([sexType intValue] == 1) {
        sexStr = @"男";
    }else {
        sexStr = @"女";
    }
    self.VPickerView.defaultStr = sexStr;
    
    __weak typeof(self) weakSelf = self;
    self.VPickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        weakSelf.personlModel.sex = @([[stateArr lastObject] integerValue]);
        [weakSelf.personalTableView reloadData];
        [weakSelf updatePersonalData];
    };
    
    [self.VPickerView show];
}

#pragma mark 生日
-(void)prepareDatePickerView
{
    __weak __typeof(&*self)weakSelf = self;
    /** 自定义日期选择器 */
    MEDPersonalDatePickView *datePickVC = [[MEDPersonalDatePickView alloc] initWithFrame:self.view.frame];
    
    //距离当前日期的年份差（设置最大可选日期）
    //datePickVC.maxYear = -1;
    //设置最小可选日期(年分差)
    //_datePickVC.minYear = 10;
    
    //MYLog(@"模型中的生日:%@---当前的日期:%@",self.personlModel.birthday , [NSDate date]);
    NSString *dateStr = self.personlModel.birthday;
    for (int i = 0; i<[dateStr length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [dateStr substringWithRange:NSMakeRange(i, 1)];
        //NSLog(@"string is %@",s);
        if ([s isEqualToString:@"."]) {
            NSRange range = NSMakeRange(i, 1);
            dateStr = [dateStr stringByReplacingCharactersInRange:range withString:@"-"];
        }
    }
    //MYLog(@"转换完的数据:%@",dateStr);
    dateStr = [NSString stringWithFormat:@"%@ 00:00:00", dateStr];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    //MYLog(@"赋值的日期为:%@", date);
    
    datePickVC.date = date;
    //设置字体颜色
    datePickVC.fontColor = [UIColor whiteColor];
    datePickVC.mode = UIDatePickerModeDate;
    //datePickVC.dateFormatter = @"yyyy-MM-dd HH:mm:ss";
    
    //日期回调
    datePickVC.completeBlock = ^(NSString *selectDate) {
        for (int i = 0; i<[selectDate length]; i++) {
            //截取字符串中的每一个字符
            NSString *s = [selectDate substringWithRange:NSMakeRange(i, 1)];
            //NSLog(@"string is %@",s);
            if ([s isEqualToString:@"-"]) {
                NSRange range = NSMakeRange(i, 1);
                selectDate = [selectDate stringByReplacingCharactersInRange:range withString:@"."];
            }
        }
        //设置显示日期
        weakSelf.personlModel.birthday = selectDate;
        [weakSelf.personalTableView reloadData];
        [weakSelf updatePersonalData];
    };
    
    //配置属性
    [datePickVC configuration];
    
    [[[UIApplication sharedApplication].delegate window] addSubview:datePickVC];
}

#pragma mark 身高
- (void)showheightPickerView{
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i <= 250; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];  //修改了体重显示
        [array addObject:str];
    }
    self.VPickerView.dataSource = array;
    //    self.VPickerView.pickerTitle = @"身高";
    __weak typeof(self) weakSelf = self;
    
    NSString *height =  [NSString stringWithFormat:@"%@", self.personlModel.height];
    //MYLog(@"用户的身高为:%@", height);
    if ([height isEqualToString:@"0"]) {
        self.VPickerView.defaultStr = @"160";
    }else {
        self.VPickerView.defaultStr = height;
    }
    self.VPickerView.valueDidSelect = ^(NSString *value){
        
        NSInteger height = [value integerValue];
        if (height<80) {
            height = 80;
        }
        weakSelf.personlModel.height = @(height);
        [weakSelf.personalTableView reloadData];
        [weakSelf updatePersonalData];
    };
    [self.VPickerView show];
}


#pragma mark - MEDChangeNameControllerDelegate
-(void)changeNameController:(MEDChangeNameController *)controller didClickSaveButton:(NSString *)name {
    self.personlModel.user_name = name;
    [self.personalTableView reloadData];
    
}

#pragma mark 上传头像 UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 头像图片选择器

#pragma mark UIAlertViewDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self selectSourceType:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {
        [self selectSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
}

#pragma mark SelectPhoto
- (void)selectSourceType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.allowsEditing = YES;
    switch (type) {
            case UIImagePickerControllerSourceTypeCamera:
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self presentViewController:controller animated:YES completion:nil];
            
        }
            break;
            case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            controller.sourceType = sourceType;
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
            case UIImagePickerControllerSourceTypePhotoLibrary:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSString  *url = MED_Update_icon;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [params setValue:userModel.uid forKey:@"uid"];
    }
    
    NSMutableArray *imagesArray = [NSMutableArray array];
    [imagesArray addObject:image];
    
    [MEDDataRequest startMultiPartUploadTaskWithSubUrl:url imagesArray:imagesArray parameterOfimages:@"Filedata" parametersDict:params compressionRatio:.3 succeedBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"头像上传成功，返回的参数为:%@",responseObject);
        
        [MEDProgressHUD dismissHUDSuccessTitle:@"上传成功"];
        [self getPersonalData];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    } failedBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"头像上传失败，错误:%@",error);
        
        [MEDProgressHUD dismissHUDErrorTitle:@"上传失败"];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    } uploadProgressBlock:^(NSProgress *progress) {
        
        NSLog(@"%f",1.0 * progress.completedUnitCount / progress.totalUnitCount);
        NSString *progressSrting = [NSString stringWithFormat:@"正在上传%.2f%%",1.0 * progress.completedUnitCount / progress.totalUnitCount*100];
        [MEDProgressHUD showHUDStatusTitle:progressSrting];
        
    }];
    
}




@end

