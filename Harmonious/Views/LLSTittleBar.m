//
//  LLSTittleBar.m
//  Harmonious
//
//  Created by luolisheng on 15/4/6.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTittleBar.h"
#import "NSString+LLSString.h"

#import <HexColors/HexColor.h>

static CGFloat const kWidth_PaddingLeft = 10.0f;
static CGFloat const kHeight_PaddingTop = .0f;

static CGFloat const kWidth_TitleButton = 100.0f;

static CGFloat const kHeight_TitleLabel = 20.0f;

static CGFloat const kWidth_Gap = 5.0f;

@interface LLSTittleBar ()

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, copy) TitleButtonPressed titleButtonPressedBlock;
@property (nonatomic, copy) MoreButtonPressedBlock moreButtonPressedBlock;

@end

@implementation LLSTittleBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.backgroundColor = [UIColor colorWithHexString:@"#DCDCD8"];
    
    CGFloat width = CGRectGetHeight(self.frame);
    
    CGFloat dx = kWidth_PaddingLeft;
    CGFloat dy = kHeight_PaddingTop;
    CGFloat dw = kWidth_TitleButton;
    CGFloat dh = width;
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.userInteractionEnabled = NO;
    [_titleButton setFrame:CGRectMake(dx, dy, dw, dh)];
    [_titleButton setBackgroundImage:[UIImage imageNamed:@"tib_pc"] forState:UIControlStateNormal];
    [_titleButton addTarget:self
                     action:@selector(titleButtonPressed) 
           forControlEvents:UIControlEventTouchUpInside];
    
    dx = CGRectGetMaxX(_titleButton.frame) + kWidth_Gap;
    dy = CGRectGetHeight(self.frame) - kHeight_TitleLabel;
    dw = CGRectGetWidth(self.frame) - dx - width;
    dh = kHeight_TitleLabel;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, dw, dh)];
    _titleLabel.text = @"Pithy Court";
    _titleLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    dx = CGRectGetMaxX(_titleLabel.frame);
    dy = kHeight_PaddingTop;
    dw = width;
    dh = width;
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.userInteractionEnabled = NO;
    [_moreButton setFrame:CGRectMake(dx, dy, dw, dh)];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"tib_more"] forState:UIControlStateNormal];
    [_moreButton addTarget:self
                    action:@selector(moreButtonPressed) 
          forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_titleButton];
    [self addSubview:_titleLabel];
    [self addSubview:_moreButton];
}

- (void)setTitleBarTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (void)setTitleBarImage:(UIImage *)image {
    [_titleButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)setMoreButtonPressedBlock:(MoreButtonPressedBlock)block {
    _moreButtonPressedBlock = block;
}

- (void)setTitleBarWithTitle:(NSString *)title
                       image:(UIImage *)image
     titleButtonPressedBlock:(TitleButtonPressed)titleButtonPressedBlock
      moreButtonPressedBlock:(MoreButtonPressedBlock)moreButtonPressedBlock {
    
    if (![NSString lls_isEmpty:title]) {
        _titleLabel.text = title;
    }
    if (image) {
        [_titleButton setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (titleButtonPressedBlock) {
        _titleButton.userInteractionEnabled = YES;
        _titleButtonPressedBlock = titleButtonPressedBlock;
    }
    if (moreButtonPressedBlock) {
        _moreButton.userInteractionEnabled = YES;
        _moreButtonPressedBlock = moreButtonPressedBlock;
    }
}

- (void)hideTitle:(BOOL)hide {
    _titleLabel.hidden = hide;
}

- (void)hideMoreButton:(BOOL)hide {
    _moreButton.hidden = hide;
}

#pragma mark -- Selector

- (void)titleButtonPressed {
    if (_titleButtonPressedBlock) {
        _titleButtonPressedBlock();
    }
}

- (void)moreButtonPressed {
    if (_moreButtonPressedBlock) {
        _moreButtonPressedBlock();
    }
}

@end
