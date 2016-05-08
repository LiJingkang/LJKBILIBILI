//
//  BLTopView.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/3.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLTopView : UIView


/**
 *  数组中保存的是按钮的名称
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) void (^clikBtn)(NSInteger);




@end
