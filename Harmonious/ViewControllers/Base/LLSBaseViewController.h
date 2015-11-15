//
//  LLSPithyCourtViewController.h
//  Harmonious
//
//  Created by luolisheng on 15/4/5.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLSTittleBar.h"
#import "PanelsViewController.h"

#import "LLSBusinessManager.h"
#import "LLSShareSDKManager.h"

@interface LLSBaseViewController : PanelsViewController

@property (nonatomic, strong) LLSTittleBar *titleBar;

@property (nonatomic, strong) LLSBusinessManager *businessManager;
@property (nonatomic, strong) LLSShareSDKManager *shareSDKManager;

@end
