//
//  MEDPerson.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/28.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEDDog;

@interface MEDPerson : NSObject
{
    @private
    CGFloat _height;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) MEDDog *dog;

- (void)logHeight;

@end
