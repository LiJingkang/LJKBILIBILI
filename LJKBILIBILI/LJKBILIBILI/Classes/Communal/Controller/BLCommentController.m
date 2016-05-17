//
//  BLCommentController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/16.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommentController.h"
#import "BLConst.h"
#import "BLCommentCell.h"
#import "BLCommentHeader.h"


@interface BLCommentController ()<UITableViewDataSource, UITableViewDelegate>

/**
 *  热门评论列表
 */
@property (nonatomic, strong) NSArray *hostCommentArray;

/**
 *  所有评论列表
 */
@property (nonatomic, strong) NSArray *commentArray;

@end

@implementation BLCommentController

#pragma mark - 成员属性
- (void)setCommendModel:(BLCommendModel *)commendModel
{
    if (commendModel) {
        _commendModel = commendModel;

        _hostCommentArray = _commendModel.hots;
        _commentArray = _commendModel.replies;

        // 一旦获得新数据 则刷新
//        [self.tableView reloadData]; 
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = BLRandomColor;

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;


}


- (void)awakeFromNib
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

/**
 *  返回组数数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_hostCommentArray) {
        return 2;
    }
    else {
        return 0;
    }

    return 0;
}

/**
 *  返回每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hostCommentArray.count;
    }
    else {
        return self.commentArray.count;
    }

    return 0;
}


/**
 *  返回一个cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"comment_cell";

    // 返回可重用的cell
    BLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [BLCommentCell commentCell];
    }

    // 给cell传递模型
    if (indexPath.section == 0) {
        cell.model = self.hostCommentArray[indexPath.row];
    }
    else if (indexPath.section == 1){
        cell.model = self.commentArray[indexPath.row];
    }

    return cell;
}

/**
 *  返回每个cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 给cell传递模型
    if (indexPath.section == 0) {
        BLCommendCellModel *model = self.hostCommentArray[indexPath.row];
        return model.cellHeight;
    }
    else if (indexPath.section == 1){
        BLCommendCellModel *model = self.commentArray[indexPath.row];
        return model.cellHeight;
    }
    
    return 220;
}

/**
 *  预估cell高度的方法
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

//可返回每个section-header的自定义视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        BLCommentHeader *header = [BLCommentHeader commentHeader];
        header.frame = CGRectMake(0, 0, mainScreen.bounds.size.width, 25);
        return header;
    }
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
    return view;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
    NSLog(@"%f",scrollY);

    if (scrollY > 0) {
        if (self.topViewScroll) {
            self.topViewScroll(scrollY);
        }
    }
    
}


@end
