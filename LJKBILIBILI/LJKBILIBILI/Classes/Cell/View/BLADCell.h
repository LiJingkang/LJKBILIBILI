//
//  BLADCell.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/10.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLADCell : UICollectionViewCell


+ (instancetype)adCell;

@property (nonatomic,weak) id<UICollectionViewDelegate> delegate;

/**
 *  设置代理
 */
- (void)setScrollViewDelegate:(id)controller;

@end
