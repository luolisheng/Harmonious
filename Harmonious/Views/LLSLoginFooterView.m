//
//  LLSLoginFooterView.m
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSLoginFooterView.h"

@interface LLSLoginFooterView ()

@property (nonatomic, strong) SocialButtonPressed buttonPressed;

@end

@implementation LLSLoginFooterView

- (void)setSocialButtonPressedBlock:(SocialButtonPressed)block {
    _buttonPressed = block;
}

- (IBAction)buttonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (_buttonPressed) {
        _buttonPressed(button.tag-1000);
    }
}

@end
