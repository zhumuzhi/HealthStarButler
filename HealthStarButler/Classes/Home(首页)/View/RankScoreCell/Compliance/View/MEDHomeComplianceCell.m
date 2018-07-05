//
//  MEDHomeComplianceCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/15.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomeComplianceCell.h"
#import "MEDHomeComplianceModel.h"

static NSString *const cellID = @"complianceCell";

@interface MEDHomeComplianceCell ()
@property (weak, nonatomic) IBOutlet UIView *fillNumBV;
@end

@implementation MEDHomeComplianceCell

+ (instancetype)complianceCellWithTableView:(UITableView *)tableView {
    MEDHomeComplianceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MEDHomeComplianceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(void)setComplianceModel:(MEDHomeComplianceModel *)complianceModel {
    
    _complianceModel = complianceModel;
    
    self.titleName.text = _complianceModel.title;
    
    NSLog(@"已经完成:%@", _complianceModel.complete);
    NSLog(@"期望频次:%@", _complianceModel.frequency);

    //如果已完成和频率相等
    if ([_complianceModel.complete integerValue] == [_complianceModel.frequency integerValue]) {
        [self.finishButton setTitle:@"已完成" forState:UIControlStateNormal];
        [self.finishButton setTitleColor:MEDBlue forState:UIControlStateNormal];
        [self.finishButton setBackgroundColor:[UIColor whiteColor]];
        self.finishButton.userInteractionEnabled = NO;
    } else {
        [self.finishButton setTitle:@"去完成" forState:UIControlStateNormal];
    }
    
    if ([self.titleName.text isEqualToString:@"运动"] || [self.titleName.text isEqualToString:@"睡眠"] ) {
        [self.finishButton setTitle:@"请到小米APP同步数据" forState:UIControlStateNormal];
        [self.finishButton setTitleColor:MEDRGB(153, 153, 153) forState:UIControlStateNormal];
        [self.finishButton setBackgroundColor:[UIColor whiteColor]];
        self.finishButton.userInteractionEnabled = NO;
        self.fillNumBV.hidden = YES;
        self.fillNum.hidden = YES;
        self.totleNum.hidden = YES;
    }
    
    self.fillNum.text = [NSString stringWithFormat:@"%@", complianceModel.complete];
    self.totleNum.text = [NSString stringWithFormat:@"%@", complianceModel.frequency];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.finishButton.layer.cornerRadius = 13;
    
    UIBezierPath *connerMaskPath = [UIBezierPath bezierPathWithRoundedRect:self.fillNumBV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *fatMaskLayer = [[CAShapeLayer alloc] init];
    fatMaskLayer.frame = self.fillNumBV.bounds;
    fatMaskLayer.path = connerMaskPath.CGPath;
    self.fillNumBV.layer.mask = fatMaskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
