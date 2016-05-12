//
//  BLCellItem.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/11.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCellItem.h"

#import "MJExtension.h"
#import "BLBaseCell.h"





@interface BLCellItem ()

/**
 *  ItemModel里保存的BaseCell模型 / 一般是4个
 */
@property (nonatomic, strong) NSArray *CellArray;

@end

@implementation BLCellItem



#pragma mark - 初始化方法
+ (instancetype)cellItem
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLCellItem" owner:nil options:nil] lastObject];
}


#pragma mark - 成员方法
- (void)setResultItemModel:(BLResultItem *)resultItemModel
{
    _resultItemModel = resultItemModel; // 赋值


    // head
    BLResultItemHead *head = resultItemModel.head;
    [self setHeadViewAndFooterView];

    // body / 存放的是BaseCellModel
    self.CellArray = resultItemModel.body;

    [self setBaseCell];
}
#pragma mark - 私有方法
- (void)setBaseCell
{
    for (int i = 0; i < self.CellArray.count ; i ++) {
        BLBaseCell *baseCell = [BLBaseCell cellWithNib];
        baseCell.cellModel = self.CellArray[i];
        UIView *view = [self viewWithTag:i + 1];
        baseCell.frame = view.bounds;

        [view addSubview:baseCell];
    }
}

- (void)setHeadViewAndFooterView {

}



@end
