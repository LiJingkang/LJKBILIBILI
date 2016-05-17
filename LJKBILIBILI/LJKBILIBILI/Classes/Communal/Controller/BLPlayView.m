//
//  BLPlayView.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/13.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLPlayView.h"

@interface BLPlayView (){
    BOOL isplayed;
}

@end


@implementation BLPlayView


- (void)viewDidLoad
{
    NSURL *url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];


    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];

    UIView *playerView = [_player view];

    playerView.frame = self.PlayerView.frame;

    [self.PlayerView insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    [self installMovieNotificationObservers];

}



+ (Class)layerClass {
    return [AVPlayerLayer class];
}




@end
