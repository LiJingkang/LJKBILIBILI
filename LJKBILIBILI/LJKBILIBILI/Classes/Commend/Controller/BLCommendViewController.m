//
//  BLCommendViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/9.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommendViewController.h"
#import "BLConst.h"

@interface BLCommendViewController ()

@end

@implementation BLCommendViewController


#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.contentSize = CGSizeMake(mainScreen.bounds.size.width, mainScreen.bounds.size.height * 3);

    scrollView.delegate = self;

    [self addSubview:scrollView];


    return self;
}

@end
