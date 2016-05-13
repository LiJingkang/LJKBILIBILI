#import <Foundation/Foundation.h>

#ifdef DEBUG // 调试状态, 打开LOG功能
#define BLLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define BLLog(...)
#endif



// 颜色
#define BLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define BLRandomColor BLColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 获取屏幕尺寸
#define mainScreen [UIScreen mainScreen]


// 通知
extern NSString *const BLShowSlideNotification;  // 隐藏SlideView

extern NSString *const BLScrollToTop;  // 向上滚动

extern NSString *const BLBaseCellDidClick;  // 点击



typedef enum : NSUInteger {
    ControllerEnumLive = 0, // 直播
    ControllerEnumCommend = 1, // 推荐
    ControllerEnumNew = 2, // 新番
    ControllerEnumSubarea = 3, // 分区
    ControllerEnumAttention = 4, // 关注
    ControllerEnumDiscover = 5 , // 发现
} ControllerEnum;
