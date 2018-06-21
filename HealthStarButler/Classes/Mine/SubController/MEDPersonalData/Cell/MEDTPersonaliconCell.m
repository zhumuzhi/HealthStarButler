//
//  MEDTPersonaliconCell.m
//  健康之星管家
//
//  Created by 朱慕之 on 2016/12/12.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#define ICONCELL_WIDTH self.frame.size.width
#define ICONCELL_HEIGHT self.frame.size.height
#define ICONWIDTH 45
#import "MEDTPersonaliconCell.h"

@implementation MEDTPersonaliconCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        CGSize titleLabelSize = [@"头像" sizeWithFont:MEDSYSFont(17)];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, 65/2-titleLabelSize.height/2, titleLabelSize.width, titleLabelSize.height)];
        _titleLabel.textColor = MEDGrayColor(40);
        _titleLabel.font = MEDSYSFont(17);
        [self addSubview:_titleLabel];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.76, 10, ICONWIDTH, ICONWIDTH)];
        _iconImageView.layer.masksToBounds=YES;
        _iconImageView.layer.cornerRadius = 22;
        [self addSubview:_iconImageView];
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
