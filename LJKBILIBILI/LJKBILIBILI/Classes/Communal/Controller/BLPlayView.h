//
//  BLPlayView.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/13.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>


@interface BLPlayView : UIView

#warning TODO:使用B站框架替换

@property (atomic, retain) id <IJKMediaPlayback> player;


+ (instancetype)playViewController;


@end
