//
//  BLCommendModel.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLPageModel.h"

@interface BLCommendModel : NSObject
/**
 *  最热的评论
 */
@property (nonatomic, strong) NSArray *hots;

@property (nonatomic, assign) BOOL need_captcha;
/**
 *  存放评论基本信息
 */
@property (nonatomic, strong) BLPageModel *page;
/**
 *  存放所有评论 存放的是评论内容模型
 */
@property (nonatomic, strong) NSArray *replies;


@end
