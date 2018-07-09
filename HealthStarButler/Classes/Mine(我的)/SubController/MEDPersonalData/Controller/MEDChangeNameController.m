//
//  MEDChangeNameController.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/7/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDChangeNameController.h"

#define PADDING  20
#define kMaxLength 40

@interface MEDChangeNameController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation MEDChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigation]; //设置导航栏
    
    self.view.backgroundColor = MEDRGB(228, 228, 228);
    self.view.userInteractionEnabled = YES;
    
    //UI
    UIView *fieldBackView = [[UIView alloc] init];
    fieldBackView.backgroundColor = [UIColor whiteColor];
    fieldBackView.frame = CGRectMake(0, 64, kScreenWidth, 44);
    [self.view addSubview:fieldBackView];

    UITextField  *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-30, 44)];
    nameTextField.delegate = self;
    nameTextField.text = self.currentName;
    nameTextField.textColor = MEDGray;
    nameTextField.font = MEDSYSFont(16);
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.returnKeyType = UIReturnKeyDone;
    self.nameTextField = nameTextField;
    [fieldBackView addSubview:nameTextField];

    [self.nameTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)]];
}

- (void)tapGesture {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}


#pragma mark - setupNavigation
- (void)setNavigation {
    self.title = @"修改姓名";
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = MEDSYSFont(17);
    saveBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
}

//保存按钮
- (void)saveBtnClick {
    [self.view endEditing:YES];

    //将值传递回上级页面并赋值
    NSString *changeName = self.nameTextField.text;
    NSLog(@"传递的值为:%@", changeName);
    
    if ([self.delegate respondsToSelector:@selector(changeNameController: didClickSaveButton:)]) {
        [self.delegate changeNameController:self didClickSaveButton:changeName];
    }
    
    [self updatePersonalData];
}


- (void)updatePersonalData {
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [params setValue:userModel.uid forKey:@"uid"];
    }
    [params setValue:self.nameTextField.text forKey:@"name"];
    //MYLog(@"上传的参数params:%@", params);
    [MEDDataRequest POST:MED_UPDATE_USERINFO params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 0) {
            //MYLog(@"上传成功，返回信息:%@",responseObject);
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MEDProgressHUD showHUDStatusTitle:@"修改姓名失败"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        //MYLog(@"上传失败，原因:%@",error);
        [MEDProgressHUD showHUDStatusTitle:@"修改姓名网络情请求失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - 输入框筛选逻辑
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self isInputRuleNotBlank:string] || [string isEqualToString:@""]) {//当输入符合规则和退格键时允许改变输入框
        return YES;
    } else {
        return NO;
    }
}
- (void)textFieldChanged:(UITextField *)textField {
    
    
    NSString *toBeString = textField.text;
    
    if (![self isInputRuleAndBlank:toBeString]) {
        textField.text = [self disable_emoji:toBeString];
        return;
    }
    
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    NSLog(@"%@",lang);
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            NSString *getStr = [self getSubString:toBeString];
            if(getStr && getStr.length > 0) {
                textField.text = getStr;
            }
        }
    } else{
        NSString *getStr = [self getSubString:toBeString];
        if(getStr && getStr.length > 0) {
            textField.text= getStr;
        }
    }
}
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
- (BOOL)isInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */
- (BOOL)isInputRuleAndBlank:(NSString *)str {
    
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 *  获得 kMaxLength长度的字符
 */
-(NSString *)getSubString:(NSString*)string
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > kMaxLength) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, kMaxLength)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//注意：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, kMaxLength - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}
- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
