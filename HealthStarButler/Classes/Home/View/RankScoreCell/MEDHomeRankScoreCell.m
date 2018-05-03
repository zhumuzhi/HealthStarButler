//
//  MEDHomeRankScoreCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/26.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHomeRankScoreCell.h"
#import "MEDScoreProgressBar.h"
#import "MEDScoreOperationView.h"

@interface MEDHomeRankScoreCell()

/** 排名Label */
@property (nonatomic, strong) UILabel *rankLabel;
/** 分数Label */
@property (nonatomic, strong) UILabel *scoreLabel;
/** 分数进度 */
@property (nonatomic, strong) MEDScoreProgressBar *scoreProgressBar;
/** 操作页面 */
@property (nonatomic, strong) MEDScoreOperationView *operationView;

@end

@implementation MEDHomeRankScoreCell

#pragma mark - Init
//便利构造对象方法
+ (instancetype)homeRankScoreCellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"homeRankCell";
    MEDHomeRankScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MEDHomeRankScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //设置背景颜色
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//初始化控件、初始化设置
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        //添加子控件
        [self configureSubView];
    }
    return self;
}

#pragma mark - ConfigureSubView
- (void)configureSubView
{
    //排名label
    UILabel *rankLabel = [[UILabel alloc] init];
    rankLabel.textColor = MEDGrayColor(51);
    rankLabel.font = MEDSYSFont(14);
    rankLabel.textAlignment = NSTextAlignmentLeft;
    rankLabel.text = @"当前排名:  无";
    _rankLabel = rankLabel;
    [self.contentView addSubview:_rankLabel];
    
    //分数
    UILabel *scoreLebel = [[UILabel alloc] init];
    scoreLebel.textColor = MEDGrayColor(51);
    scoreLebel.font = MEDSYSBoldFont(22);
    scoreLebel.text = @"0分";
    _scoreLabel = scoreLebel;
    [self.contentView addSubview:_scoreLabel];
    
    //进度条
    MEDScoreProgressBar *scoreProgressBar = [[MEDScoreProgressBar alloc] init];
    scoreProgressBar.backgroundColor = [UIColor whiteColor];
    self.scoreProgressBar = scoreProgressBar;
    [self.contentView addSubview:_scoreProgressBar];
    
    //操作页面
    MEDScoreOperationView *operationV = [[MEDScoreOperationView alloc] init];
    operationV.backgroundColor = [UIColor whiteColor];
    self.operationView = operationV;
    
    MEDWeakSelf(self);
    self.operationView.rankBtnClicked = ^(UIButton *button) {
        if (weakself.rankBtnClicked) {
            weakself.rankBtnClicked(button);
        }
    };
    [self.contentView addSubview:_operationView];
}

#pragma mark - Frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat padding = 10.0f;
    //排名Frame
    CGFloat rankLY = 25.0f;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize titleSize_rank = [self.rankLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    self.rankLabel.frame = CGRectMake(padding, rankLY, titleSize_rank.width, padding*2);
    
    //分数frame
    CGSize titleSize_score = [self.scoreLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:22] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    CGFloat scoreLX = CGRectGetMaxX(self.rankLabel.frame)+padding*5;
    CGFloat scoreLY = 25.0f;
    CGFloat scoreLW = titleSize_score.width;
    CGFloat scoreLH = scoreLY;
    self.scoreLabel.frame = CGRectMake(scoreLX, scoreLY, scoreLW, scoreLH);
    self.scoreLabel.centerY = self.rankLabel.centerY;
    
    //进度页面frame
    CGFloat progressX = padding*2;
    CGFloat progressY = CGRectGetMaxY(self.scoreLabel.frame)+10;
    CGFloat progressRPadding = SCREEN_WIDTH-(progressX*2);
    self.scoreProgressBar.frame = CGRectMake(progressX, progressY, progressRPadding, 10);
    
    //操作页面
    CGFloat operationVY = CGRectGetMaxY(self.scoreProgressBar.frame) + 10;
    self.operationView.frame = CGRectMake(0, operationVY, SCREEN_WIDTH, 50);
}

#pragma mark - setData
-(void)setRankData:(NSDictionary *)rankData
{
    self.rankLabel.text = [NSString stringWithFormat:@"当前排名: %@", rankData[@"ranking"]];
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f分", [rankData[@"personalTotalScore"] floatValue]];
    self.scoreProgressBar.percent = [[NSString stringWithFormat:@"%.1f分", [rankData[@"personalTotalScore"] floatValue]] floatValue];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

