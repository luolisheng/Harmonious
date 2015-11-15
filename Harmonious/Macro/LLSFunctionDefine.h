//
//  LDFunctionDefine.h
//  Harmonious
//
//  Created by luolisheng on 15/4/5.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#ifndef Harmonious_LDFunctionDefine_h
#define Harmonious_LDFunctionDefine_h

// 设备相关
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)    //屏幕宽度
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)  //屏幕宽度

#define IS_IPHONE5_OR_BIGGER (SCREEN_WIDTH-568 >= 0)?YES:NO
#define IS_OS_5_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

// View宽高
#define View_Width(view) CGRectGetWidth(view.frame);
#define View_Height(view) CGRectGetHeight(view.frame);

#define View_MinX(view) CGRectGetMinX(view.frame);
#define View_MaxX(view) CGRectGetMaxX(view.frame);
#define View_MinY(view) CGRectGetMinY(view.frame);
#define View_MaxY(view) CGRectGetMaxY(view.frame);

// UserDefaults
#define UserDefaults [NSUserDefaults standardUserDefaults]

// Get image
#define IMAGEWITHNAME(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]];

// Weak/Strong self; SSelf必须配合WSelf使用
#define WSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define SSelf(strongSelf) __weak __typeof(weakSelf)strongSelf = weakSelf;

// Singleton
#define DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

// Run on main thread
#define DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

// Run on global queue
#define DISPATCH_ON_GLOBAL_QUEUE_LOW(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), globalQueueBlock);

#define DISPATCH_ON_GLOBAL_QUEUE_HIGH(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), globalQueueBlock);

#define DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

#define DISPATCH_ON_GLOBAL_QUEUE_BACKGROUND dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), globalQueueBlock);

#endif
