//
//  MZFromModel.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZFromModel.h"

@implementation MZFromModel

- (NSMutableArray *)creatFromMData {
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *cellTypeNumArray =@[
                                 /** 头像 */
                                 @(MZFromCellTypeIcon),
                                 /** 姓名 */
                                 @(MZFromCellTypeName),
                                 /** 性别 */
                                 @(MZFromCellTypeSex),
                                 /** 电话号码 */
                                 @(MZFromCellTypePhone),
                                 /** 备注 */
                                 @(MZFromCellTypeContent),
                                 ];
    NSArray *leftTitleArray = @[
                                @"头像",
                                @"姓名",
                                @"性别",
                                @"手机号码",
                                @"备注",
                                ];
    NSArray *placeholderArray = @[
                                  @"",
                                  @"请输入姓名",
                                  @"",
                                  @"请选择手机号码",
                                  @"请输入备注",
                                  ];
    NSArray *imageNameArray = @[
                                @"setting_arrow",
                                @"",
                                @"",
                                @"",
                                @"",
                                ];
    NSArray *isShowStartArray = @[
                                  [NSNumber numberWithBool:YES],
                                  [NSNumber numberWithBool:YES],
                                  [NSNumber numberWithBool:YES],
                                  [NSNumber numberWithBool:NO],
                                  [NSNumber numberWithBool:YES],
                                  
                                  ];
    NSArray *cellHeightArray = @[
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 [NSNumber numberWithFloat:44],
                                 
                                 ];
    for (NSInteger index = 0; index < leftTitleArray.count; index++) {
        MZFromModel *fromModel = [[MZFromModel alloc]init];
        fromModel.leftTitle = leftTitleArray[index];
        NSNumber *isShowStartNum = isShowStartArray[index];
        NSNumber *cellHeightNum = cellHeightArray[index];
        NSNumber *cellTypeNum = cellTypeNumArray[index];
        
        fromModel.cellHeight = cellHeightNum.integerValue;
        fromModel.cellType = cellTypeNum.integerValue;
        fromModel.placeholder = placeholderArray [index];
        fromModel.imageName = imageNameArray[index];
        fromModel.isShowStar = isShowStartNum.integerValue;
        [dataArray addObject:fromModel];
        
    }
    return dataArray;
}



//- (NSMutableArray *)creatFromMData {
//    NSMutableArray *tempArray = [NSMutableArray array];
//    NSArray *dataArray = @[
//                           @{@"type":@(MZFromCellTypeIcon), @"title":@"头像", @"subTitle":@"", @"image":@"setting_arrow", @"isMust":[NSNumber numberWithBool:YES], @"cellHeight":[NSNumber numberWithFloat:44]},
//                           @{@"type":@(MZFromCellTypeName), @"title":@"姓名", @"subTitle":@"请输入姓名", @"image":@"", @"isMust":[NSNumber numberWithBool:YES], @"cellHeight":[NSNumber numberWithFloat:44]},
//                           @{@"type":@(MZFromCellTypeSex), @"title":@"性别", @"subTitle":@"", @"image":@"", @"isMust":[NSNumber numberWithBool:YES], @"cellHeight":[NSNumber numberWithFloat:44]},
//                           @{@"type":@(MZFromCellTypePhone), @"title":@"手机号码", @"subTitle":@"请选择手机号", @"image":@"", @"isMust":[NSNumber numberWithBool:NO], @"cellHeight":[NSNumber numberWithFloat:44]},
//                           @{@"type":@(MZFromCellTypeContent), @"title":@"备注", @"subTitle":@"请输入备注", @"image":@"", @"isMust":[NSNumber numberWithBool:YES], @"cellHeight":[NSNumber numberWithFloat:44]},
//                           ];
//    for (NSInteger index = 0; index < dataArray.count; index++) {
//        MZFromModel *fromModel = [[MZFromModel alloc] init];
//        fromModel.leftTitle = dataArray[index][@"type"];
//        NSNumber *isShowStartNum = dataArray[index][@"isMust"];
//        NSNumber *cellHeightNum = dataArray[index][@"cellHeight"];
//        NSNumber *cellTypeNum = dataArray[index][@"type"];
//        fromModel.cellHeight = cellHeightNum.integerValue;
//        fromModel.cellType = cellTypeNum.integerValue;
//        fromModel.placeholder = dataArray[index][@"subTitle"];
//        fromModel.imageName = dataArray[index][@"image"];
//        fromModel.isShowStar = isShowStartNum.integerValue;
//        [tempArray addObject:fromModel];
//    }
//    return tempArray;
//}


@end
