//
//  BLBaseCellModel.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/12.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLBaseCellModel.h"
#import "BLBaseCell.h"
#import "MJExtension.h"

@implementation BLBaseCellModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"goto_change" : @"goto"};
}

@end

