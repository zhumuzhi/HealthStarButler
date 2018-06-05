//
//  MEDCommonAddCell.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//  就诊机构、就诊科室、医生cell

#import "MEDCommonAddCell.h"
#import "MEDTextField.h" //自定义TextField设置了输入限制

@interface MEDCommonAddCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation MEDCommonAddCell
{
    void (^_block)(NSString *inputResult);
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        //标题
        self.titleLabel = self.textLabel; //使用系统textLabel
        self.titleLabel.font =[UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor blackColor];

        //文本框
        //self.textField = [[MEDTextFieldView alloc] init];  //自定义的限制View
        self.textField = [[MEDTextField alloc] init];
        self.textField.font = [UIFont systemFontOfSize:12];
        self.textField.textColor = MEDCommonGray;
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.delegate = self;
        self.textField.clearButtonMode = UITextFieldViewModeNever;
        self.textField.returnKeyType = UIReturnKeyDone;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanging:) name:UITextFieldTextDidChangeNotification object:self.textField];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self addSubview];
        [self autoLayout];
        
    }
    return self;
}


-(void)textFieldChanging:(id)sender{
    if (_block) {
        _block(self.textField.text);
    }
}


- (void)initCellWithTitle:(NSString*)title placeholder:(NSString*)placeholder KeybordType:(NSInteger)type text:(NSString *)text {
    _titleLabel.text = title;
    _textField.placeholder = placeholder;
    _textField.text = text;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if (type==1) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

-(void)setCellInfo:(NSString*)title withInputDesc:(NSString*)desc withKeybordType:(NSInteger)type withText:(NSString *)text WithReturnBlock:(void (^)(NSString *))textFieldBlock{
    if (type==1) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    _textField.text =text;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _block = textFieldBlock;
    _titleLabel.text = title;
    _textField.placeholder = desc;
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.y -= 0.5;//整体向上 移动0.5
    frame.size.height += 0.5;//间隔为0.5
    [super setFrame:frame];
}

/**
 * 添加页面
 */
-(void)addSubview{
    
    //[self.textField setValue:MEDBlack forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
}

/**
 * 页面自动适配
 */
-(void) autoLayout{
    
    CGFloat titleLblW = 90;
//    CGFloat titleLblX = 10;
//    CGFloat titleLblY = 20;
//    CGFloat titleLblH = 21;
    //self.titleLabel.frame = CGRectMake(titleLblX, titleLblY, titleLblW, titleLblH);
//    self.titleLabel.frame = self.textLabel.frame;
    
    CGFloat textFieldX = 100;
    CGFloat textFieldY = 20;
    CGFloat textFieldW = self.contentView.frame.size.width - titleLblW - 45;
    CGFloat textFieldH = 20;
    self.textField.frame = CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
