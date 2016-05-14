//
//  BLCommendCellModel.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLMemberModel.h"
#import "BLContentModel.h"

@interface BLCommendCellModel : NSObject


@property (nonatomic, assign) NSInteger rpid;
@property (nonatomic, assign) NSInteger oid;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger root;
@property (nonatomic, assign) NSInteger parent;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger rcount;
@property (nonatomic, assign) NSInteger floor;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger ctime;


@property (nonatomic, strong) NSString *rpid_str;
@property (nonatomic, strong) NSString *root_str;
@property (nonatomic, strong) NSString *parent_str;

@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) NSInteger action;

/**
 *  存放的是会员模型
 */
@property (nonatomic, strong) BLMemberModel *member;

@property (nonatomic, strong) BLContentModel *content;


@property (nonatomic, strong) NSString *replies;








@end
