//
//  BLCommentCell.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/17.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommentCell.h"
#import "UIImageView+WebCache.h"

@interface BLCommentCell ()


@property (weak, nonatomic) IBOutlet UILabel *label;



@property (weak, nonatomic) IBOutlet UIImageView *image;

/**
 *  热门评论模型
 */
@property (nonatomic, strong) NSArray *hots;

@end


@implementation BLCommentCell

- (void)awakeFromNib
{
    self.imageView.clipsToBounds = YES;



}

/**
 *  成员属性
 */
- (void)setModel:(BLCommendCellModel *)model
{
    if (model) {
        _model = model;
        self.label.text = _model.content.message;

        [self.image sd_setImageWithURL:[NSURL URLWithString:_model.member.avatar]];

            [self layoutIfNeeded];

        self.model.cellHeight = CGRectGetMaxY(self.label.frame) + 15;

    }


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

#pragma mark - 初始化方法
+ (instancetype)commentCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BLCommentCell" owner:nil options:nil] lastObject];
}

@end
