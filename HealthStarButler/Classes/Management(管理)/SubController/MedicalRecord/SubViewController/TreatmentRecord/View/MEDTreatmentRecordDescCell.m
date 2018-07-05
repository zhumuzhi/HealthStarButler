//
//  MEDTreatmentRecordDescCell.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/8/1.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import "MEDTreatmentRecordDescCell.h"

@interface MEDTreatmentRecordDescCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MEDTreatmentRecordDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标题
        self.titleLabel = self.textLabel; //使用系统textLabel
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
