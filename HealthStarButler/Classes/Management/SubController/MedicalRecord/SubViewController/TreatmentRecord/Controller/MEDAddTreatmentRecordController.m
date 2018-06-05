//
//  MEDAddTreatmentRecordController.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/4.
//  Copyright © 2017年 mmednet. All rights reserved.
//  添加诊疗记录

#import "MEDAddTreatmentRecordController.h"
#import "MEDCommonAddCell.h"

#import "MEDTreatmentRecordModel.h"

#import "MEDPersonalDatePickView.h"
#import "MZpopMenu.h"

#import "MEDTreatmentRecordDescribeView.h"

@interface MEDAddTreatmentRecordController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *coverButton; //遮罩按钮

@property (nonatomic, assign) NSInteger edit;

@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, strong) UILabel *placeholder;

@end

@implementation MEDAddTreatmentRecordController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = @"添加诊疗记录";
    [self setupNavigation];
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = MEDRandomColor;
    
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStylePlain];
//        _tableView.contentInset = UIEdgeInsetsMake(64 , 0, 0, 0);
        _tableView.separatorColor = MEDLightGray;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleKeyboardDidShow:(NSNotification*)note {
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect= [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    if(self.currentTag == 1) {
        keyboardHeight = 0;
    }else if (self.currentTag == 3 || self.currentTag == 4 ) {
        keyboardHeight = 100;
    }else {
        keyboardHeight = keyboardRect.size.height;
    }
    
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = - keyboardHeight;
        self.view.frame = frame;
    }];
}

#pragma mark - TextFiedDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.currentTag = textField.tag;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    self.currentTag = textField.tag;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    return YES;
}

#pragma mark - TextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.currentTag = 5;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholder.text = @"";
    NSLog(@"开始编辑");
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"内容发生改变, 为模型赋值");
    self.treatmentModel.diagnosisRreatContent = textView.text;
    textView.textColor = MEDBlack;
}

//- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
//    NSLog(@"View将要结束编辑");
//    
//    return YES;
//}

//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (textView.text == 0) {
//        self.placeholder.text = @"请填写";
//    }
//}

- (void)handleKeyboardDidHidden {
    //textview.contentInset=UIEdgeInsetsZero;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 设置导航栏

- (void)setupNavigation{
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

    NSLog(@"保存参数详情为:%@", self.treatmentModel);
    
    NSLog(@"判断是否填写");
    
    NSLog(@"发送网络请求");
    
    NSLog(@"如果请求成功，返回上级页面，如果失败，提示不做任何操作");
   
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy
-(MEDTreatmentRecordModel *)treatmentModel {
    if (_treatmentModel == nil) {
        _treatmentModel = [[MEDTreatmentRecordModel alloc] init];
        _treatmentModel.diagnosisRreatTime = @"请填写";
        _treatmentModel.diagnosisRreatType = 0;
        //_treatmentModel.hospitalName = @"请填写";
        //_treatmentModel.departmentName = @"请填写";
        //_treatmentModel.doctorName = @"请填写";
        //_treatmentModel.diagnosisRreatContent = @"请填写";
    }
    return _treatmentModel;
}

#pragma mark - TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        cell.textLabel.text = @"就诊时间";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.text = self.treatmentModel.diagnosisRreatTime;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        if (self.edit == 2) {
            
            cell.detailTextLabel.textColor = MEDCommonGray;
        }else {
            cell.detailTextLabel.textColor = MEDRGB(204, 204, 209);
        }
        
        return cell;
        
    } else if (indexPath.row==1){
        NSString *text = self.treatmentModel.hospitalName;
        if (text == nil) {
            text = nil;
        }
        commonCell.textField.tag = indexPath.row;
        commonCell.textField.delegate = self;
        [commonCell setCellInfo:@"就诊机构" withInputDesc:@"请填写" withKeybordType:0 withText:text  WithReturnBlock:^(NSString *result) {
            weakSelf.treatmentModel.hospitalName = result;
            NSLog(@"填写后模型为:%@", weakSelf.treatmentModel.hospitalName);
        }];
        return commonCell;
        
    } else if (indexPath.row==2){ //就诊类别
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"就诊类别";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        if (self.treatmentModel.diagnosisRreatType == 1) {
            cell.detailTextLabel.text = @"门诊";
            cell.detailTextLabel.textColor = MEDCommonGray;
        }else if (self.treatmentModel.diagnosisRreatType == 2) {
            cell.detailTextLabel.text = @"住院";
            cell.detailTextLabel.textColor = MEDCommonGray;
        }else {
            cell.detailTextLabel.text = @"请填写";
            cell.detailTextLabel.textColor = MEDRGB(204, 204, 209);
        }

        return cell;
    } else if (indexPath.row==3){
        NSString *text = self.treatmentModel.departmentName;
        if (text == nil) {
            text = nil;
        }
        commonCell.textField.tag = indexPath.row;
        commonCell.textField.delegate = self;
        [commonCell setCellInfo:@"就诊科室" withInputDesc:@"请填写" withKeybordType:0 withText:text WithReturnBlock:^(NSString *result) {
            weakSelf.treatmentModel.departmentName = result;
        }];
        return commonCell;
        
    } else{
        NSString *text = self.treatmentModel.doctorName;
        if (text == nil) {
            text = nil;
        }
        commonCell.textField.tag = indexPath.row;
        commonCell.textField.delegate = self;
        [commonCell setCellInfo:@"诊疗医生" withInputDesc:@"请填写" withKeybordType:0 withText:text WithReturnBlock:^(NSString *result) {
            weakSelf.treatmentModel.doctorName = result;
            
        }];
        return commonCell;
    }
    
}


#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MEDTreatmentRecordDescribeView *describeView = [MEDTreatmentRecordDescribeView describeView];
    describeView.textView.delegate = self;
    self.placeholder = describeView.placeholder;
    return describeView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.row == 0) { //弹出时间键盘
        [self setupDatePickerView];
    }else if(indexPath.row == 2) {
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
        //NSLog(@"选中的日期为:%@", selectDate);
        weakSelf.treatmentModel.diagnosisRreatTime = selectDate;
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
    [outpatientBtn setTitle:@"门诊" forState:UIControlStateNormal];
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
    [hospitalizationBtn setTitle:@"住院" forState:UIControlStateNormal];
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
        NSLog(@"门诊");
        self.treatmentModel.diagnosisRreatType = 1;
        [self.coverButton removeFromSuperview];
        [self.tableView reloadData];
    }else if(btn.tag == 2) {
        NSLog(@"住院");
        self.treatmentModel.diagnosisRreatType = 2;
        [self.coverButton removeFromSuperview];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
