//
//  BLCommentController.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/16.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLCommendModel.h"


@interface BLCommentController : UIViewController

@property (nonatomic, copy) void (^topViewScroll)(CGFloat ScrollY);

/**
 *  评论模型
 */
@property (nonatomic, strong) BLCommendModel *commendModel;


@end
