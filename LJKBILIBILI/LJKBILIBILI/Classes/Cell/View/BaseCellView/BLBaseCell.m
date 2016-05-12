//
//  BLBaseCell.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/12.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLBaseCell.h"

@implementation BLBaseCell

#pragma mark - 成员属性
- (void)setCellModel:(BLBaseCellModel *)cellModel
{
//    _cellModel = cellModel;

    NSLog(@"我是傻逼_setCellModel");
    
}



#pragma mark - 初始化
+ (instancetype)cellWithNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLBaseCell" owner:nil options:nil] lastObject];
}

@end
