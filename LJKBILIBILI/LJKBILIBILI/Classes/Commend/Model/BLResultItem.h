//
//  BLResultItem.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/10.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLResultItemHead.h"

@interface BLResultItem : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) BLResultItemHead *head;

/**
 *  存放的是BaseCell模型
 */
@property (nonatomic, strong) NSArray *body;

@end
