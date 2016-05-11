//
//  BLADCell.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/10.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLADCell.h"
#import "BLHttpTool.h"
#import "MJExtension.h"
#import "BLADModal.h"
#import "BLConst.h"
#import "UIImageView+WebCache.h"



#define ADUrl @"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=banner&platform=android&screen=xxhdpi&test=0&ts=1450886166000&sign=cc078495cc06a087f954e29724bf7958"

@interface BLADCell () <UIScrollViewDelegate>

/**
 *  广告ScrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *ADScrollView;

/**
 *  页面指示器
 */
@property (weak, nonatomic) IBOutlet UIPageControl *PageControl;

/**
 *  广告数量
 */
@property (nonatomic, assign) NSInteger ADCount;

@property (nonatomic, strong) NSArray *ADItemModelArray;


@end

@implementation BLADCell


#pragma mark - 父类方法

- (void)awakeFromNib
{
    [self getADModel];

}


#pragma mark - 初始化方法
+ (instancetype)adCell
{
    // 从mainBundle里加载
    return [[[NSBundle mainBundle] loadNibNamed:@"BLADCell" owner:nil options:nil] lastObject];
}

#pragma mark - 私有方法
- (void)getADModel
{
    [BLHttpTool GET:ADUrl parameters:nil
            success:^(id responseObject) {

                NSArray *ADItemArray = [responseObject valueForKey:@"list"];

                NSArray *ADItemModelArray = [BLADModal objectArrayWithKeyValuesArray:ADItemArray];
                self.ADItemModelArray = ADItemModelArray;

                // 当请求完成以后在设置ADScrollView
                [self setADScrollView];
                }
            failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
}

- (void)setADScrollView
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = mainScreen.bounds.size.width;
    CGFloat imageH = (imageW / 640) * 200;

    for (int i = 0; i < self.ADItemModelArray.count; i++) {

        UIImageView *imageView = [[UIImageView alloc] init];
        BLADModal *admodel = self.ADItemModelArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:admodel.imageurl]];
        imageView.backgroundColor = BLRandomColor;
        imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.contentMode = UIViewContentModeScaleToFill;

        [self.ADScrollView addSubview:imageView];
    }

    self.ADScrollView.contentSize = CGSizeMake(imageW * self.ADItemModelArray.count , imageH); //设置滚动范围
    NSLog(@"__%f",imageW * self.ADItemModelArray.count);

    self.ADScrollView.contentOffset = CGPointMake(0, 0);
    self.ADScrollView.showsHorizontalScrollIndicator = NO;
    self.ADScrollView.pagingEnabled = YES; // 是否分页
    self.ADScrollView.delegate = self;


}

#pragma mark - 调用
- (void)setScrollViewDelegate:(id)controller
{
    self.ADScrollView.delegate = controller;
}

#pragma mark - scrollViewDelegate






@end
