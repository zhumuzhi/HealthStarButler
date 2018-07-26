//
//  MEDLinkLeftTableViewCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDLinkLeftTableViewCell.h"

@interface MEDLinkLeftTableViewCell ()

@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation MEDLinkLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = MEDGrayColor(130);
        self.name.highlightedTextColor = MEDCommonBlue;
        [self.contentView addSubview:self.name];
        
        self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];
        self.indicatorView.backgroundColor = MEDCommonBlue;
        [self.contentView addSubview:self.indicatorView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.indicatorView.hidden = !selected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
