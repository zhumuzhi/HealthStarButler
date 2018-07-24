//
//  FSBaseTableViewCell.m
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSBaseTableViewCell.h"

@implementation FSBaseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)setupUI {
    
}
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
