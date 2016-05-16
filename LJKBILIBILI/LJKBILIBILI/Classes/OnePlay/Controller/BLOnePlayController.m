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

@interface BLOnePlayController () <UIScrollViewDelegate,DLTabedSlideViewDelegate>

/**
 *  存放的是CommendModel模型
 */
@property (nonatomic, strong) BLCommendModel *commendModel;





@end

@implementation BLOnePlayController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getCommentData];

    [self setChlidViewController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
/**
 *   设置下部的子控制器
 */
- (void)setChlidViewController{

    DLTabedSlideView *slideView = [[DLTabedSlideView alloc] init]; // 初始化导航栏干
//    slideView.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor grayColor];
    // 这个范围包括子控制器的范围 在代理方法中返回的控制器会自动填充到剩余的部分
    

    slideView.frame = CGRectMake(0, ((mainScreen.bounds.size.width/16) * 9), mainScreen.bounds.size.width, mainScreen.bounds.size.height);
    [self.view addSubview:slideView];

    slideView.baseViewController = self; // 设置父控制器
    slideView.delegate = self; // 设置代理
    slideView.tabItemNormalColor = [UIColor blackColor];
    slideView.tabItemSelectedColor = BLColor(217, 81, 127);
    slideView.tabbarBottomSpacing = 0; // tabBar间距
    //    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"]; // 背景图片
    slideView.tabbarTrackColor = BLColor(217, 81, 127); // 导航栏下方的指示条颜色
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"简介" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"评论" image:nil selectedImage:nil];

    slideView.tabbarItems = @[item1, item2];
    [slideView buildTabbar];
    slideView.selectedIndex = 0;

}

- (void)getCommentData
{
    __weak typeof(self) weakSelf = self;
    [BLDataTool GETCommentData:self.baseCellModel
                       success:^(id blCommendModel) {
                           weakSelf.commendModel = blCommendModel;

                           NSArray *hotsArray =  weakSelf.commendModel.hots;

                           for (BLCommendCellModel *commendCellModel in hotsArray) {
                               NSLog(@"%@",commendCellModel.content.message);
                           }
                           
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
        return viewController;
    }
    if (index == 1) {
        BLCommentController *viewController = [[BLCommentController alloc] init];

//        viewController.commendModel = self


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




@end
