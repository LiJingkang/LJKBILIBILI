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



