//
//  BLContentModel.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLContentModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger plat;

@property (nonatomic, copy) NSString *device;

@property (nonatomic, strong) NSArray *members;

@end
