//
//  FSAddressListNData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/10.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressListNData.h"
#import "FSAddressListMData.h"

@interface FSAddressListReqNData ()

@property (nonatomic, assign) FSAddressListRequstType requestType;

@end

@implementation FSAddressListReqNData

- (instancetype)initWithRequstType:(FSAddressListRequstType)type {
    if (self == [super init]) {
        self.requestType = type;
        if (type == FSAddressListRequstTypeList) {
            self.url = @"https://t.fsyuncai.com/membership/adminQueryAddressPerson.jhtml";
        }else if (type == FSAddressListRequstTypeDefault) {
            self.url = @"";
        }
    }
    return self;
}

- (NSMutableDictionary *)parametes{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    /** 地址列表 */
    if (self.requestType == FSAddressListRequstTypeList) {
//        dict[@"memberId"] = @(self.memberId);
        dict[@"memberId"] = @(15);
//        dict[@"type"] = @(self.type);
        dict[@"type"] = @(10);
        dict[@"pageNum"] = @(self.pageNum);
        dict[@"pageSize"] = @(self.pageSize);
    /** 设为默认地址 */
    }else if (self.requestType == FSAddressListRequstTypeDefault) {
        dict[@"shipAddId"] = @(self.shipAddId);
        dict[@"token"] = self.token;
    }
    return dict;
}

@end


@implementation FSAddressListResNData

- (void)parse:(NSDictionary *)dictionary {
    [super parse:dictionary];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        NSArray *list = dictionary[@"list"];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        if (![NSArray isEmptyArr:list]) {
            for (NSDictionary *dict in list) {
                /** 解析地址模型 */
                FSAddressListMData *addressListMData = [FSAddressListMData mj_objectWithKeyValues:dict];
                addressListMData.addressListDict = dict;
                NSArray *addressPersonList = dict[@"addressPersonList"];
                NSMutableArray *items = [NSMutableArray array];
                for (NSDictionary *addressPersonListDict in addressPersonList) {
                    /** 解析收货人模型 */
                    FSAddressListMData *personMData = [FSAddressListMData mj_objectWithKeyValues:addressPersonListDict];
                    personMData.addressListCellType = FSAddressListCellTypeConsignee;
                    personMData.cellHeight = kAutoWithSize(30);
                    [items addObject:personMData];
                }
                addressListMData.items = items.mutableCopy;
                [dataArray addObject:addressListMData];
            }
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger index = 0; index < dataArray.count; index++) {
                
                FSAddressListMData *sectionMData = [[FSAddressListMData alloc] init];
                FSAddressListMData *addressMData = [[FSAddressListMData alloc] init];
                
                FSAddressListMData *object = [dataArray by_ObjectAtIndex:index];
                sectionMData.addressListDict = object.addressListDict;
                
                /** 构造标签数据模型 */
                NSMutableArray *items = [NSMutableArray array];
                NSMutableArray *subItems = [NSMutableArray array];
                if (object.items.count) {
                    /** 如果有收货人 */
                    for (NSInteger i = 0; i<object.items.count; i++) {
                        FSAddressListMData *personMData = [object.items by_ObjectAtIndex:i];
                        personMData.ship_add_id = object.ship_add_id;
                        
                        [subItems addObject:personMData];
                    }
                }
                addressMData.cityName = object.cityName;
                addressMData.areaName = object.areaName;
                addressMData.provinceName = object.provinceName;
                addressMData.detail_address = object.detail_address;
                addressMData.is_default = object.is_default;
                addressMData.add_alias = object.add_alias;
                addressMData.ship_add_id = object.ship_add_id;
                NSString *address = [NSString stringWithFormat:@"%@%@%@%@",addressMData.provinceName.length ?addressMData.provinceName:@"" ,addressMData.cityName.length?addressMData.cityName:@"",addressMData.areaName.length ?addressMData.areaName:@"",addressMData.detail_address.length ?addressMData.detail_address:@""];
                
                CGSize addressSize = [address sizeWithFont:[UIFont fontWithName:@"PingFangSC-Light" size:kFont(12)] maxSize:CGSizeMake(kScreenWidth - 2 * kMargin10, MAXFLOAT)];
                addressMData.cellHeight = addressSize.height + kMargin10;
                
                NSString *defaultAddress = addressMData.is_default == YES ?@"默认":@"";
                NSString *projectName = addressMData.add_alias;
                NSString *limtLine = object.limitLine == 10  ?@"限行":@"不限行";
                NSMutableArray *tagItems = [NSMutableArray array];
                if ([defaultAddress isEqualToString:@"默认"]) {
                    [tagItems addObject:defaultAddress];
                }
                if (projectName.length && ![NSString isEmptyString:projectName]) {
                    [tagItems addObject:projectName];                  }
                if ([limtLine isEqualToString:@"限行"]) {
                    [tagItems addObject:limtLine];
                }
                
                NSMutableArray *tagItemArray = [NSMutableArray array];
                
                for (NSInteger index = 0; index < tagItems.count; index++) {
//                    [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(10)];
                    FSAddressListMData *tagObject = [[FSAddressListMData alloc] init];
                    tagObject.title = [tagItems by_ObjectAtIndex:index];
                    CGSize titleSize = [tagObject.title sizeWithFont:[UIFont fontWithName:@"PingFangSC-Regular" size:kFont(10)] maxSize:CGSizeMake(MAXFLOAT, kAutoWithSize(16))];
                    tagObject.tagWidth = titleSize.width + kMargin10 * 2;
                    if ([tagObject.title isEqualToString:@"默认"]) {
                        tagObject.backgroundColor = [UIColor colorWithHexString:@"#4A90E2"];
                    } else {
                        tagObject.backgroundColor = [UIColor colorWithHexString:@"#F08327"];
                    }
                    [tagItemArray addObject:tagObject];
                }
                addressMData.items = tagItemArray.copy;
                
                addressMData.addressListCellType = FSAddressListCellTypeAddress;
                FSAddressListMData *tagMData = [[FSAddressListMData alloc] init];
                tagMData.items = tagItemArray.copy;
                tagMData.cellHeight = kAutoWithSize(16) + kMargin5;
                tagMData.addressListCellType = FSAddressListCellTypeTag;
                
                FSAddressListMData *actionMData = [[FSAddressListMData alloc] init];
                actionMData.cellHeight = 44;
                actionMData.is_default = object.is_default;
                actionMData.ship_add_id = object.ship_add_id;
                sectionMData.addressListCellType = FSAddressListCellTypeAction;
                [items addObjectsFromArray:subItems];
                
                if (tagMData.items.count == 0) {
                    
                }else {
                    [items addObject:tagMData];
                }
                
                [items addObject:addressMData];
                [items addObject:actionMData];
                if (index == dataArray.count - 1) {
                    sectionMData.sectionFooterHeight = 10.f;
                }else {
                    sectionMData.sectionFooterHeight = 0.01f;
                }
                sectionMData.sectionHeaderHeight = 10.01f;
                sectionMData.items = items.mutableCopy;
                
                [array addObject:sectionMData];
            }
            self.dataArray = array;
            
        }
    }
}



@end
