//
//  FSSpaceCell.m
//  FangShengyun
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSSpaceCell.h"
@interface FSSpaceCell()
@end
@implementation FSSpaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configuration];
    }
    return self;
}
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
@end
