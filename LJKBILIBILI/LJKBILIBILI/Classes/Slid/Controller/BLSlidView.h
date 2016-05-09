//
//  BLSlidView.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/3.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSlidView : UIView

/**
 *  提供一个阴影属性进行修改
 */
@property (weak, nonatomic) UIView *shadowView;


/**
 *  提供一个初始化类方法
 */
+ (instancetype)slideView;

/**
 *  保存一段显示SlideView的block
 */
@property (nonatomic, copy) void (^showSlideView)();
@end
