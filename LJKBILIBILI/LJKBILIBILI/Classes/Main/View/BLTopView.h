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
/**
 *  点击按钮调用的block
 */
@property (nonatomic, copy) void (^clikBtn)(NSInteger);


/**
 *   底部指示条
 */
@property (nonatomic, weak) UIView *bottomBar;

/**
 *  提供一个外部方法来修改字体的颜色
 */
- (void)changeButtonColor:(NSInteger)btnTag;




@end
