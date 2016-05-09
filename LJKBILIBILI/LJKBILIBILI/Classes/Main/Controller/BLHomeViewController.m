//
//  BLHomeViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/3.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLHomeViewController.h"
#import "BLTopView.h"
#import "BLConst.h"
#import "BLSlidView.h"


@interface BLHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *topViewNavigationBarNameArray;

/**
 *  顶部窗口和导航栏
 */
@property (weak, nonatomic) IBOutlet BLTopView *topView;

/**
 *  主显示窗口
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

/**
 *  注册信息窗口(滑动弹出)
 */
@property (weak, nonatomic) BLSlidView *slidView;


@end


@implementation BLHomeViewController

#pragma mark - 成员变量
- (NSArray *)topViewNavigationBarNameArray
{
    if (_topViewNavigationBarNameArray == nil) {
#warning TODO:从json加载
        _topViewNavigationBarNameArray = [NSArray arrayWithObjects:@"直播",@"推荐",@"番剧",@"分区",@"关注",@"发现",nil];
    }
    return _topViewNavigationBarNameArray;
}


#pragma mark - 父类方法
- (void)viewDidLoad {
    [super viewDidLoad];

    // 弱引用
    __weak typeof(self) weakSelf = self;

    // 设置topView
    self.topView.titleArray = self.topViewNavigationBarNameArray;
    self.topView.clikBtn = ^(NSInteger tag) {
        weakSelf.mainScrollView.contentOffset = CGPointMake(mainScreen.bounds.size.width * (tag - 1), 0);
    };

    // 设置SlideView
    BLSlidView *slidView = [BLSlidView slideView];
    slidView.frame = CGRectMake( -mainScreen.bounds.size.width + 15, 0, mainScreen.bounds.size.width, mainScreen.bounds.size.height);
    [self.navigationController.view addSubview:slidView];
    [self.navigationController.view bringSubviewToFront:slidView];
    // 取得slidView
    self.slidView = slidView;


    // 保存显示Slide的代码
    self.slidView.showSlideView =
        ^() {
            [UIView animateWithDuration:0.5
                             animations:^{
                                 weakSelf.slidView.transform = CGAffineTransformMakeTranslation(mainScreen.bounds.size.width - 15, 0);
                                 weakSelf.slidView.shadowView.alpha = 0.55;
                             }];
        };

    


    

    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slideView) name:BLShowSlideNotification object:nil];



    // 主scrollView
    self.mainScrollView.delegate = self;

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 私有方法
- (void)slideView
{
    [self.view bringSubviewToFront:self.slidView]; // 最前显示

    [UIView animateWithDuration:0.5
                     animations:^{
                         self.slidView.transform = CGAffineTransformMakeTranslation(mainScreen.bounds.size.width - 15, 0);
                         self.slidView.shadowView.alpha = 0.55;
                     }];
}

#pragma mark - UIScrollView代理方法
// 当开始滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.topView.bottomBar.transform = CGAffineTransformMakeTranslation(((scrollView.contentOffset.x - mainScreen.bounds.size.width )/ 6) , 0);
    NSLog(@"%f",    scrollView.contentOffset.x);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tagNumber = (scrollView.contentOffset.x / mainScreen.bounds.size.width) + 1;
    [self.topView changeButtonColor:tagNumber];
}


@end
