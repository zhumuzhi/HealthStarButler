//
//  MEDScoreOperationView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/2.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDScoreOperationView.h"
#import "MEDScoreButton.h"


@implementation MEDScoreOperationView

#pragma mark - Init
-(instancetype)initWithFrame:(CGRect)frame
{
    if ( self == [super initWithFrame:frame]){
        //初始化控件
        
        //横向分割线
        CGFloat barPadding = 10.0f;
        CGFloat RBarPadding = (barPadding * 2);
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(barPadding, barPadding/2, SCREEN_WIDTH-RBarPadding, 1)];
        lineView.backgroundColor = MEDGrayColor(232);
        [self addSubview:lineView];
        
        //按钮 (依从性/生理指标/生活习惯)
        MEDScoreButton *rankScoreBtn[3];
        NSArray *btnTitileArray = @[@"依从性",@"生理指标",@"生活习惯"];
        NSArray *btnTitleImages = @[@"home_m_icon1",@"home_m_icon2",@"home_m_icon0"];
        CGFloat rankScoreBtnY = 10.0f;
        CGFloat rankScoreBtnW = (SCREEN_WIDTH-2)/3;
        CGFloat rankScoreBtnH = 50.0f;
        for (NSInteger i = 0; i<btnTitileArray.count; i++) {
            rankScoreBtn[i] = [MEDScoreButton buttonWithType:UIButtonTypeCustom];
            rankScoreBtn[i].tag = i;
            CGFloat rankScoreBtnX = ((SCREEN_WIDTH-2)/3+1) *i;
            rankScoreBtn[i].frame = CGRectMake(rankScoreBtnX, rankScoreBtnY, rankScoreBtnW, rankScoreBtnH);
            [rankScoreBtn[i] initWithImage:btnTitleImages[i] andTitle:[btnTitileArray objectAtIndex:i]];
            [rankScoreBtn[i] addTarget:self action:@selector(scoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:rankScoreBtn[i]];
        }
        
        //竖直分割线
        UIView *btnGapLine[2];
        CGFloat btnGapLineY = 20.0f;
        CGFloat btnGapLineW = 1.0f;
        CGFloat btnGapLineH = 25.0f;
        for (int i=0; i<2; i++) {
            CGFloat btnGapLineX = (SCREEN_WIDTH-2)/3*(i+1)+i*0.5;
            btnGapLine[i] = [[UIView alloc] initWithFrame:CGRectMake(btnGapLineX, btnGapLineY, btnGapLineW, btnGapLineH)];
            btnGapLine[i].backgroundColor = MEDGrayColor(232);
            [self addSubview:btnGapLine[i]];
        }
    }
    return self;
}

#pragma mark - Event
- (void)scoreButtonClick:(UIButton *)button
{
    if (self.rankBtnClicked) {
        self.rankBtnClicked(button);
    }
}


#pragma mark - Frame
//设置frame
- (void)drawRect:(CGRect)rect {
    
    
}


@end
