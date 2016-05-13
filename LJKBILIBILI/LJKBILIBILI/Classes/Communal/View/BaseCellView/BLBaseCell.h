//
//  BLBaseCell.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/12.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseCellModel.h"

@interface BLBaseCell : UIView

- (void)setBaseCellModel:(BLBaseCellModel *)cellModel;

/**
 *  初始化
 */
+ (instancetype)cellWithNib;

@end
