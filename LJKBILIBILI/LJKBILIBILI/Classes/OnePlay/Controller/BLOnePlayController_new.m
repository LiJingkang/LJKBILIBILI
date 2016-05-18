//
//  BLOnePlayController_new.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/18.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLOnePlayController_new.h"

@interface BLOnePlayController_new (){
    BOOL isplayed;
}


@property (weak, nonatomic) IBOutlet UIView *playView;

- (IBAction)playButton:(id)sender;

@end

@implementation BLOnePlayController_new

- (void)viewDidLoad {
    [super viewDidLoad];


    NSURL *url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];

    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];

    // playView 是承载_player的窗口
    UIView *playerView = [_player view];  // 返回播放器的UIView

    // 需要将playView
    playerView.frame = self.playView.frame;

    // 这是playerView 的自动布局
    // 可以使用框架替换
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.playView insertSubview:playerView atIndex:1]; // 添加上去
    // 设置缩放模式
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill]; // 按比例充满
    // 添加通知
//    [self installMovieNotificationObservers];

}


/**
 *  在dealloc 方法里面移除通知
 */
- (void)dealloc {
    [self.player stop];
    [_player shutdown];
//    [self removeMovieNotificationObservers];
}


- (void)viewWillAppear:(BOOL)animated
{
    if (![_player isPlaying]) { // 是否播放
        [self.player prepareToPlay]; // 准备播放
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)playButton:(id)sender {
    if (![_player isPlaying]) {
        [self.player play];
    }else {
        [self.player pause];
    }


}
@end
