//
//  BLOnePlayController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/13.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLOnePlayController.h"
#import "BLConst.h"
#import "DLTabedSlideView.h"
#import "BLCommendModel.h"
#import "BLDataTool.h"
#import "MJExtension.h"
#import "BLCommendCellModel.h"
#import "BLSynopsisController.h"
#import "BLCommentController.h"
#import "BLPlayView.h"
#import "PlayerViewController.h"

@interface BLOnePlayController () <UIScrollViewDelegate,DLTabedSlideViewDelegate>

/**
 *  存放的是CommendModel模型
 */
@property (nonatomic, strong) BLCommendModel *commendModel;


/**
 *  子控制器
 */
@property (nonatomic, strong) DLTabedSlideView __block *slideView;

/**
 *  放置的是playViewController
 */
@property (weak, nonatomic) IBOutlet UIView *playView;

/**
 *  记录子控制器Y的偏移量
 */
@property (nonatomic, assign) CGFloat lastY;


@end

@implementation BLOnePlayController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getCommentData];

    [self setChlidViewController];


    CGRect playViewFrame = CGRectMake(0, 0, mainScreen.bounds.size.width, ((mainScreen.bounds.size.width/16) * 9));
    PlayerViewController *vc = [[PlayerViewController alloc]
                                initWithURL:[NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"]
                                withFrame:playViewFrame];

    [self.playView addSubview:vc];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  view即将从window上移除(即将看不见)
 *
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];


}

#pragma mark - 私有方法
/**
 *   设置下部的子控制器
 */
- (void)setChlidViewController{

    _slideView = [[DLTabedSlideView alloc] init]; // 初始化导航栏干
//    slideView.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor grayColor];
    // 这个范围包括子控制器的范围 在代理方法中返回的控制器会自动填充到剩余的部分
    

    _slideView.frame = CGRectMake(0, ((mainScreen.bounds.size.width/16) * 9), mainScreen.bounds.size.width, mainScreen.bounds.size.height);
    [self.view addSubview:_slideView];

    _slideView.baseViewController = self; // 设置父控制器
    _slideView.delegate = self; // 设置代理
    _slideView.tabItemNormalColor = [UIColor blackColor];
    _slideView.tabItemSelectedColor = BLColor(217, 81, 127);
    _slideView.tabbarBottomSpacing = 0; // tabBar间距
    //    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"]; // 背景图片
    _slideView.tabbarTrackColor = BLColor(217, 81, 127); // 导航栏下方的指示条颜色
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"简介" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"评论" image:nil selectedImage:nil];

    _slideView.tabbarItems = @[item1, item2];
    [_slideView buildTabbar];
    _slideView.selectedIndex = 0;

}

- (void)getCommentData
{
    __weak typeof(self) weakSelf = self;
    [BLDataTool GETCommentData:self.baseCellModel
                       success:^(id blCommendModel) {
                           weakSelf.commendModel = blCommendModel; // 获得评论模型数据
                       }
                       failure:^(NSError *error) {
                           NSLog(@"%@",error);
                       }];


}


#pragma mark - 初始化方法
+ (BLOnePlayController *)onePlayController
{
    return [[UIStoryboard storyboardWithName:@"BLOnePlayController" bundle:nil] instantiateInitialViewController]; // 加载默认箭头所指的控制器
}

#pragma mark - DLSlideView代理
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender
{
    return 2;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index
{
    if (index == 0) {
        BLSynopsisController *viewController = [BLSynopsisController synopsisController];

        __weak typeof(self) weakSelf = self;
        viewController.topViewScroll = ^(CGFloat ScrollY)
                                        {
                                            CGFloat moveRY = ScrollY - self.lastY;

//                                            if (weakSelf.slideView.transform.ty >= 70)
//                                            {
                                                weakSelf.slideView.transform = CGAffineTransformTranslate(weakSelf.slideView.transform, 0, - moveRY);

//                                            }
                                            weakSelf.lastY = ScrollY;
                                        };
        return viewController;
    }
    if (index == 1) {
        BLCommentController *viewController = [[BLCommentController alloc] init];
        if (self.commendModel)
        {
            viewController.commendModel = self.commendModel;

            __weak typeof(self) weakSelf = self;
            viewController.topViewScroll = ^(CGFloat ScrollY)
            {
                CGFloat moveRY = ScrollY - self.lastY;
#warning TODO:如何判断
                weakSelf.slideView.transform = CGAffineTransformTranslate(weakSelf.slideView.transform, 0, - moveRY);
                weakSelf.lastY = ScrollY;
            };
        }

        return viewController;
    }

    return nil;
}

/**
 *  可选
 */
- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index
{


}
/**
 *  返回按钮
 */
- (IBAction)backBtn:(id)sender {

    [self.navigationController popViewControllerAnimated:YES]; // push对应的pop
//    [self dismissViewControllerAnimated:YES completion:nil]; // dismiss对用的model
 }

#pragma mark - 旋转
- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        //如果当前是竖屏要完成的事情
        self.slideView.hidden = NO;
        self.navigationController.navigationBar.hidden = YES;

    }else {
        //其他情况完成事情
        //如果当前是竖屏要完成的事情
        self.slideView.hidden = YES;
        self.navigationController.navigationBar.hidden = NO;
    }
}




@end
