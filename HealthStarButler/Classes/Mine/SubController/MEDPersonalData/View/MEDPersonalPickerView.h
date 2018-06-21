//
//  MEDPersonalPickerView.h
//  健康之星管家
//
//  Created by 朱慕之 on 2016/12/13.
//  Copyright © 2016年 Meridian. All rights reserved.
//


#import <UIKit/UIKit.h>

//类型种类
typedef NS_ENUM(NSInteger, PICKERTYPE) {
    GenderArray, //性别
    HeightArray, //身高
    DeteArray    //生日
    //体重、所在地....
};

@protocol MEDPersonalPickerViewDelegate <NSObject>
@optional;
- (void)PickerSelectorIndixString:(NSString *)str;
@end

@interface MEDPersonalPickerView : UIView

/**Picker的标题*/
@property (nonatomic, assign) PICKERTYPE arrayType;         //类型
@property (nonatomic, strong) NSArray *customArr;
@property (nonatomic,assign)id<MEDPersonalPickerViewDelegate>delegate;


//#pragma mark - 默认选择
//- (void)setDefaultChoiceWithPickerType:(PICKERTYPE)type {
//    if (type == DeteArray) {
//        [_pickerView selectRow:1 inComponent:80 animated:YES];
//        [_pickerView selectRow:2 inComponent:3 animated:YES];
//        [_pickerView selectRow:3 inComponent:2 animated:YES];
//    }else if (type == HeightArray) {
//        [_pickerView selectRow:1 inComponent:170 animated:YES];
//    }
//}


@end

