//
//  LLSTreasureHouseViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/5.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTreasureHouseViewController.h"
#import "LLSTreasureHouseDetailViewController.h"

#import "LLSTreasureHouseView.h"

@interface LLSTreasureHouseViewController ()

@end

@implementation LLSTreasureHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleBar setTitleBarWithTitle:@"Treasure House"
                                  image:[UIImage imageNamed:@"tib_th"]
                titleButtonPressedBlock:nil 
                 moreButtonPressedBlock:nil];
    
    LLSTreasureHouseView *thView = [[LLSTreasureHouseView alloc] initWithFrame:self.view.bounds];
    [thView setButtonPressedBlock:^(NSInteger tag) {
        [self jumpToDetailWith:tag];
    }];
    
    [self.view addSubview:thView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)jumpToDetailWith:(NSInteger)tag {
    NSInteger controllerType = -1;
    switch (tag) {
        case 0:
            controllerType = THouseDetailType_TC;
            break;
        case 1:
            controllerType = THouseDetailType_FP;
            break;
        case 2:
            controllerType = THouseDetailType_CI;
            break;
        default:
            break;
    }
    LLSTreasureHouseDetailViewController *viewController =
    [[LLSTreasureHouseDetailViewController alloc] initWithType:controllerType];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:viewController]
                       animated:YES
                     completion:nil];
}

@end
