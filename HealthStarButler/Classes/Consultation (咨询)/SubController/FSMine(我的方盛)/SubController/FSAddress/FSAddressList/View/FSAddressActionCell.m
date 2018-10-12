//
//  FSAddressActionCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/12.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressActionCell.h"
#import "FSAddressListMData.h"

@interface FSAddressActionCell ()

@property (nonatomic, strong) UIButton *check;
@property (nonatomic, strong) UILabel *defaultAddress;
@property (nonatomic, strong) UILabel *edit;
@property (nonatomic, strong) UIImageView *editIcon;
@property (nonatomic, strong) UIView *backGround;
@property (nonatomic, strong) UIButton *actionDefault;
@property (nonatomic, strong) UIButton *actionEdit;

@end

@implementation FSAddressActionCell



#pragma mark - SetData
- (void)setRowMData:(FSAddressListMData *)rowMData {
    _rowMData = rowMData;

}



#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];
    }
    return self;
}



#pragma mark - ConfigUI
- (void)configUI {
    
//    [self.contentView addSubView:self.check]
    
    
}



#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
}


#pragma mark - LazyGet



#pragma mark - Event



@end
