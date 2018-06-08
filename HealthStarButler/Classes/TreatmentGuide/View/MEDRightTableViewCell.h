//
//  MEDRightTableViewCell.h
//  健康之星管家
//
//  Created by 夏帅 on 15/11/11.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDRightTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UIImageView *selectedImage;

@property (nonatomic, assign) BOOL isShowSelect;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)addTitleText:(NSString *)textStr;

@end
