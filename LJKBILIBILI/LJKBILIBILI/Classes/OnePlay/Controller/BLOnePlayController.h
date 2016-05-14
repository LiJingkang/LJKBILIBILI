//
//  BLOnePlayController.h
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/13.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseCellModel.h"

@interface BLOnePlayController : UIViewController

@property (nonatomic, strong) BLBaseCellModel *baseCellModel;


+ (BLOnePlayController *)onePlayController;

@end
