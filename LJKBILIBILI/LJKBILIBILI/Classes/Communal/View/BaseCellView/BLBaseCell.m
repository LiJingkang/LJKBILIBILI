//
//  BLBaseCell.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/12.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLBaseCell.h"
#import "UIView+WebCacheOperation.h"
#import "UIImageView+WebCache.h"
#import "BLConst.h"

@interface BLBaseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *playNumber;

@property (weak, nonatomic) IBOutlet UILabel *commentNumber;
- (IBAction)clickButton:(id)sender;

/**
 *  传入的模型
 */
@property (nonatomic, strong) BLBaseCellModel *baseCellModel;

@end


@implementation BLBaseCell

#pragma mark - 私有方法
- (void)setBaseCellModel:(BLBaseCellModel *)cellModel
{
    if (cellModel) {

        self.backgroundColor = [UIColor clearColor];
        _baseCellModel = cellModel;
        self.ImageView.contentMode = UIViewContentModeScaleAspectFill;  // 设置显示内容方式
        self.ImageView.clipsToBounds = YES; // 超出图片部分裁剪
        [self.ImageView sd_setImageWithURL:[NSURL URLWithString:self.baseCellModel.cover]];
        self.titleLabel.text = self.baseCellModel.title;
        self.titleLabel.backgroundColor = [UIColor clearColor];

        self.playNumber.text = self.baseCellModel.play;

        self.commentNumber.text = [NSString stringWithFormat:@"%ld",self.baseCellModel.danmaku];
    }

}



#pragma mark - 初始化
+ (instancetype)cellWithNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLBaseCell" owner:nil options:nil] lastObject];
}

- (IBAction)clickButton:(id)sender {
    // 点击的时候发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:BLBaseCellDidClick object:self.baseCellModel];

}
@end
