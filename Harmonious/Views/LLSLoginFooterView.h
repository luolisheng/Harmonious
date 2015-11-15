//
//  LLSLoginFooterView.h
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SocialButtonPressed)(NSInteger tag);

@interface LLSLoginFooterView : UIView

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifCodeTextField;

- (void)setSocialButtonPressedBlock:(SocialButtonPressed)block;

- (IBAction)buttonPressed:(id)sender;

@end
