//
//  LLSAboutFooterView.m
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSAboutFooterView.h"

@interface LLSAboutFooterView ()<UIAlertViewDelegate>

@end

@implementation LLSAboutFooterView

- (void)awakeFromNib {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickUILable)];
    [self.phoneLabel addGestureRecognizer:tapGesture];
}

- (void)onClickUILable {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"是否拨打电话：4006570880"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 1) {
        return;
    }
    NSString *urlStr = @"tel://4006570880";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
