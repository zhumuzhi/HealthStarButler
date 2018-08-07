//
//  FSCornerRadiusCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCornerRadiusCell.h"

typedef NS_ENUM (NSUInteger,FSCornerRadiusCellType) {
    FSCornerRadiusCellTypeTop = 1,
    FSCornerRadiusCellTypeBottom,
    FSCornerRadiusCellTypeMid
};


@interface FSCornerRadiusCell ()

//@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIView *line;

@end

@implementation FSCornerRadiusCell

#pragma mark - init

+ (instancetype)cornerCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FSCornerRadiusCellID = @"FSCornerRadiusCellID";
    FSCornerRadiusCell *cell = [tableView dequeueReusableCellWithIdentifier:FSCornerRadiusCellID];
    if (cell == nil) {
        cell = [[FSCornerRadiusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSCornerRadiusCellID];
//        cell.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        cell.backgroundColor = [UIColor redColor];
//        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {

    }else if (indexPath.row == 0) {
        [self configCornerWithType:FSCornerRadiusCellTypeTop];
        [self configShadowWithType:FSCornerRadiusCellTypeTop];
    }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        [self configCornerWithType:FSCornerRadiusCellTypeBottom];
        [self configShadowWithType:FSCornerRadiusCellTypeBottom];
    }else {
        [self configCornerWithType:FSCornerRadiusCellTypeMid];
        [self configShadowWithType:FSCornerRadiusCellTypeMid];

    }
}

#pragma mark - configUI
- (void)setupUI {
    [self.contentView addSubview:self.cornerView];
    [self.contentView addSubview:self.line];
}

static CGFloat SMargin = 5;

- (void)setFrame:(CGRect)frame {
    static CGFloat margin = 5;

    frame.origin.x = margin;
    frame.size.width -= 2*margin;
    [super setFrame:frame];
//    self.shadowView.frame = self.bounds;

    CGFloat cornerX = SMargin;
    CGFloat cornerY = SMargin;
    CGFloat cornerW = frame.size.width-2*SMargin;
    CGFloat cornerH = frame.size.height-2*SMargin;
    self.cornerView.frame = CGRectMake(cornerX, cornerY, cornerW, cornerH);

    CGFloat lineX = cornerX+SMargin;
    CGFloat lineH = 1;
    CGFloat lineY = frame.size.height-SMargin-lineH;
    CGFloat lineW = cornerW-2*SMargin;
    self.line.frame = CGRectMake(lineX, lineY, lineW, lineH);
}

#pragma mark - ConfigShadow&&Corner
- (void)configCornerWithType:(FSCornerRadiusCellType)type {

    self.cornerView.layer.shadowOpacity = 0.8f;
    self.cornerView.layer.shadowColor = [UIColor colorWithHexString:@"#E2E1E1"].CGColor;

    if(type == FSCornerRadiusCellTypeTop){
        self.cornerView.layer.shadowOffset = CGSizeMake(0, 0);
        self.cornerView.layer.shadowRadius = SMargin;
    }else if(type == FSCornerRadiusCellTypeBottom) {
        self.cornerView.layer.shadowOffset = CGSizeMake(0, 0);
        self.cornerView.layer.shadowRadius = SMargin;
    }else if(type == FSCornerRadiusCellTypeMid) {

    }
}

- (void)configShadowWithType:(FSCornerRadiusCellType)type {
    CGFloat rectY = 0;
    CGFloat rectW = kScreenWidth-(SMargin*2);
    CGFloat rectH = 100;

    CGPathRef path = NULL;
    if(type == FSCornerRadiusCellTypeTop){
        CGRect viewRect = CGRectMake(-SMargin/2, rectW-SMargin/2, rectW, rectH);
         path = [UIBezierPath bezierPathWithRoundedRect:viewRect  byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(SMargin, SMargin)].CGPath;
    }else if(type == FSCornerRadiusCellTypeBottom) {
        CGRect viewRect = CGRectMake(-SMargin/2, rectW-SMargin/2, rectW, rectH+SMargin/2);
        path = [UIBezierPath bezierPathWithRoundedRect:viewRect  byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(SMargin, SMargin)].CGPath;
    }else if(type == FSCornerRadiusCellTypeMid) {
        CGRect viewRect = CGRectMake(-SMargin/2, rectY, rectW, rectH+SMargin/2);
        path = [UIBezierPath bezierPathWithRect:viewRect].CGPath;
    }
    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.masksToBounds = NO;
    lay.path = path;
    self.cornerView.layer.mask = lay;
}

#pragma mark - LazyGet

- (UIView *)cornerView {
    if (_cornerView == nil) {
        _cornerView = [[UIView alloc] init];
        _cornerView.backgroundColor = [UIColor whiteColor];
        //        _cornerView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _cornerView.layer.cornerRadius = SMargin;
        _cornerView.layer.masksToBounds = NO;
    }
    return _cornerView;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
//        _line.backgroundColor = [UIColor redColor];
    }
    return _line;
}


@end

