//
//  BLResultItem.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/10.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLResultItem.h"
#import "MJExtension.h"
#import "BLBaseCell.h"

@implementation BLResultItem


- (NSDictionary *)objectClassInArray
{
    return @{@"body" : [BLBaseCell class]};
}

@end
