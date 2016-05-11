//
//  BLBaseViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/9.
//  Copyright © 2016年 LJK. All rights reserved.
//  内部的6个子控制器都继承自这个控制器

#import "BLBaseViewController.h"
#import "BLConst.h"

@interface BLBaseViewController () <UIScrollViewDelegate>

@end

@implementation BLBaseViewController



#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    self.backgroundColor = BLRandomColor;


    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:frame];
    scroll.backgroundColor = [UIColor blueColor];
    scroll.contentSize = CGSizeMake(1000, 1000);

    scroll.alwaysBounceVertical = YES;
    scroll.delegate = self;

    [self addSubview:scroll];

    return self;
}


#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BLScrollToTop object:@(scrollView.contentOffset.y    )];
    }
}

@end
