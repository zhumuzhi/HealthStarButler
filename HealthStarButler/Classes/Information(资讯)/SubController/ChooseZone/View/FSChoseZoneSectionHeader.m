//
//  FSChoseZoneSectionHeader.m
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSChoseZoneSectionHeader.h"
#import "FSChoseZoneMData.h"

@interface FSChoseZoneSectionHeader()
@property (nonatomic , strong) UILabel *title;

@end
@implementation FSChoseZoneSectionHeader

- (void)setSectionMData:(FSChoseZoneMData *)sectionMData {
    _sectionMData = sectionMData;
    self.title.text = sectionMData.sectionHeaderTitle;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
- (void)setupUI {
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(14)];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _title;
}

@end
