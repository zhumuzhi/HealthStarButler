//
//  MEDCollectionCategoryModel.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDCollectionCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *subcategories;

@end

@interface MEDSubCategoryModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end

