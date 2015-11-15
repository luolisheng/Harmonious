//
//  LLSTittleBar.h
//  Harmonious
//
//  Created by luolisheng on 15/4/6.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleButtonPressed)();
typedef void(^MoreButtonPressedBlock)();

@interface LLSTittleBar : UIView

- (void)setTitleBarWithTitle:(NSString *)title
                       image:(UIImage *)image
     titleButtonPressedBlock:(TitleButtonPressed)titleButtonPressedBlock
      moreButtonPressedBlock:(MoreButtonPressedBlock)moreButtonPressedBlock;

- (void)hideTitle:(BOOL)hide;

- (void)hideMoreButton:(BOOL)hide;

@end
