//
//  BLMemberModel.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLMemberModel : NSObject

@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *DisplayRank;

/**
 *  存放的是字典，等转模型
 */
@property (nonatomic, strong) NSDictionary *level_info;
/**
 *  存放的是字典，等转模型
 */
@property (nonatomic, strong) NSDictionary *pendant;
/**
 *  存放的是字典，等转模型
 */
@property (nonatomic, strong) NSDictionary *nameplate;

@end
