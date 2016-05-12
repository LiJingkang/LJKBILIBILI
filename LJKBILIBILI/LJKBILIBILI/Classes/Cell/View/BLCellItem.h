//
//  BLCellItem.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/11.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseCell.h"
#import "BLResultItem.h"

@interface BLCellItem : UICollectionViewCell
/**
 *  BLCellItem模型，Redult返回值中的一个
 */
@property (nonatomic, strong) BLResultItem *resultItemModel;


/**
 *  初始化方法
 */
+ (instancetype)cellItem;

@end
