//
//  BLResultItemHead.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/10.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLResultItemHead : NSObject



@property (nonatomic, copy) NSString *param;
/**
 *  goto，在赋值的时候进行修改
 */
@property (nonatomic, copy) NSString *goto_change;

@property (nonatomic, copy) NSString *style;

@property (nonatomic, copy) NSString *title;

@end
