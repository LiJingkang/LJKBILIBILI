//
//  BLDataTool.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLBaseCellModel.h"
#import "BLCommendModel.h"

@interface BLDataTool : NSObject




+ (void)GETCommentData:(BLBaseCellModel *)baseCellModel
    success:(void (^)(BLCommendModel *blCommendModel))success
    failure:(void (^)(NSError *error))failure;


@end
