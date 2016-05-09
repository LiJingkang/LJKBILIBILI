//
//  BLSlidView.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/3.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLSlidView.h"
#import "BLConst.h"

@interface BLSlidView () <UITableViewDataSource, UITableViewDelegate>
/**
 *  SlideView左边的拖拽View
 */
@property (weak, nonatomic) IBOutlet UIView *dragView;

/**
 *  左侧tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *associatorTableView;

/**
 *  tableView上内容的数组
 */
@property (nonatomic, strong) NSArray *tableViewArray;

@property (nonatomic, strong) UITableViewCell *lastCell;




@end

@implementation BLSlidView

#pragma mark - 成员属性
- (NSArray *)tableViewArray
{
    if (_tableViewArray == nil) {
        _tableViewArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Setting.plist" ofType:nil]];
    }
    return _tableViewArray;
}

/**
 *  懒加载lastCell 设置为第一行第一列的Cell
 */
- (UITableViewCell *)lastCell
{
    if (_lastCell == nil) {
        _lastCell= [self.associatorTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    return _lastCell;
}

#pragma mark - 父类方法
- (void)awakeFromNib
{
    // shadowView
    UIView *shadowView = [[UIView alloc] init];
    shadowView.frame = CGRectMake(0, 0, mainScreen.bounds.size.width * 2, mainScreen.bounds.size.height);
    self.shadowView = shadowView;
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.0;
    [self addSubview:shadowView];
    [self sendSubviewToBack:shadowView];
    [self.dragView setBackgroundColor:[UIColor clearColor]];

    // 创建一个手势识别器
    UIPanGestureRecognizer *gestureRecognizerShowSlideView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(showSlideView:)];
    // 添加手势识别
    [self.dragView addGestureRecognizer:gestureRecognizerShowSlideView];

    // 点击取消的手势
    UIPanGestureRecognizer *gestureRecognizerDidTouchShadowView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(disSlideBtn)];

    // 添加手势判断，在shadows上面
    [shadowView addGestureRecognizer:gestureRecognizerDidTouchShadowView];

    // 设置tableView
    self.associatorTableView.delegate = self;
    self.associatorTableView.dataSource = self;
    self.associatorTableView.bounces = NO;
    self.associatorTableView.rowHeight = 54;  // 设置行高
    self.associatorTableView.sectionHeaderHeight = 2;
}

#pragma mark - 私有方法
- (void)showSlideView:(UIPanGestureRecognizer *)recognizer
{
    CGPoint trans = [recognizer translationInView:recognizer.view]; // 新滑动的距离
    CGFloat changeX = self.transform.tx + trans.x; // 已经改变的距离

    if (changeX >= 0 && changeX <= mainScreen.bounds.size.width) {
        self.transform = CGAffineTransformTranslate(self.transform, trans.x, 0);
        self.shadowView.alpha = changeX * 0.0015;
    }

    if (recognizer.state == UIGestureRecognizerStateEnded && self.transform.tx < (mainScreen.bounds.size.width * 0.5))
    {
        [self disSlideBtn];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded && self.transform.tx > (mainScreen.bounds.size.width *0.5))
    {
        // 显示SlideView ，这段代码来自控制器，使用控制器来调用SlideView
        // 因为在主窗口中，点击SlideBtn按钮也需要弹出窗口，跨控制器使用通知
        if (self.showSlideView) {
            self.showSlideView(); // 如果存在，执行这一段block
        }
    }

    // 每次滑动都会调用这个方法，如果不清空将会累加
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}

/**
 *  取消SlideView
 */
- (void)disSlideBtn
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.shadowView.alpha = 0;
                         self.transform = CGAffineTransformMakeTranslation(0, 0);
                     }];
}

#pragma mark - 初始化方法
+ (instancetype)slideView
{
    // 从mainBundle里面加载SlidView
    return [[[NSBundle mainBundle] loadNibNamed:@"BLSlidView" owner:nil options:nil] lastObject];
}

#pragma mark - tableView数据源方法
// 返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewArray.count;
}

// 返回每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 会取出这个数组里面的所有item属性放在一个数组里面
    return [[self.tableViewArray[section] valueForKey:@"item"] count];
}

// 设置组头的文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"tableView_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    cell.imageView.alpha = 0.6;
    NSString *icon = [[self.tableViewArray[indexPath.section] valueForKey:@"item"][indexPath.row] valueForKey:@"icon"];
    cell.imageView.image = [UIImage imageNamed:icon];
    NSString *title = [[self.tableViewArray[indexPath.section] valueForKey:@"item"][indexPath.row] valueForKey:@"title"];
    cell.textLabel.text = [NSString stringWithFormat:@"         %@",title];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.backgroundColor = [UIColor clearColor];


    if (indexPath.row == 0 && indexPath.section == 0) {
        cell.textLabel.textColor = BLColor(244, 89, 163);
    }

    return cell;
}

#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得点击了哪一行cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if ([cell.textLabel.text isEqualToString:self.lastCell.textLabel.text])
    {
        cell.textLabel.textColor = BLColor(244, 89, 163);
        [self disSlideBtn];
        NSLog(@"%@",cell.textLabel.text);
        NSLog(@"%@",self.lastCell.textLabel.text);
#warning TODO:监听点击
    }
}


@end
