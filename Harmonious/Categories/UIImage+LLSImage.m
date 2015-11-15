//
//  UIImage+LLSImage.m
//  Harmonious
//
//  Created by luolisheng on 15/8/25.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "UIImage+LLSImage.h"

@implementation UIImage (LLSImage)

+ (UIImage *)lls_screenShot {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.frame.size, YES, .0f);
    [window drawViewHierarchyInRect:window.frame afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
