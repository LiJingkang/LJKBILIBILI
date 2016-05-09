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

@property (nonatomic, assign) CGFloat lastY;

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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveTopBar:) name:BLScrollToTop object:nil];



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

- (void)moveTopBar:(NSNotification *)notification
{
    // 取出移动的距离
    CGFloat moveY = [notification.object floatValue];
    // 上一次的位置减去这一次的位置，得到移动了正负数值  负 上移 / 正 下移
    CGFloat moveRY = moveY - self.lastY;
    // 如果>= -70 在第一行范围  并且向上移
    if (self.topView.transform.ty - moveRY >= -70 && self.topView.transform.ty - moveRY <= 0) {
        // 移动topView
        self.topView.transform = CGAffineTransformTranslate(self.topView.transform, 0, -moveRY);
        // 移动mainScrollView
        self.mainScrollView.transform = CGAffineTransformTranslate(self.mainScrollView.transform, 0, -moveRY);
    }
    // 如果 < -70 那么已经超过了第一行
    else if (self.topView.transform.ty - moveRY < -70) {
        // 第一行就不动了
        self.topView.transform = CGAffineTransformMakeTranslation(0, -70);
        // mainScrollView也不移动了
        self.mainScrollView.transform = CGAffineTransformMakeTranslation(0, -70);
    }
    // 如果向下移动到最底下   // 这两个都不改变
    else if (self.topView.transform.ty - moveRY > 0) {
        self.topView.transform = CGAffineTransformMakeTranslation(0, 0);

        self.mainScrollView.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    
    self.lastY = moveY;
}


#pragma mark - UIScrollView代理方法
// 当开始滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.topView.bottomBar.transform = CGAffineTransformMakeTranslation(((scrollView.contentOffset.x - mainScreen.bounds.size.width )/ 6) , 0);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tagNumber = (scrollView.contentOffset.x / mainScreen.bounds.size.width) + 1;
    [self.topView changeButtonColor:tagNumber];
}


@end
