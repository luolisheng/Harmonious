//
//  LLSSegmentedControl.h
//  Harmonious
//
//  Created by luolisheng on 15/4/4.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentPressedBlock)(NSInteger index);

@interface LLSSegmentedControl : UIView

- (void)setImags:(NSArray *)images selectedImages:(NSArray *)selectedImages;

- (void)setSelectedWithIndex:(NSInteger)index;

- (void)setSegmentPressed:(SegmentPressedBlock)block;

@end
