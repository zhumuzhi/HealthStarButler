//
//  MEDTreatmentRecordDescribeView.h
//  BaseProject
//
//  Created by 朱慕之 on 2017/8/2.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDTreatmentRecordDescribeView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) UILabel *placeholder;
+ (instancetype)describeView;

@end
