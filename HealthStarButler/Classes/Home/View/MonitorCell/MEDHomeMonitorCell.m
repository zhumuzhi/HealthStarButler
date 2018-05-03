//
//  MEDHomeMonitorCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/3.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHomeMonitorCell.h"

@interface MEDHomeMonitorCell()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation MEDHomeMonitorCell

#pragma mark - Lazy

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"血压",@"血糖",@"血氧",@"体重",@"运动",@"睡眠",@"腰围",@"体温"];
    }
    return _titleArray;
}

- (NSArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = @[@"home_m_xueya",@"home_m_xuetang",@"home_m_xueyang",@"home_m_tizhong",@"home_m_yundong",@"home_m_shuimian",@"home_m_yaowei",@"home_m_tiwen"];
    }
    return _imageArray;
}


#pragma mark - Init
/** 遍历构造方法 */
+ (instancetype)homeMonitorCellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"homeMonitorCell";
    MEDHomeMonitorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MEDHomeMonitorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //设置背景颜色
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 添加子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self configureCellSubView];
    }
    return self;
}

/** 配置页面 */
-(void)configureCellSubView {
    
    CGFloat MARGIN = 10.0f;
    CGFloat backViewW = 75.0f;
    CGFloat backViewH = 65.0f; //每个按钮的背景高度
    CGFloat marginTop = 19.0f; // 第一行的View距离顶部的距离
    CGFloat monitorVH = backViewH*2 + marginTop*2; //188
    UIView *monitorView = [[UIView alloc] init];
    monitorView.frame = CGRectMake(0, 0, SCREEN_WIDTH, monitorVH);
    monitorView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:monitorView];
    
    
    int columns = 4; // 每一行btn的个数
    CGFloat marginX = (SCREEN_WIDTH - backViewW * columns) / (columns + 1);
    CGFloat marginY = MARGIN;
    for (int i = 0; i <self.titleArray.count; i++) {
        //背景
        UIView *btnBackView = [[UIView alloc] init];
        int row = i / columns;
        int col = i % columns;
        CGFloat backViewX = marginX + col * (backViewW + marginX);
        CGFloat backViewY = marginTop + row * (backViewH + marginY);
        btnBackView.frame = CGRectMake(backViewX, backViewY, backViewW, backViewH);
        [monitorView addSubview:btnBackView];
        //按钮
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        CGFloat btnW = 45.0f;
        CGFloat btnH = 45.0f;
        CGFloat btnX = 15.0f;
        CGFloat btnY = 0.0f;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(monitorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//            //禁用最后一个
//            if (button.tag == 7) {
//                button.userInteractionEnabled = NO;
//            }
        [btnBackView addSubview:button];
        
        //标题
        UILabel *title = [[UILabel alloc] init];
        CGFloat titleW = backViewW;
        CGFloat titleH = 20.0f;
        CGFloat titleX = 0.0f;
        CGFloat titleY = btnH;
        title.textColor = MEDGrayColor(102);
        title.frame = CGRectMake(titleX, titleY, titleW, titleH);
        title.font = MEDSYSFont(11);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = _titleArray[i];
        [btnBackView addSubview:title];
    }
}

- (void)monitorButtonClick:(UIButton *)button
{
    if (self.monitorBtnClicked) {
        self.monitorBtnClicked(button);
    }
}

#pragma mark - Frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - setData


- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
