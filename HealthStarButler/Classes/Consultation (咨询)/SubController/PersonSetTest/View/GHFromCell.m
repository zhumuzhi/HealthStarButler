//
//  GHFromCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "GHFromCell.h"
#import "GHFromModel.h"
#import "GHTextField.h"

@interface GHFromCell()

@property (nonatomic, strong) GHTextField *leftTitle;
@property (nonatomic, strong) GHTextField *rightDetails;
@property (nonatomic, strong) UIView *line;

//@property (nonatomic, weak) UILabel *leftTitle;
//@property (nonatomic, weak) UILabel *leftTitle;

@end

@implementation GHFromCell

- (void)setFromModel:(GHFromModel *)fromModel {
    _fromModel = fromModel;
    self.leftTitle.text = fromModel.leftTitle;
    self.rightDetails.placeholder = fromModel.placeholder;
//    self.rightDetails.imageName = fromModel.imageName;
//    self.leftTitle.isShowStar = fromModel.isShowStar;

    if (fromModel.cellType == GHFromCellType_sex) {
//        self.rightDetails.isSwitch = YES;

    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.leftTitle];
    [self addSubview:self.rightDetails];
    [self addSubview:self.line];

}
- (void)textField:(GHTextField *)textField image:(UIImage *)image{
    NSLog(@"%@",image);
}

- (void)textField:(GHTextField *)textField state:(BOOL)state {

    NSLog(@"state%d",state);

}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(15, self.frame.size.height, [UIScreen mainScreen].bounds.size.width - 30, 0.5)];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}
- (GHTextField *)rightDetails {
    if (_rightDetails == nil) {
        _rightDetails = [[GHTextField alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 140, (self.frame.size.height - 30) *0.5, 140, 30)];
        _rightDetails.textAlignment = NSTextAlignmentRight;
//        _rightDetails.textFieldDelegate = self;
    }
    return _rightDetails;
}

#pragma mark - TextField
- (GHTextField *)leftTitle {
    if (_leftTitle == nil) {
        _leftTitle = [[GHTextField alloc]initWithFrame:CGRectMake(15, (self.frame.size.height - 30 ) * 0.5, 120, 30 )];
//        _leftTitle.isShowStar = YES;
        _leftTitle.enabled = NO;
        _leftTitle.textColor = [UIColor darkGrayColor];
    }
    return _leftTitle;
}


@end
