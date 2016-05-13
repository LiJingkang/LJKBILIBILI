//
//  BLSynopsisController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/13.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLSynopsisController.h"
#import "BLPlayView.h"

@interface BLSynopsisController ()

@end

@implementation BLSynopsisController

- (void)viewDidLoad {
    [super viewDidLoad];
    BLPlayView *playView = [[BLPlayView alloc] init];
    playView.frame = self.view.bounds;

    [self.view addSubview:playView];
//        self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
