//
//  LLSSegmentedControl.m
//  Harmonious
//
//  Created by luolisheng on 15/4/4.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSSegmentedControl.h"

static const NSInteger kIndexValue = 100;

@interface LLSSegmentedControl ()

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectedImages;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, copy) SegmentPressedBlock segmentPressedBolck;

@end

@implementation LLSSegmentedControl

- (void)setImags:(NSArray *)images selectedImages:(NSArray *)selectedImages {
    _images = images;
    _selectedImages = selectedImages;
    
    [self updateSegmentsRects];
}

- (void)setSelectedWithIndex:(NSInteger)index {
    if (_selectedBtn) {
        _selectedBtn.selected = NO;
    }
    
    UIButton *button = (UIButton *)[self viewWithTag:index+kIndexValue];
    _selectedBtn = button;
    button.selected = YES;
}

- (void)setSegmentPressed:(SegmentPressedBlock)block {
    _segmentPressedBolck = block;
}

/*
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self updateSegmentsRects];
}*/

- (void)updateSegmentsRects {
    CGFloat segmentWidth  = .0f;
    NSInteger count = _images.count;
    if (count > 0) {
        segmentWidth = SCREEN_WIDTH / count;
    }
    
    [_images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:idx+kIndexValue];
        [button setFrame:CGRectMake(idx*segmentWidth, .0f, segmentWidth, CGRectGetHeight(self.frame))];
        [button setBackgroundImage:_images[idx] forState:UIControlStateNormal];
        [button setBackgroundImage:_selectedImages[idx] forState:UIControlStateSelected];
        [button setBackgroundImage:_selectedImages[idx] forState:UIControlStateHighlighted];
        [button setAdjustsImageWhenHighlighted:NO];
        [button addTarget:self
                   action:@selector(segmentPressed:) 
         forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }];
}

#pragma mark -- Selector`

- (void)segmentPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == _selectedBtn.tag) {
        return;
    }
    
    NSInteger index = button.tag - kIndexValue;
    
    [self setSelectedWithIndex:index];
    
    if (_segmentPressedBolck) {
        _segmentPressedBolck(index);
    }
}

@end
