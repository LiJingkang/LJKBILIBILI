//
//  BLCommentHeader.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/17.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommentHeader.h"

@implementation BLCommentHeader







+ (instancetype)commentHeader
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLCommentHeader" owner:nil options:nil] lastObject];
}




@end
