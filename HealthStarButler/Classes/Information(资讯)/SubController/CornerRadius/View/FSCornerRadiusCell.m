//
//  FSCornerRadiusCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCornerRadiusCell.h"

@interface FSCornerRadiusCell ()

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) UIView *cornerView;

@end

@implementation FSCornerRadiusCell

#pragma mark - init

+ (instancetype)cornerCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FSCornerRadiusCellID = @"FSCornerRadiusCellID";
    FSCornerRadiusCell *cell = [tableView dequeueReusableCellWithIdentifier:FSCornerRadiusCellID];
    if (cell == nil) {
        cell = [[FSCornerRadiusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSCornerRadiusCellID];
        cell.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    }
    [cell cellViewMakeRadiusLayerWithTableView:tableView indexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)cellViewMakeRadiusLayerWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath {
//    CGRect viewRect = CGRectMake(0, 0, kScreenWidth-(10*2), 50);
    if (indexPath.row == 0) {
        [self configShadow];
        [self configCornerTop];
    }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        [self configShadow];
        [self configCornerBottom];
    }else {
        [self configShadow];
    }
}

#pragma mark - ConfigShadow&&Corner

- (void)configShadow {
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.8f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

static CGFloat corner = 8.f;

- (void)configCornerTop {
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:self.cornerView.bounds
                                           byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(corner, corner)].CGPath;
    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.path = path;
    self.cornerView.layer.mask = lay;
}
- (void)configCornerBottom {
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:self.cornerView.bounds
                                           byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(corner, corner)].CGPath;
    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.path = path;
    self.cornerView.layer.mask = lay;
}


#pragma mark - configUI
- (void)setupUI {
//   self.backgroundColor = [UIColor orangeColor];
//   [self.contentView addSubview:self.backgroundView];
//   [self configShadow];
}


- (void)setFrame:(CGRect)frame {
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2*margin;
    [super setFrame:frame];
    self.shadowView.frame = self.bounds;
}
#pragma mark - LazyGet
- (UIView *)shadowView {
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = nil;
        /* FIXME:设置圆角*/
        _shadowView.layer.cornerRadius = 8.0f;
        _shadowView.layer.masksToBounds = YES;
    }
    return _shadowView;
}

#pragma mark - SetData

#pragma mark - Event

@end

