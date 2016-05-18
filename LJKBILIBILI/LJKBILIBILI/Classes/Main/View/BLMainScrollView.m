//
//  BLMainScrollView.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/9.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLMainScrollView.h"
#import "BLConst.h"
#import "BLBaseViewController.h"
#import "BLCommendViewController.h"
#import "BLOnePlayController_new.h"




@implementation BLMainScrollView



- (void)awakeFromNib
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    self.bounces = NO;

    CGFloat screenWidth = mainScreen.bounds.size.width;

    for (int i = 0; i <= 5; i++) {
        if (i == 1) {
            BLCommendViewController *view = [[BLCommendViewController alloc] initWithFrame:CGRectMake(i * screenWidth, 0, screenWidth, mainScreen.bounds.size.height)];
            [self addSubview:view];
        }

        if (i != 1) {
            BLBaseViewController *view =  [[BLBaseViewController alloc] initWithFrame:CGRectMake(i * screenWidth, 0, screenWidth, mainScreen.bounds.size.height)];
                [self addSubview:view];

        }
        

    }

    


    self.contentSize = CGSizeMake(6 * screenWidth, 0);
    // 一开始就显示第二页
    [self setContentOffset:CGPointMake(mainScreen.bounds.size.width, 0)];
    self.pagingEnabled = YES;
}

@end
