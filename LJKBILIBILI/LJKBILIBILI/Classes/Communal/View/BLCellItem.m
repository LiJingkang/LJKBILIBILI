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
@property (nonatomic, strong) BLResultItemHead *headModel;

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

    NSLog(@"%@,item模型类型",_resultItemModel.type);

    // head
    self.headModel = _resultItemModel.head; // 获得头部模型
    NSLog(@"%@,头模型标题",self.headModel.title);
    [self setHeadViewAndFooterView]; // 设置头尾

    // body / 存放的是BaseCellModel
    self.CellArray = resultItemModel.body;

    [self setBaseCell];
}

- (void)dealloc
{
}
#pragma mark - 私有方法
- (void)setBaseCell
{
    for (int i = 0; i < self.CellArray.count ; i ++) {
        BLBaseCell *baseCell = [BLBaseCell cellWithNib]; //创建baseCell
        NSLog(@"%@",self.CellArray[i]);
        if (self.CellArray) {
            [baseCell setBaseCellModel:self.CellArray[i]];
        }
//        BLBaseCellModel *cell = self.CellArray[i];
//        NSLog(@"%@_%@",cell.title, cell.cover);
        UIView *view = [self viewWithTag:i + 1]; // 取出 ItemCell里面的4个View

        // 整个cell是自动重用的，但是cell内部的东西不会。所以我们要自己手动来移除，否则会重新来添加
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        baseCell.frame = view.bounds; // 设置frame

        [view addSubview:baseCell]; // 添加
    }
}

- (void)setHeadViewAndFooterView {

}



@end
