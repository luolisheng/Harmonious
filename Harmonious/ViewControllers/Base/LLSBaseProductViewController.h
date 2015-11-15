//
//  LLSProductBaseViewController.h
//  Harmonious
//
//  Created by luolisheng on 15/4/13.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLSTittleBar.h"

#import "LLSBusinessManager.h"
#import "LLSShareSDKManager.h"

typedef void(^ProductCollectBlock)();

@interface LLSBaseProductViewController : UIViewController

@property (nonatomic, strong) LLSTittleBar *titleBar;

@property (nonatomic, strong) LLSBusinessManager *businessManager;
@property (nonatomic, strong) LLSShareSDKManager *shareSDKManager;

- (void)setProductCollectBlock:(ProductCollectBlock)block;

@end
