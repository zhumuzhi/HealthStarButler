//
//  MEDSuggestCell.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/13.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDSuggestCell.h"

#define TXET_WIDTH      (200)

@implementation MEDSuggestCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initUI];
        

    }
    return self;
}

- (void)initUI {

    UIView *point = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 5, 5)];
    point.backgroundColor = [UIColor colorWithRed:200/255.0 green:107/255.0 blue:254/255.0 alpha:1];
    //point.backgroundColor = THEMEDARKCOLOR;
    [self.contentView addSubview:point];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(point.frame)+10, 0, TXET_WIDTH, (self.bounds.size.height / 2))];
    _titleLable.font = [UIFont systemFontOfSize:14];

    [self.contentView addSubview:_titleLable];
    
    
    _subLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(point.frame)+10, CGRectGetMaxY(_titleLable.frame), TXET_WIDTH , (self.bounds.size.height / 2))];
    _subLable.font = [UIFont systemFontOfSize:12];
    _subLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:_subLable];
    
}

- (void)addPercent:(int)percent andTitle:(NSString *)title andSub:(NSString *)sub
{
    [_firstGoalBar setPercent:percent animated:NO];
    _titleLable.text = title;
    _subLable.text = sub;
    
    if (percent>66) {
        [_firstGoalBar setBarColor:[UIColor colorWithRed:86/255.0 green:172/255.0 blue:212/255.0 alpha:1]];
    } else if (percent < 34) {
        [_firstGoalBar setBarColor:[UIColor colorWithRed:117/255.0 green:132/255.0 blue:213/255.0 alpha:1]];
    } else {
        [_firstGoalBar setBarColor:[UIColor colorWithRed:36/255.0 green:237/255.0 blue:248/255.0 alpha:1]];
    }
    
    
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
