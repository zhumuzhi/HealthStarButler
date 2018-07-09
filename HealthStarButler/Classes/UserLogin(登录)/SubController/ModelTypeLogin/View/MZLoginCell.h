//
//  MZLoginCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZDataModel, MZLoginCell;
@protocol MZLoginCellDelegate <NSObject>
@optional
- (void)loginCell: (MZLoginCell *)loginCell button: (id)button;
- (void)loginCell: (MZLoginCell *)loginCell textField: (UITextField *)textField;
@end


@interface MZLoginCell : UITableViewCell

@property (nonatomic , strong)MZDataModel *dataModel;
@property (nonatomic , weak) id <MZLoginCellDelegate>delegate;

@end
