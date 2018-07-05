//
//  MEDHomeFoodPlanCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/3.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHomeFoodPlanCell.h"

@interface MEDHomeFoodPlanCell()

@end

@implementation MEDHomeFoodPlanCell

#pragma mark - Lazy


#pragma mark - Init
/** 遍历构造方法 */
+ (instancetype)homeFoodPlanCellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"FoodPlanCell";
    MEDHomeFoodPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MEDHomeFoodPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //设置背景颜色
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //configCellSubView
        [self configCellSubView];
    }
    return self;
}

#pragma mark - configCellSubView
- (void)configCellSubView
{
    //backView
    CGFloat MARGIN = 10.0f;
    UIView *foodDiaryView = [[UIView alloc] init];
    foodDiaryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    foodDiaryView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:foodDiaryView];
    
    //指示View
    UIView *indicator = [[UIView alloc] init];
    indicator.frame = CGRectMake(MARGIN, MARGIN, 3, 15);
    indicator.backgroundColor = MEDCommonBlue;
    [foodDiaryView addSubview:indicator];
    
    //每日饮食标题
    CGSize titleSize = [@"每日饮食计划" sizeWithFont:[UIFont systemFontOfSize:14]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(indicator.frame)+MARGIN/2, MARGIN, titleSize.width, titleSize.height)];
    title.font = [UIFont systemFontOfSize:14];
    title.text = @"每日饮食计划";
    title.textColor = MEDGrayColor(40);
    [foodDiaryView addSubview:title];
    //记录标题
    UILabel *isRecordLabel = [[UILabel alloc] init];
    CGSize recordLabelSize = [@"今日未记录" sizeWithFont:[UIFont systemFontOfSize:13]];
    isRecordLabel.frame = CGRectMake(SCREEN_WIDTH - MARGIN - recordLabelSize.width, MARGIN, recordLabelSize.width, recordLabelSize.height);
    isRecordLabel.textAlignment = NSTextAlignmentRight;
    //    if (_isWriteFoodDate) {
    //        _isRecordLabel.text = @"已记录";
    //        _isRecordLabel.textColor = THEBLUE;
    //    }else {
    isRecordLabel.text = @"今日未记录";
    isRecordLabel.textColor = MEDGrayColor(170);
    //    }
    isRecordLabel.font = MEDSYSFont(13);
    isRecordLabel.textColor = MEDGrayColor(170);
    [foodDiaryView addSubview:isRecordLabel];
    
    //图片
    UIImageView *diaryImage = [[UIImageView alloc] init];
    diaryImage.frame = CGRectMake(MARGIN, CGRectGetMaxY(title.frame)+MARGIN, 80, 75);
    diaryImage.image = [UIImage imageNamed:@"yinshijihua"];
    [foodDiaryView addSubview:diaryImage];
    
    //健康饮食
    UILabel *subTitle = [[UILabel alloc] init];
    CGSize subTitleSize = [@"健康饮食" sizeWithFont:[UIFont systemFontOfSize:13]];
    subTitle.frame = CGRectMake(CGRectGetMaxX(diaryImage.frame)+MARGIN, CGRectGetMaxY(title.frame)+ MARGIN, subTitleSize.width, subTitleSize.height);
    subTitle.text = @"健康饮食";
    subTitle.textColor = MEDGrayColor(53);
    subTitle.font = [UIFont systemFontOfSize:13];
    [foodDiaryView addSubview:subTitle];
    
    //合理建议标签
    UILabel *descTitle = [[UILabel alloc] init];
    descTitle.frame = CGRectMake(CGRectGetMaxX(diaryImage.frame)+MARGIN, CGRectGetMaxY(subTitle.frame)+ MARGIN, SCREEN_WIDTH - diaryImage.frame.size.width - 3*MARGIN  , diaryImage.frame.size.height - subTitle.frame.size.height-MARGIN/2);
    descTitle.text = @"合理规划健康饮食，良好的生活习惯，拥有健康的身体";
    descTitle.numberOfLines = 0;
    descTitle.textColor = MEDGrayColor(102);
    descTitle.font = [UIFont systemFontOfSize:13];
    [foodDiaryView addSubview:descTitle];
    
}

#pragma mark - SetData

#pragma mark - Frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - system Method
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
