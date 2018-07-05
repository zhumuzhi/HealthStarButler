//
//  MEDCommonAddCell.h
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDCommonAddCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

/**
 设置cell信息@param title cell左侧标题
@param desc  占位文字信息
@param type 键盘类型  0、表示正常键盘 1、表示数字键盘
@param text 填充文字
@param textFieldBlock 输入内容回调
*/
-(void)setCellInfo:(NSString*)title withInputDesc:(NSString*)desc withKeybordType:(NSInteger )type withText:(NSString *)text WithReturnBlock:(void (^)(NSString *result))textFieldBlock;


- (void)initCellWithTitle:(NSString*)title placeholder:(NSString*)placeholder KeybordType:(NSInteger)type text:(NSString *)text;

@end
