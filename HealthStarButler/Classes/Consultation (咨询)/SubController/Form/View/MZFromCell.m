//
//  MZFromCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZFromCell.h"

#import "MZFormTextField.h"
#import "MZFromModel.h"
//#import "GGSwitch.h"

@interface MZFromCell()<MZFormTextFieldDelegate,UITextViewDelegate>

@property (nonatomic , strong) MZFormTextField *leftTitle;
@property (nonatomic , strong) MZFormTextField *rightDetails;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UITextView *rightTextView;

@end

@implementation MZFromCell

- (void)setFromModel:(MZFromModel *)fromModel {
    _fromModel = fromModel;
    self.leftTitle.text = fromModel.leftTitle;
    self.rightDetails.placeholder = fromModel.placeholder;
    self.rightDetails.imageName = fromModel.imageName;
    self.leftTitle.isShowStar = fromModel.isShowStar;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.rightTextView];
    }
    return self;
}

- (void)textChange: (NSNotification *)noti {
    NSLog(@"2222");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.fromModel.cellType == MZFromCellTypeSex) {
        self.rightDetails.isSwitch = YES;
    } else if (self.fromModel.cellType == MZFromCellTypeContent) {
        self.rightDetails.hidden = YES;
        NSString *text = [NSString stringWithFormat:@"*%@",self.leftTitle.text];
        CGSize leftTitleSize = [self sizeWithText: text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)];
        self.leftTitle.frame = CGRectMake(15, (self.frame.size.height - 30 ) * 0.5, leftTitleSize.width + 5 + 10, 30);
        self.leftTitle.backgroundColor = [UIColor redColor];
        self.rightDetails.frame = CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.frame.size.width + 10, self.leftTitle.frame.origin.y, [UIScreen mainScreen].bounds.size.width - leftTitleSize.width - 15 - 15 - 10 - 15, 30);
        self.rightTextView.hidden = NO;
        self.rightTextView.frame = self.rightDetails.frame;
    }
}

- (void)setupUI {
    [self addSubview:self.leftTitle];
    [self addSubview:self.rightDetails];
    [self addSubview:self.rightTextView];
    [self addSubview:self.line];
    
}

- (void)textField:(GHTextField *)textField image:(UIImage *)image{
    NSLog(@"%@",image);
}

- (void)textField:(GHTextField *)textField state:(BOOL)state {
    
    NSLog(@"state%d",state);
}

- (void)textViewDidChange:(UITextView *)textView {
    CGRect frame = textView.frame;
    NSString *text = textView.text;
    CGSize size = [self sizeWithText:text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(frame.size.width, MAXFLOAT)];
    
    if (size.height > self.frame.size.height) {
        self.fromModel.cellHeight = size.height;
        if (self.delegate && [self.delegate respondsToSelector:@selector(fromCell:fromModel:)]) {
            [self.delegate fromCell:self fromModel:self.fromModel];
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [UIScreen mainScreen].bounds.size.width, size.height);
    }
    self.rightTextView.frame = CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height);
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(15, self.frame.size.height, [UIScreen mainScreen].bounds.size.width - 30, 0.5)];
        _line.backgroundColor = [UIColor lightGrayColor];
        _line.alpha = 0.3;
    }
    return _line;
}

- (MZFormTextField *)rightDetails {
    if (_rightDetails == nil) {
        _rightDetails = [[MZFormTextField alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 140, (self.frame.size.height - 30) *0.5, 140, 30)];
        _rightDetails.textAlignment = NSTextAlignmentRight;
        _rightDetails.textFieldDelegate = self;
        _rightDetails.font = [UIFont systemFontOfSize:14];
    }
    return _rightDetails;
}

- (UITextView *)rightTextView {
    if (_rightTextView == nil) {
        _rightTextView = [[UITextView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 140, (self.frame.size.height - 30) *0.5, 140, 30)];
        _rightTextView.hidden = YES;
        _rightTextView.textAlignment = NSTextAlignmentRight;
        _rightTextView.delegate = self;
        _rightTextView.font = [UIFont systemFontOfSize:14];
    }
    return _rightTextView;
}

#pragma mark - TextField
- (MZFormTextField *)leftTitle {
    if (_leftTitle == nil) {
        _leftTitle = [[MZFormTextField alloc]initWithFrame:CGRectMake(15, (self.frame.size.height - 30 ) * 0.5, 120, 30 )];
        _leftTitle.isShowStar = YES;
        _leftTitle.enabled = NO;
        _leftTitle.textColor = [UIColor darkGrayColor];
        _leftTitle.font = [UIFont systemFontOfSize:14];
    }
    return _leftTitle;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.rightTextView];
}
@end
