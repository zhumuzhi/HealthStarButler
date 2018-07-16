//
//  FSCheckSliderController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/16.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCheckSliderController.h"
#import "FSCheckCodeSlider.h"

@interface FSCheckCodeController ()
//{
//    UIImageView *imgView;
//}
@property (nonatomic ,strong)FSCheckCodeSlider *slider;
@property (nonatomic ,strong)UILabel *label;

@end

@implementation FSCheckSliderController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self createSlider];
}

- (void)createSlider{
    _slider = [[FSCheckCodeSlider alloc]initWithFrame:CGRectMake(0, 0, SliderWidth, SliderHeight)];
    _slider.center = self.view.center;

//    _slider.minimumValue = 9;// 设置最小值
//    _slider.maximumValue = 11;// 设置最大值
//    _slider.value = (slider.minimumValue + slider.maximumValue) / 2;// 设置初始值

    //    slider.minimumTrackTintColor = [UIColor greenColor]; //滑轮左边颜色，如果设置了左边的图片就不会显示
    //    slider.maximumTrackTintColor = [UIColor redColor]; //滑轮右边颜色，如果设置了右边的图片就不会显示
    //    slider.thumbTintColor = [UIColor redColor];//设置了滑轮的颜色，如果设置了滑轮的样式图片就不会显示

    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SliderWidth, SliderHeight)];
    _label.center = self.view.center;
    _label.text = SliderLabelText;
    _label.font = [UIFont systemFontOfSize:SliderLabelFont];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = SliderLabelTextColor;
    _label.layer.masksToBounds = YES;
    _label.layer.cornerRadius = SliderHeight/2;
    _label.layer.borderWidth = 1;
    _label.layer.borderColor = SliderLabelBorderColor;
    [self.view addSubview:_label];

    _slider.continuous = YES; // 设置连续变化
    _slider.layer.cornerRadius = SliderHeight/2;
    _slider.layer.masksToBounds = YES;
    _slider.minimumTrackTintColor = [UIColor clearColor];
    _slider.maximumTrackTintColor = [UIColor clearColor];
    [_slider setThumbImage:[UIImage imageNamed:@"go_top"] forState:UIControlStateNormal];
    //    _slider.minimumValueImage = [UIImage imageNamed:@"go_top"];
    //    _slider.maximumValueImage = [UIImage imageNamed:@"go_top"];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];


    //这里创建了一个跟滑块相同的imageview覆盖在文字上面，并在sliderValueChanged方法中让其跟着滑块滑动。
//    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_slider.frame.origin.x-2, _slider.frame.origin.y-2, ThumbImageWidth+4, ThumbImageHeight+4)];
//    imgView.image = [UIImage imageNamed:@"go_top"];
//    [self.view addSubview:imgView];
}

- (void)sliderValueChanged:(UISlider *)slider{
    
    [_slider setValue:slider.value animated:NO];
    if (slider.value >0) {
        _slider.minimumTrackTintColor = SliderMinimumTrackTintColor;
    }else{
        _slider.minimumTrackTintColor = [UIColor clearColor];
    }
//    imgView.center = CGPointMake(_slider.frame.origin.x+slider.value*(SliderWidth-ThumbImageWidth)+ThumbImageWidth/2, _slider.frame.origin.y+ThumbImageHeight/2);

    if (!slider.isTracking && slider.value != 1) {
        [_slider setValue:0 animated:YES];
        if (slider.value >0) {
            _slider.minimumTrackTintColor = SliderMinimumTrackTintColor;
        }else{
            _slider.minimumTrackTintColor = [UIColor clearColor];
        }
//        imgView.frame = CGRectMake(_slider.frame.origin.x-2, _slider.frame.origin.y-2, ThumbImageWidth+4, ThumbImageHeight+4);
    }
}


@end
