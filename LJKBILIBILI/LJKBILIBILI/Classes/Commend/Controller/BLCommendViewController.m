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


#define firstUrl @"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000"

#define BLCellItemID @"BLCellItem"
#define BLADCellID @"BLADCell"

@interface BLCommendViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    UICollectionView *_collectionView;
}

/**
 *  请求返回的结果数组。 / 里面存放的是Item的模型
 */
@property (nonatomic, strong) NSArray *resultItemArray;



@end

@implementation BLCommendViewController


#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    
    BLADCell *ADCell = [BLADCell adCell];
    //  bug 原因，要在调用它的主控制器里面设置xib的frame。如果不设置的话它将使用自己默认的xib里面的高
    ADCell.width = mainScreen.bounds.size.width; // 640 200


    [self addSubview:ADCell];






    [self initCollectionView];

    [self getCommendListModel];

    return self;
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
                       initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                       collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor redColor];


    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES; // 垂直方向永远可以滚动
    _collectionView.bounces = YES;

    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"BLCellItem" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLCellItemID];

    [_collectionView registerNib:[UINib nibWithNibName:@"BLADCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:BLADCellID];



    // 注册SupplementaryView
//    [_collectionView registerNib:[UINib nibWithNibName:@"BLADCell" bundle:[NSBundle mainBundle]]
//      forSupplementaryViewOfKind:@"ADCell" withReuseIdentifier:@"ADCell"];



    
    
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
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSObject *cell = [[UICollectionViewCell alloc] init];
//
//    // 通过判断重新复制来返回cell 来实现对不同cell显示
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
               BLADCell * adCell = [collectionView dequeueReusableCellWithReuseIdentifier:BLADCellID forIndexPath:indexPath];
            [adCell setScrollViewDelegate:self];
    return adCell;
//
//        };
//        if (indexPath.row == 1) {
//            cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BLCellItemID forIndexPath:indexPath];
//        };
//
//    }
//    return cell;
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

    return CGSizeMake(mainScreen.bounds.size.width, mainScreen.bounds.size.width);


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


