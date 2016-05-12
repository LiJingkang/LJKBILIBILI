//
//  BLResultItem.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/10.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLResultItem.h"
#import "MJExtension.h"
#import "BLBaseCellModel.h"

@implementation BLResultItem


- (NSDictionary *)objectClassInArray
{
    return @{@"body" : [BLBaseCellModel class]};
}

@end
