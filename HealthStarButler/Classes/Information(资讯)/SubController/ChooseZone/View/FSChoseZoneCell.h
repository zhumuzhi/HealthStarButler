//
//  FSChoseZoneCell.h
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

//#import "FSBaseTableViewCell.h"
@class FSChoseZoneMData,FSChoseZoneCell;
@protocol FSChoseZoneCellDelegate <NSObject>
- (void)choseZoneCell: (FSChoseZoneCell *)cell choseZoneMData: (FSChoseZoneMData *)choseZoneMData;
@end
@interface FSChoseZoneCell : UITableViewCell
@property (nonatomic , strong) FSChoseZoneMData *rowMData;
@property (nonatomic , weak) id <FSChoseZoneCellDelegate> delegate;

@end
