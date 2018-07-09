//
//  MEDPersonalPickerView.m
//  健康之星管家
//
//  Created by 朱慕之 on 2016/12/13.
//  Copyright © 2016年 Meridian. All rights reserved.
//

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
#define hScale ([UIScreen mainScreen].bounds.size.height) / 667
#define kfont 18 //字体大小

#import "MEDPersonalPickerView.h"

@interface MEDPersonalPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong)UIView *backgroudView;          //大背景
@property (nonatomic,strong)UIButton *cancelButton;         //取消按钮
@property (nonatomic,strong)UIButton *saveButton;           //保存按钮
@property (nonatomic,strong)UIPickerView *pickerView;       //PickerView
@property (nonatomic,strong)NSMutableArray *array;          //数据数组
@end

@implementation MEDPersonalPickerView

//创建UI界面
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.array = [NSMutableArray array];
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = MEDRGBA(51, 51, 51, 0.8);
        
        //大背景
        self.backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 260*hScale)];
        self.backgroudView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroudView];
        [self showAnimation];
        
        //灰色按钮条
        UIView *titleBackView = [[UIView alloc] init];
        titleBackView.backgroundColor = [UIColor lightGrayColor];
        titleBackView.frame  = CGRectMake(0, 0, kScreenWidth, 44);
        [self.backgroudView addSubview:titleBackView];
        
        //取消按钮
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.frame = CGRectMake(0, 0, 50, 44);
        [titleBackView addSubview:self.cancelButton];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //保存按钮
        self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.saveButton.frame = CGRectMake(kScreenWidth - self.cancelButton.frame.size.width, 0, 50, 44);
        [titleBackView addSubview:self.saveButton];
        self.saveButton.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [self.saveButton addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //选择器
        self.pickerView = [UIPickerView new];
        self.pickerView.frame = CGRectMake(0, 40, kScreenWidth, 260*hScale - titleBackView.frame.size.height);
        [self.backgroudView addSubview:self.pickerView];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
    }
    return self;
}

//隐藏动画
- (void)hideAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.backgroudView.frame;
        frame.origin.y = kScreenHeight;
        self.backgroudView.frame = frame;
    } completion:^(BOOL finished) {
        [self.backgroudView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

//显示动画
- (void)showAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.backgroudView.frame;
        frame.origin.y = kScreenHeight-260*hScale;
        self.backgroudView.frame = frame;
    }];
}


- (void)setCustomArr:(NSArray *)customArr {
    _customArr = customArr;
    [self.array addObject:customArr];
}

- (void)setArrayType:(PICKERTYPE)arrayType {
    _arrayType = arrayType;
    switch (arrayType) {
        case GenderArray:
        {
            [self.array addObject:@[@"男",@"女"]];
        }
            break;
        case HeightArray:
        {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 80; i <= 250; i++) {
                NSString *str = [NSString stringWithFormat:@"%d",i];  //修改了体重显示
                [array addObject:str];
            }
            [self.array addObject:(NSArray *)array];
        }
            break;
        case DeteArray:
        {
            [self creatDate];
        }
            break;
            //保留的体重
            //        case weightArray:
            //        {
            //            self.selectLb.text = @"选择体重";
            //            NSMutableArray *arr = [NSMutableArray array];
            //            for (int i = 30; i <= 200; i++) {
            //
            //                NSString *str = [NSString stringWithFormat:@"%d",i];
            //                [arr addObject:str];
            //            }
            //            [self.array addObject:(NSArray *)arr];
            //        }
            //            break;
        default:
            break;
    }
}

- (void)creatDate {
    NSMutableArray *yearArray = [[NSMutableArray alloc] init];
    for (int i = 1800; i <= 2050 ; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%d.",i]];//修改了年月日
    }
    [self.array addObject:yearArray];
    NSMutableArray *monthArray = [[NSMutableArray alloc]init];
    for (int i = 1; i < 13; i ++) {
        [monthArray addObject:[NSString stringWithFormat:@"%d.",i]];//修改了年月日
    }
    [self.array addObject:monthArray];
    NSMutableArray *daysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i < 32; i ++) {
        [daysArray addObject:[NSString stringWithFormat:@"%d",i]];//修改了年月日
    }
    [self.array addObject:daysArray];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentYear = [NSString stringWithFormat:@"%@.",[formatter stringFromDate:date]];
    [self.pickerView selectRow:[yearArray indexOfObject:currentYear] inComponent:0 animated:YES];
//    [self.pickerView selectRow:[yearArray indexOfObject:currentYear]+81*50 inComponent:0 animated:YES];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth = [NSString stringWithFormat:@"%ld.",(long)[[formatter stringFromDate:date]integerValue]];
    [self.pickerView selectRow:[monthArray indexOfObject:currentMonth]+12*50 inComponent:1 animated:YES];
    [formatter setDateFormat:@"dd"];
    NSString *currentDay = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    [self.pickerView selectRow:[daysArray indexOfObject:currentDay]+31*50 inComponent:2 animated:YES];
}



#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.array.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    if (self.arrayType == DeteArray) {
        return arr.count*100;
    }else{
        return arr.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
}





- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.arrayType == DeteArray) {
        return 60;
    }else{
        return 110;
    }
    
}

#pragma mark-----点击方法

- (void)cancelButtonClick {
    //    MYLog(@"点击了取消按钮");
    [self hideAnimation];
    
}

- (void)completeBtnClick {
    //    MYLog(@"点击了完成按钮");
    NSString *fullStr = [NSString string];
    for (int i = 0; i < self.array.count; i++) {
        
        NSArray *arr = [self.array objectAtIndex:i];
        if (self.arrayType == DeteArray) {
            
            NSString *str = [arr objectAtIndex:[self.pickerView selectedRowInComponent:i]% arr.count];
            fullStr = [fullStr stringByAppendingString:str];
            
        }else{
            
            NSString *str = [arr objectAtIndex:[self.pickerView selectedRowInComponent:i]];
            fullStr = [fullStr stringByAppendingString:str];
        }
        
    }
    [self.delegate PickerSelectorIndixString:fullStr];
    [self hideAnimation];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideAnimation];
}

@end
