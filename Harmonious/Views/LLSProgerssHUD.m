//
//  LLSProgerssHUD.m
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSProgerssHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import "NSString+LLSString.h"

static CGFloat const kHeightToBottom = 100.0f;

@implementation LLSProgerssHUD

+ (void)showLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    if (!view) {
        return;
    }
    [self hideHUDForView:view animated:NO];
    [MBProgressHUD showHUDAddedTo:view animated:animated];
}

+ (void)showLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message {
    if (!view) {
        return;
    }
    [self hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    if (hud) {
        [hud setLabelText:message];
    }
}

+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message {
    if (!view) {
        return;
    }
    if ([NSString lls_isEmpty:message]) {
        return;
    }
    [self hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.0];
}

+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated 
           withMessage:(NSString *)message
            atPosotion:(LLSProgressHUDPosition)position {
    if (!view) {
        return;
    }
    if ([NSString lls_isEmpty:message]) {
        return;
    }
    [self hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setLabelText:message];
    [hud setMargin:10.f];
    if (position == LLSProgressHUDPosition_Bottom) {
        [hud setYOffset:SCREEN_HEIGHT/2 - kHeightToBottom];
    }
    [hud setRemoveFromSuperViewOnHide:YES];
    
    [hud hide:YES afterDelay:1.0];
}

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    if (!view) {
        return;
    }
    [MBProgressHUD hideHUDForView:view animated:animated];
}

@end
