//
//  MEDLeftTableViewCell.h
//  健康之星管家
//
//  Created by 夏帅 on 15/11/11.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDLeftTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *partName;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)addIconImageView:(NSString *)imageStr;
- (void)addPartName:(NSString *)namel;
@end
