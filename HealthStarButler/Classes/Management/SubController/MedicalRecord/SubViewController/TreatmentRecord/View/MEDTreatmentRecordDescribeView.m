//
//  MEDTreatmentRecordDescribeView.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/8/2.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import "MEDTreatmentRecordDescribeView.h"

@interface MEDTreatmentRecordDescribeView ()<UITextViewDelegate>

@end

@implementation MEDTreatmentRecordDescribeView

+ (instancetype)describeView {
    return  [[[NSBundle mainBundle] loadNibNamed:@"MEDTreatmentRecordDescribeView" owner:nil options:nil]lastObject];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    self.placeholder.textColor = MEDLightGray;
    self.placeholder.font = MEDSYSFont(14);
    self.placeholder.enabled = NO;
    [self.textView addSubview:self.placeholder];
    
    if(self.textView.text.length == 0) {
        self.placeholder.text = @"请填写";
    }else {
        self.placeholder.text = @"";
    }
    
}

@end
