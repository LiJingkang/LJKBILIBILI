//
//  BLDataTool.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/14.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLDataTool.h"
#import "BLHttpTool.h"
#import "BLCommendModel.h"
#import "MJExtension.h"

#define CellDidClickUrl @"http://api.bilibili.com/x/reply?_device=android&_hwid=919040e503776159&appkey=c1b107428d337928&build=417000&oid=%@&platform=android&pn=1&ps=20&sort=0&type=1&sign=812b033846599a1b3fe94a836b48a9e6"

@implementation BLDataTool

+ (void)GETCommentData:(BLBaseCellModel *)baseCellModel success:(void (^)(BLCommendModel *))success failure:(void (^)(NSError *))failure
{
    NSString *urlString = [NSString stringWithFormat:CellDidClickUrl ,  baseCellModel.param];

    [BLHttpTool GET:urlString parameters:nil
            success:^(id responseObject) {

                NSDictionary *dic = [responseObject objectForKey:@"data"];
                BLCommendModel *commendModel = [BLCommendModel objectWithKeyValues:dic];
                success(commendModel);

            }
            failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
}
@end
