//
//  LLSTipsView.m
//  Harmonious
//
//  Created by luolisheng on 15/8/26.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTipsView.h"

@interface LLSTipsView ()

@property (nonatomic, assign) NSInteger tapedCount;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LLSTipsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tapedCount = 0;
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        
        _imageView.image = [UIImage imageNamed:@"Image1"];
        
        [self addSubview:_imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)taped {
    if (_tapedCount == 0) {
        _imageView.image = [UIImage imageNamed:@"Image2"];
        _tapedCount ++;
    }
    else if (_tapedCount == 1) {
        _imageView.image = [UIImage imageNamed:@"Image3"];
        _tapedCount++;
    }
    else if (_tapedCount == 2) {
        [self removeFromSuperview];
    }
}

@end
