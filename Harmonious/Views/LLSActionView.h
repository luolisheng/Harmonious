//
//  LLSActionView.h
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionButtonPressedBlock)(NSInteger index);

@interface LLSActionView : UIView

- (id)initWithTitle:(NSString *)title
 actionButtonTitles:(NSArray *)actionButtonTitles
 actionButtonImages:(NSArray *)actionButtonImages;

- (void)setActionButtonPressedBlock:(ActionButtonPressedBlock)block;

- (void)show;

@end
