//
//  BLCellItem.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/11.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCellItem.h"

@implementation BLCellItem


#pragma mark - 初始化方法
+ (instancetype)cellItem
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLCellItem" owner:nil options:nil] lastObject];
}

@end
