//
//  BLCommendModel.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommendModel.h"
#import "BLCommendCellModel.h"

@implementation BLCommendModel

/**
 *  实现这个方法，会自动将模型里面的数组转化为模型数组
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"hots" : [BLCommendCellModel class],
             @"replies" : [BLCommendCellModel class]};
}


@end
