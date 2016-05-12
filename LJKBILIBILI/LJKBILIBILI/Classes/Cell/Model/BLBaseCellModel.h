//
//  BLBaseCellModel.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/12.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLBaseCellModel : NSObject

/**
 *  cell的标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *style;

/**
 *  cell的图片
 */
@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *param;

/**
 *  goto
 */
@property (nonatomic, copy) NSString *goto_change;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *play;

@property (nonatomic, assign) NSInteger danmaku;

@end
