//
//  LLSPithyCourtView.m
//  Harmonious
//
//  Created by luolisheng on 15/4/13.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTreasureHouseView.h"

#import <HexColors/HexColor.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

static CGFloat const kWidth_PaddingLeft = 10.0f;
static CGFloat const kHeight_TitleLabel = 30.0f;

@interface LLSTreasureHouseView ()

@property (nonatomic, strong) ButtonPressedBlock pressedBlock;

@end

@implementation LLSTreasureHouseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    CGFloat imageHeight = (SCREEN_HEIGHT - 3*kHeight_TitleLabel - 64 - 44)/3;
    CGFloat imageWidth = CGRectGetWidth(self.frame) - kWidth_PaddingLeft*2;
    for (int i = 0; i<3; i++) {
        CGFloat dx = kWidth_PaddingLeft;
        CGFloat dy = (kHeight_TitleLabel + imageHeight) * i;
        CGFloat dw = imageWidth;
        CGFloat dh = kHeight_TitleLabel;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, dw, dh)];
        label.textColor = [UIColor colorWithHexString:@"999999"];
        label.font = [UIFont systemFontOfSize:14.0f];
        
        dy = (i + 1) * kHeight_TitleLabel + i*imageHeight;
        dh = imageHeight;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:1000 + i];
        [button setFrame:CGRectMake(dx, dy, dw, dh)];
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        
        NSString *text = @"";
        UIImage *image = nil;
        switch (i) {
            case 0:
                text = @"传统工艺";
                image = [UIImage imageNamed:@"th_01"];
                break;
            case 1:
                text = @"外事精粹";
                image = [UIImage imageNamed:@"th_02"];
                break;
            case 2:
                text = @"中国创新";
                image = [UIImage imageNamed:@"th_03"];
                break;
        }
        label.text = text;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        
        [self addSubview:label];
        [self addSubview:button];
    }
}

- (void)setButtonPressedBlock:(ButtonPressedBlock)block {
    _pressedBlock = block;
}

- (void)buttonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (_pressedBlock) {
        _pressedBlock(button.tag-1000);
    }
}

@end
