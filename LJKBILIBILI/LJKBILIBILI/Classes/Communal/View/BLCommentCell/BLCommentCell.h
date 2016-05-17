//
//  BLCommentCell.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/17.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLCommendCellModel.h"

@interface BLCommentCell : UITableViewCell

/**
 *  只需要知道自己要显示的cell模型就。不需要知道是否是热门或者普通
 */
@property (nonatomic, strong) BLCommendCellModel *model;




+ (instancetype)commentCell;

@end
