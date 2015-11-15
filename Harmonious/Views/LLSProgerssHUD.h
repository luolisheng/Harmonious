//
//  LLSProgerssHUD.h
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LLSProgressHUDPosition) {
    LLSProgressHUDPosition_Center = 0,
    LLSProgressHUDPosition_Bottom
};

@interface LLSProgerssHUD : NSObject

+ (void)showLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+ (void)showLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message;

+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message;
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message
            atPosotion:(LLSProgressHUDPosition)position;

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated;

@end
