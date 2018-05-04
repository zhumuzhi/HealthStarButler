//
//  MEDHomeHealthPlanCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/4.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHomeHealthPlanCell.h"

@implementation MEDHomeHealthPlanCell

#pragma mark - init
/** 便利构造方法 */
+ (instancetype)homeHealthPlanCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"healthPlanCell";
    MEDHomeHealthPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MEDHomeHealthPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/** init */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /** 配置子控件 */
        [self configSubView];
    }
    return self;
}

#pragma mark - CongfigSubView
/** 配置子控件 */
- (void)configSubView
{
    CGFloat MARGIN = 10.0f;
    //背景
    UIView *healthPlanView = [[UIView alloc] init];
    healthPlanView.frame = CGRectMake(0, MARGIN, SCREEN_WIDTH, 130);
    healthPlanView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:healthPlanView];
    
    //标题
    CGSize titleSize = [@"健康方案" sizeWithFont:[UIFont systemFontOfSize:14]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, MARGIN + 3, titleSize.width, titleSize.height)];
    title.font = [UIFont systemFontOfSize:14];
    title.text = @"健康方案";
    title.textColor = MEDGrayColor(40);
    [healthPlanView addSubview:title];
    
    //图片
    UIImageView *healthPlanImage = [[UIImageView alloc] init];
    healthPlanImage.frame = CGRectMake(MARGIN, CGRectGetMaxY(title.frame)+MARGIN*2, 50, 50);
    healthPlanImage.image = [UIImage imageNamed:@"home_p_yinshi"];
    [healthPlanView addSubview:healthPlanImage];
    
    //按钮
    NSArray *btnArray = @[@"饮食",@"运动",@"睡眠",@"用药"];
    CGFloat buttonWidth = 50;
    CGFloat origin = healthPlanView.frame.size.width - buttonWidth*4 - MARGIN*4;
    
    for (int i = 0; i<btnArray.count; i++) {
        UIButton *planButton = [[UIButton alloc] init];
        //button.backgroundColor = [UIColor lightGrayColor];
        planButton.tag = i;
        //NSString *str = btnArray[i];
        //CGSize btnSize = [str sizeWithFont:sysFont(14)];
        CGFloat btnX = origin + buttonWidth * i + i*MARGIN; //宽度写死
        CGFloat btnY = 10;
        CGFloat btnW = buttonWidth;
        CGFloat btnH = 25;
        planButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        planButton.layer.cornerRadius = 5.0;
        planButton.layer.borderColor = MEDGrayColor(204).CGColor;
        planButton.layer.borderWidth = 1.0f;
        
        planButton.titleLabel.font = MEDSYSFont(14);
        [planButton setTitle:btnArray[i] forState:UIControlStateNormal];
        [planButton setTitleColor:MEDGrayColor(170) forState:UIControlStateNormal];
        [planButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [planButton addTarget:self action:@selector(planButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [healthPlanView addSubview:planButton];
        if (planButton.tag == 0) { //默认选中第一个
            [planButton setSelected:YES];
            [planButton setBackgroundColor:MEDRGB(28, 192, 225)];
//            buttonTag = @"0";
        }
    }
    //详情文字
    UITextView *planDetails = [[UITextView alloc] init];
    planDetails.scrollEnabled = NO;
    planDetails.editable = NO;
    planDetails.frame = CGRectMake(CGRectGetMaxX(healthPlanImage.frame) + MARGIN*2, 50, SCREEN_WIDTH - healthPlanImage.frame.size.width - MARGIN*3, 80);
    
    planDetails.textColor = MEDGrayColor(102);
    planDetails.font = [UIFont systemFontOfSize:13];
    planDetails.text = [NSString stringWithFormat:@"今日推荐摄入的总量为ld~ld千卡，摄入原则:"];
//    if (![homePlanModel.foodScheme count]) {
//        planDetails.text = [NSString stringWithFormat: @"暂无饮食方案"];
//    }else{
//        planDetails.text = [NSString stringWithFormat:@"今日推荐摄入的总量为%ld~%ld千卡，摄入原则:",(long)_homePlanModel.inputEnergyMin,(long)_homePlanModel.inputEnergyMax];
//    }
    [healthPlanView addSubview:planDetails];
}

- (void)planButtonClick:(UIButton *)button {
    //MYLog(@"点击了按钮%ld",(long)button.tag);
    //0为饮食，1为运动，2为睡眠，3为用药
    
    
}

#pragma mark - frame

#pragma mark - setData

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
