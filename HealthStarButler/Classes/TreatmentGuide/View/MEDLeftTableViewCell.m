//
//  MEDLeftTableViewCell.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/11.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDLeftTableViewCell.h"
#define iconWidth 40
#define Magin 20

@implementation MEDLeftTableViewCell

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

- (void)initUI
{
//    CGFloat iconX = self.frame.size.width/2 - iconWidth /2;
//    CGFloat iconY = self.frame.size.height/2 - iconWidth /2;

    //决定左侧的视图大小和位置
    _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(Magin, Magin/2, iconWidth, iconWidth)];
    [self.contentView addSubview:_iconImage];
    
    _partName = [[UILabel alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImage.frame)+5, self.frame.size.width, 20)];
    [self.contentView addSubview:_partName];
    _partName.font = MEDSYSFont(10);
    _partName.textColor = MEDGrayColor(40);
}

- (void)addIconImageView:(NSString *)imageStr
{
    _iconImage.image = [UIImage imageNamed:imageStr];
}

- (void)addPartName:(NSString *)name
{
    _partName.text = name;
    CGSize partNameSize = [name sizeWithFont:MEDSYSFont(10)];
    _partName.frame = CGRectMake(_iconImage.centerX - partNameSize.width/2 , CGRectGetMaxY(_iconImage.frame) + 5, partNameSize.width, partNameSize.height);
}



@end
