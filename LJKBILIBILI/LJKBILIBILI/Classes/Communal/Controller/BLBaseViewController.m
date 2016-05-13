//
//  BLBaseViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/9.
//  Copyright © 2016年 LJK. All rights reserved.
//  内部的6个子控制器都继承自这个控制器

#import "BLBaseViewController.h"
#import "BLConst.h"
#import "BLADCell.h"

@interface BLBaseViewController () <UIScrollViewDelegate>

@end

@implementation BLBaseViewController



#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    self.backgroundColor = BLRandomColor;

    return self;
}


#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BLScrollToTop object:@(scrollView.contentOffset.y    )];
    }


//        if (scrollCallback_ && ![scrollCallback_ isEqualToString:@""]) {
//            if (scrollView.contentOffset.y == 0.0) {
//                [self.rootContentView_ doluaString:[scrollCallback_ stringByReplacingOccurrencesOfString:@"arg_value" withString:@"top"]];
//            }else if (scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.contentSize.height)
//                [self.rootContentView_ doluaString:[scrollCallback_ stringByReplacingOccurrencesOfString:@"arg_value" withString:@"bottom"]];
//        }

}

@end
