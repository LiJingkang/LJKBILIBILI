//
//  BLSynopsisController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/13.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLSynopsisController.h"
#import "BLPlayView.h"
#import "BLConst.h"




@interface BLSynopsisController ()
// 主页面的底部scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation BLSynopsisController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
//    BLPlayView *playView = [[BLPlayView alloc] init];
//    playView.frame = self.view.bounds;
//
//    [self.view addSubview:playView];


    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.bounces = YES;
    self.scrollView.backgroundColor = [UIColor grayColor];
//    self.scrollView.contentSize = mainScreen.bounds.size;


//        self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)synopsisController
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLSynopsisController" owner:nil options:nil] lastObject];
}




@end
