//
//  LLSPithyCourtView.h
//  Harmonious
//
//  Created by luolisheng on 15/4/13.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonPressedBlock)(NSInteger tag);

@interface LLSTreasureHouseView : UIView

- (void)setButtonPressedBlock:(ButtonPressedBlock)block;

@end
