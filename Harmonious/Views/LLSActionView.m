//
//  LLSActionView.m
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSActionView.h"
#import "NSString+LLSString.h"

#import <HexColors/HexColor.h>

#define kWidth [UIScreen mainScreen].bounds.size.width

#define kActionButtonWidth (IS_IPHONE5_OR_BIGGER?50.0f:45.0f)

#define kGapVertical (IS_IPHONE5_OR_BIGGER?30.0f:14.0f)

#define kTitleLabelHeight 15.0f
#define kCancelButtonHeight 40.0f

@interface LLSActionView ()

@property (nonatomic, assign) CGFloat scal;
@property (nonatomic, strong) NSArray *shareButtonTitleArray;
@property (nonatomic, strong) NSArray *shareButtonImageArray;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, copy) ActionButtonPressedBlock buttonPressedBlock;

@end

@implementation LLSActionView

- (id)initWithTitle:(NSString *)title
 actionButtonTitles:(NSArray *)actionButtonTitles
 actionButtonImages:(NSArray *)actionButtonImages {
    self = [super init];
    if (self) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        
        self.frame = screenBounds;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"am_bg"]];
        self.scal = 280/320.0;
        
        UIControl *ctl = [[UIControl alloc]initWithFrame:screenBounds];
        [ctl addTarget:self
                action:@selector(touchDownRemoveView) 
      forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:ctl];
        
        self.contentView =
        [[UIView alloc] initWithFrame:CGRectMake(0, screenBounds.size.height, screenBounds.size.width, 0)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        
        self.shareButtonImageArray = actionButtonImages;
        self.shareButtonTitleArray = actionButtonTitles;
        
        [self creatButtonsWithTitle:title
                  shareButtonTitles:actionButtonTitles
          withShareButtonImagesName:actionButtonImages];
    }
    return self;
}

- (void)setActionButtonPressedBlock:(ActionButtonPressedBlock)block {
    _buttonPressedBlock = block;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat height = [UIScreen mainScreen].bounds.size.width*self.scal - kCancelButtonHeight;
    
    WSelf(weakSelf)
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf.contentView setFrame:CGRectMake(0,
                                                  screenBounds.size.height-height,
                                                  screenBounds.size.width,
                                                  height)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)touchDownRemoveView{
    WSelf(weakSelf)
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.contentView.frame = CGRectMake(0,
                                                [UIScreen mainScreen].bounds.size.height,
                                                [UIScreen mainScreen].bounds.size.width,
                                                0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)creatButtonsWithTitle:(NSString *)title
            shareButtonTitles:(NSArray *)shareButtonTitlesArray
    withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray {
    
    UILabel *titleLabel = nil;
    if (![NSString lls_isEmpty:title]) {
        titleLabel = [self creatTitleLabelWith:title];
        [self.contentView addSubview:titleLabel];
    }
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    NSInteger count = shareButtonImagesNameArray.count;
    for (int i=0; i<count; i++) {
        NSString *title = self.shareButtonTitleArray[i];
        UIImage *image = [UIImage imageNamed:self.shareButtonImageArray[i]];
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setBackgroundColor:[UIColor clearColor]];
        [shareButton setImage:image forState:UIControlStateNormal];
        shareButton.tag = i;
        [shareButton addTarget:self
                        action:@selector(didSelectImageItem:)
              forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *actionTitleLabel = [[UILabel alloc] init];
        actionTitleLabel.text = title;
        actionTitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        actionTitleLabel.textAlignment = NSTextAlignmentCenter;
        actionTitleLabel.font = [UIFont systemFontOfSize:10.0f];
        
        CGFloat titleHeight = CGRectGetHeight(titleLabel.frame) + 20.0f;
        CGFloat dGapWidth = (width - kActionButtonWidth*4) / 5;
        CGFloat dx = (i-1)*dGapWidth + (i-2)*kActionButtonWidth;
        CGFloat dy = kGapVertical;
        CGFloat dw = kActionButtonWidth;
        CGFloat dh = kActionButtonWidth;
        if (i > 3) {
            dx = (i-3)*dGapWidth + (i-4)*kActionButtonWidth;
            dy = titleHeight + kActionButtonWidth + 40.0f;
        } else {
            dx = (i+1)*dGapWidth + i*kActionButtonWidth;
            dy = titleHeight;
        }
        
        [shareButton setFrame:CGRectMake(dx, dy, dw, dh)];
        dx = dx;
        dy = dy + kActionButtonWidth+5.0f;
        [actionTitleLabel setFrame:CGRectMake(dx, dy, kActionButtonWidth, kTitleLabelHeight)];
        
        if (i == 3) {
            UIView *lineView =
            [[UIView alloc] initWithFrame:CGRectMake(.0f, dy+20.0f, width, 1.0f)];
            [lineView setBackgroundColor:[UIColor lightGrayColor]];
            [self.contentView addSubview:lineView];
        }
        
        if (i == count-1) {
            UIView *lineView =
            [[UIView alloc] initWithFrame:CGRectMake(.0f, dy+20.0f, width, 1.0f)];
            [lineView setBackgroundColor:[UIColor lightGrayColor]];
            [self.contentView addSubview:lineView];
        }
        
        [self.contentView addSubview:shareButton];
        [self.contentView addSubview:actionTitleLabel];
    }
    
    CGFloat height = [UIScreen mainScreen].bounds.size.width*self.scal;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn setFrame:CGRectMake(.0f, height-kCancelButtonHeight*2, width, kCancelButtonHeight)];
    
    [cancelBtn addTarget:self
                  action:@selector(touchDownRemoveView)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:cancelBtn];
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0f, kWidth, 20)];
    titlelabel.text = title;
    titlelabel.textColor = [UIColor blackColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:14];
    return titlelabel;
}

-(void)didSelectImageItem:(UIButton *)btn{
    
    WSelf(weakSelf)
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.contentView.frame = CGRectMake(0,
                                                [UIScreen mainScreen].bounds.size.height,
                                                [UIScreen mainScreen].bounds.size.width,
                                                0);
    } completion:^(BOOL finished) {
        SSelf(strongSelf)
        if (strongSelf.buttonPressedBlock) {
            strongSelf.buttonPressedBlock(btn.tag);
        }
        [strongSelf removeFromSuperview];
    }];
}

@end
