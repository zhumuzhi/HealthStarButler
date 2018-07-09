//
//  MEDRightTableViewCell.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/11.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDRightTableViewCell.h"

@implementation MEDRightTableViewCell

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

-(void)initUI
{
    //调整位置，影响字的位置
    _title = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, (kScreenWidth-94*2) , 40)];
    _title.textColor = MEDGrayColor(102);
    // _title.backgroundColor = THEMEREDCOLOR;
    //_title.font = [MEDResource getSmallFont];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.font = MEDSYSFont(16);
    [self.contentView addSubview:_title];
    
    _selectedImage = [[UIImageView alloc]init];
    _selectedImage.hidden = YES;
    //_selectedImage.backgroundColor = THEMEREDCOLOR;
    //绿色对勾图片
    _selectedImage.image = [UIImage imageNamed:@"Check"];
    [self.contentView addSubview:_selectedImage];
}

- (void)addTitleText:(NSString *)textStr
{
    _title.text = textStr;
    
    //    _title.textAlignment = NSTextAlignmentLeft;
    _selectedImage.frame = CGRectMake(kScreenWidth-90-20, 10, 20, 20);
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
