//
//  BLCommendViewController.m
//  LJKBILIBILI
//
//  Created by 李泾康 on 16/5/9.
//  Copyright © 2016年 LJK. All rights reserved.
//

#import "BLCommendViewController.h"
#import "BLConst.h"
#import <AFNetworking.h>
#import "BLHttpTool.h"
#import "BLResultItem.h"
#import "MJExtension.h"
#import "BLADCell.h"
#import "BLCellItem.h"
#import "UIView+Extension.h"
#import "YiRefreshHeader.h"


#define firstUrl @"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000"

#define BLCellItemID @"BLCellItem"
#define BLADCellID @"BLADCell"
#define BLCellItem_2_ID @"BLCellItem_2"
#define BLTopicCellID @"BLTopicCell"
#define BLScrollCellID @"BLScrollCell"


@interface BLCommendViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    UICollectionView *_collectionView;
    // 获取头部刷新组件
    YiRefreshHeader* refreshHeader;
}

/**
 *  请求返回的结果数组。 / 里面存放的是Item的模型
 */
@property (nonatomic, strong) NSArray *resultItemArray;


//@property (nonatomic, weak) UIScrollView* scrollView; // 头部刷新使用



@end

@implementation BLCommendViewController


#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    self.backgroundColor = BLColor(229, 229, 223);


    __weak typeof(self) weakSelf = self;

    [self initCollectionView];

    // YiRefreshHeader  头部刷新按钮的使用
    refreshHeader = [[YiRefreshHeader alloc] init];
    refreshHeader.scrollView = _collectionView; // 设置refreshHeader要刷新的scrollView
    [refreshHeader header]; // 刷新头部
    refreshHeader.beginRefreshingBlock = ^() {
        // 后台执行：
        [weakSelf refresh];
    };
    // 是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];

    return self;
}

- (void)refresh
{
    [self getCommendListModel];
}

#pragma mark - 私有方法
/**
 *  获取网络请求返回的数组，把他转换成模型
 */
- (void)getCommendListModel
{
    NSString *urlString = firstUrl;

    [BLHttpTool GET:urlString parameters:nil
            success:^(id responseObject) {
                     // 取出结果返回的结果数组
                     NSArray *resultArray = [responseObject valueForKey:@"result"];

                     // 字典数组 ---> 模型数组
                    NSArray *resultItemArray = [BLResultItem objectArrayWithKeyValuesArray:resultArray];
                    self.resultItemArray = resultItemArray;
                    [_collectionView reloadData]; // 获取数据以后刷新collectionView
                    [refreshHeader endRefreshing];  // 停止刷新
                    }
            failure:^(NSError *error) {

                    }];
}

#pragma mark - CollectionView
/**
 *  初始化initCollection
 */
- (void)initCollectionView
{
    // UICollectionViewFlowLayout 系统提供的流水布局
    // 如果我们需要自定义布局，我们需要使用 UICollectionViewLayout 来自定义布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // 布局文件

    layout.minimumLineSpacing = 0;  // 垂直间距
    layout.minimumInteritemSpacing = 0; // 水平间距


    // 新建collectionView
    _collectionView = [[UICollectionView alloc]
                       initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height- 44)
                       collectionViewLayout:layout];
    _collectionView.backgroundColor = BLColor(239, 239, 239);


    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES; // 垂直方向永远可以滚动
    _collectionView.bounces = YES;

    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"BLCellItem" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLCellItemID];

    [_collectionView registerNib:[UINib nibWithNibName:@"BLADCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLADCellID];

    [_collectionView registerNib:[UINib nibWithNibName:@"BLCellItem2" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLCellItem_2_ID];

    [_collectionView registerNib:[UINib nibWithNibName:@"BLTopicCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLTopicCellID];

    [_collectionView registerNib:[UINib nibWithNibName:@"BLScrollCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLScrollCellID];

    
    // 添加到父视图
    [self addSubview:_collectionView];
}

#pragma mark CollectionView DateSource
/**
 *  返回组数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
/**
 *  返回每组的行数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.resultItemArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{


    // 如果有有值
    if (self.resultItemArray)
    {
        UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
            if (indexPath.row == 0)
            { // 第一个 返回ADCell
                cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BLADCellID forIndexPath:indexPath];
                return cell;
            }
            // 取出模型
            BLResultItem *item = self.resultItemArray[indexPath.row -1];
            if (item.type == nil)
            {   // 周刊排行版
             cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BLCellItem_2_ID forIndexPath:indexPath];
                return cell;

            }
            if ([item.type isEqualToString:@"weblink"])
            {   // 话题
                cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BLTopicCellID forIndexPath:indexPath];
                return cell;
            }
             if ([item.type isEqualToString:@"bangumi_3"])
            {   // ScrollCell
              cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BLScrollCellID forIndexPath:indexPath];
              return cell;
            }
    }

    if (self.resultItemArray)
    {
        BLCellItem *cellItem = [collectionView dequeueReusableCellWithReuseIdentifier:BLCellItemID forIndexPath:indexPath];
        // 取出对应的模型
        BLResultItem *cellModel = self.resultItemArray[indexPath.row - 1];
        // 将模型传递
        cellItem.resultItemModel = cellModel; // ResultItem 模型
        
        return cellItem;
    }

    BLCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BLCellItemID forIndexPath:indexPath];
    return cell;
}

#pragma mark CollectionView Delegate

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeZero;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeZero;
//}
// 用来布局每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0)
        { // 第一个 返回ADCell
            return CGSizeMake(mainScreen.bounds.size.width, ((mainScreen.bounds.size.width/640)*200));
        }
        // 取出模型
        BLResultItem *item = self.resultItemArray[indexPath.row -1];
        if (item.type == nil)
        {   // 周刊排行版
            return CGSizeMake(mainScreen.bounds.size.width, ((mainScreen.bounds.size.width/600)*180));
        }
        if ([item.type isEqualToString:@"weblink"])
        {   // 话题
            return CGSizeMake(mainScreen.bounds.size.width, ((mainScreen.bounds.size.width/600)*200));
        }
        if ([item.type isEqualToString:@"bangumi_3"])
        {   // ScrollCell
            return CGSizeMake(mainScreen.bounds.size.width, ((mainScreen.bounds.size.width/600)*400));
        }

    return CGSizeMake(mainScreen.bounds.size.width, ((mainScreen.bounds.size.width/600)*500));
}

//#pragma mark - ScrollView
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 滚动的时候collectionView和底下的mainScrolLView在一起滚动
//    NSInteger scrollY = scrollView.contentOffset.y;
//    if (scrollY > 70)
//    {
//        if (scrollView.contentOffset.y > 0)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:BLScrollToTop object:@(scrollView.contentOffset.y    )];
//        }
//
//    }
//
//}







@end


