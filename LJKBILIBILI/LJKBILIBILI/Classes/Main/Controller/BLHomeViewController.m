//
//  BLHomeViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/3.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLHomeViewController.h"
#import "BLTopView.h"


@interface BLHomeViewController ()

@property (nonatomic, strong) NSArray *topViewNavigationBarNameArray;


@property (weak, nonatomic) IBOutlet BLTopView *topView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;



@end


@implementation BLHomeViewController

#pragma mark - 成员变量
- (NSArray *)topViewNavigationBarNameArray
{
    if (_topViewNavigationBarNameArray == nil) {
        _topViewNavigationBarNameArray = [NSArray arrayWithObjects:@"直播",@"推荐",@"番剧",@"分区",@"关注",@"发现",nil];
    }
    return _topViewNavigationBarNameArray;
}


#pragma mark - 父类方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置topView
    self.topView.titleArray = self.topViewNavigationBarNameArray;

    


    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end
