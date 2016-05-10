//
//  BLCommendViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/9.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommendViewController.h"
#import "BLConst.h"
#import <AFNetworking.h>
#import "BLHttpTool.h"
#import "BLResultItem.h"
#import "MJExtension.h"
#import "BLADCell.h"


#define firstUrl @"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000"

@interface BLCommendViewController ()

/**
 *  请求返回的结果数组。 / 里面存放的是Item的模型
 */
@property (nonatomic, strong) NSArray *resultItemArray;



@end

@implementation BLCommendViewController


#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    
    BLADCell *ADCell = [BLADCell adCell];
//    ADCell.frame = CGRectMake(0, 0, mainScreen.bounds.size.width, mainScreen.bounds.size.height);


    [self addSubview:ADCell];





    [self initCollectionView];

    [self getCommendListModel];

    return self;
}


#pragma mark - 私有方法
- (void)initCollectionView
{
    
}

/**
 *  获取网络请求返回的数组，把他转换成模型
 */
- (void)getCommendListModel
{
    NSString *urlString = firstUrl;

    [BLHttpTool GET:urlString parameters:nil
            success:^(id responseObject) {
                     // 取出结果返回的结果数组
                     NSArray *resultArray = [responseObject valueForKey:@"result"];

                     // 字典数组 ---> 模型数组
                    NSArray *resultItemArray = [BLResultItem objectArrayWithKeyValuesArray:resultArray];
                    self.resultItemArray = resultItemArray;
                    }
            failure:^(NSError *error) {

                    }];
}



@end
