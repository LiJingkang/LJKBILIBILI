//
//  BLTopView.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/3.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLTopView.h"
#import "BLConst.h"


@interface BLTopView ()

@property (nonatomic, assign) NSInteger currentClickButton;

@end

@implementation BLTopView

#pragma mark - 成员属性
- (NSInteger)currentClickButton
{
    if (!_currentClickButton) {
        _currentClickButton = 2;
    }
    return _currentClickButton;
}

/**
 *  重写set方法，在调用的时候添加Btn,并且修改属性
 *
 *  @param titleArray btn的name数组
 */
- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;

    UIScreen *screen = [UIScreen mainScreen];

    CGFloat btnW = screen.bounds.size.width / titleArray.count;
    CGFloat btnH = 30;
    CGFloat btnY = 80;

    for (NSInteger i = 0; i<self.titleArray.count; i++) {
        UIButton *navButton = [[UIButton alloc] init];

        navButton.frame = CGRectMake(btnW * i, btnY, btnW, btnH);   // 设置
        [self addSubview:navButton];

        [navButton setTitle:titleArray[i] forState:UIControlStateNormal];
        navButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [navButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        navButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        // 设置tag，在点击的时候调用
        navButton.tag = i + 1;

        [navButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    [(UIButton *)[self viewWithTag:self.currentClickButton]  setTitleColor:BLColor(239, 239, 239) forState:UIControlStateNormal];




    UIView* bottomBar = [[UIView alloc] initWithFrame:CGRectMake(12 + btnW, 111, btnW - 24, 3)];
    bottomBar.backgroundColor = BLColor(239, 239, 239);
    bottomBar.layer.cornerRadius = 1.5;
    [self addSubview:bottomBar];
}



#pragma mark - 私有方法
- (void)navButtonClick:(UIButton *)btn
{
    [self changeButtonColor:btn.tag];

    if (self.clikBtn != nil) {
        self.clikBtn(btn.tag);
    }
}

- (void)changeButtonColor:(NSInteger)btnTag
{
    if (btnTag == self.currentClickButton) {
        return;
    }
    [(UIButton *)[self viewWithTag:btnTag] setTitleColor:BLColor(239, 239, 239) forState:UIControlStateNormal];

    self.currentClickButton = btnTag;
}
@end
