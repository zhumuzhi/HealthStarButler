//
//  MEDSymptomVC.m
//  健康之星管家
//
//  Created by 夏帅 on 15/11/19.
//  Copyright (c) 2015年 Meridian. All rights reserved.
//

#import "MEDSymptomVC.h"

@interface MEDSymptomVC ()
{
    UIView *_backView;
}
@end

@implementation MEDSymptomVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setNavigationTitle:_diseaseName];
    self.navigationItem.title = _diseaseName;
    self.view.backgroundColor = MEDGrayColor(243);
    [self initUI];

}


- (void)initUI {
    
    //背景
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationHeight+20, kScreenWidth, 50)];
    _backView.backgroundColor = [UIColor whiteColor];
    
    //标题Label
    UILabel *lable= [[UILabel alloc]initWithFrame:CGRectMake(20, 0, _diseaseName.length*15, 44)];
    lable.text = _diseaseName;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = MEDGrayColor(102);
    lable.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:lable];
    
    //线条
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = MEDGrayColor(243);
    line1.frame = CGRectMake(0, CGRectGetMaxY(lable.frame), kScreenWidth, 1);
    [_backView addSubview:line1];

//上个版本的类型标签
//    UILabel *lableDepartment = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable.frame), CELL_HEIGHT*2/5, _departmentName.length*11, CELL_HEIGHT/3)];
//    lableDepartment.text = _departmentName;
//    lableDepartment.layer.borderWidth = 0.5;
//    lableDepartment.layer.borderColor = [UIColor colorWithRed:215/255.0 green:150/255.0 blue:255/255.0 alpha:1].CGColor;
//    lableDepartment.textAlignment = NSTextAlignmentCenter;
//    lableDepartment.textColor = [UIColor colorWithRed:215/255.0 green:150/255.0 blue:255/255.0 alpha:1];
//    lableDepartment.font = [UIFont systemFontOfSize:10];
//    [_backView addSubview:lableDepartment];
    
    //详情Label
    UILabel *detialLable = [[UILabel alloc]init];
    if(_clinicalExplain == nil) {
        detialLable.text = @"暂无信息";
    }else {
        detialLable.text = [NSString stringWithFormat:@"%@",_clinicalExplain];
    }
    CGFloat contentW = self.view.bounds.size.width - detialLable.frame.origin.x - 40;
    // label的字体 HelveticaNeue  Courier
    detialLable.textColor = MEDGrayColor(102);
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
    detialLable.font = fnt;
    detialLable.numberOfLines = 0;
    detialLable.lineBreakMode = NSLineBreakByWordWrapping;
    // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
    CGRect tmpRect = [detialLable.text boundingRectWithSize:CGSizeMake(contentW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    CGFloat contentH = tmpRect.size.height;
    //MYLog(@"调整后的显示宽度:%f,显示高度:%f",contentW,contentH);
    detialLable.frame = CGRectMake(20, CGRectGetMaxY(lable.frame)+10, contentW,contentH);
    [_backView addSubview:detialLable];
    
    _backView.frame = CGRectMake(0, kNavigationHeight, kScreenWidth, contentH + 44+40+5);
    [self.view addSubview:_backView];

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = MEDGrayColor(243);
    line.frame = CGRectMake(0, CGRectGetMaxY(detialLable.frame)+10, kScreenWidth, 1);
    [_backView addSubview:line];
    
//    UIImageView *greenPoint = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(line.frame)+10, 5, 5)];
//    greenPoint.image = [UIImage imageNamed:@"13-13"];
//    [_backView addSubview:greenPoint];
    
    UILabel *tips= [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(line.frame)-10, kScreenWidth-45, 44)];
    tips.text = _diseaseName;
    tips.textAlignment = NSTextAlignmentLeft;
    tips.text = @"本系统仅作为选择就诊科室参考，不能代替临床诊断";
    tips.textColor = [UIColor blackColor];
    tips.font = [UIFont systemFontOfSize:10];
    [_backView addSubview:tips];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
