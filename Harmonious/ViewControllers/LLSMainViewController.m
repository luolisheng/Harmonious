//
//  ViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/4.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSMainViewController.h"
#import "LLSPithyCourtViewController.h"
#import "LLSSpeakEtiqViewController.h"
#import "LLSTreasureHouseViewController.h"
#import "LLSSettingsViewController.h"

static CGFloat const kHeight_SegmentControl = 44.0f;

@interface LLSMainViewController ()

@property (nonatomic, strong) UINavigationController *selectedViewController;

@property (nonatomic, strong) UINavigationController *pithyCourtNavigationController;
@property (nonatomic, strong) UINavigationController *speakEtiqNavigationController;
@property (nonatomic, strong) UINavigationController *treasureHouseNavigationController;
@property (nonatomic, strong) UINavigationController *settingsNavigationController;

@end

@implementation LLSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat dx = .0f;
    CGFloat dy = .0f;
    CGFloat dw = SCREEN_WIDTH;
    CGFloat dh = SCREEN_HEIGHT - kHeight_SegmentControl;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(dx, dy, dw, dh)];
    
    
    dy = dh;
    dh = kHeight_SegmentControl;
    _segmentControl = [[LLSSegmentedControl alloc] initWithFrame:CGRectMake(dx, dy, dw, dh)];
    [_segmentControl setImags:@[[UIImage imageNamed:@"tb_pithy_court"],
                                [UIImage imageNamed:@"tb_speak_etiq"],
                                [UIImage imageNamed:@"tb_treasure_house"],
                                [UIImage imageNamed:@"tb_me"]]
               selectedImages:@[[UIImage imageNamed:@"tb_pithy_court_hl"],
                                [UIImage imageNamed:@"tb_speak_etiq_hl"],
                                [UIImage imageNamed:@"tb_treasure_house_hl"],
                                [UIImage imageNamed:@"tb_me_hl"]]];
    
    [_segmentControl setSelectedWithIndex:0];
    
    __weak typeof(self)weakSelf = self;
    [_segmentControl setSegmentPressed:^(NSInteger index) {
        [weakSelf addChildViewControllerWithIndex:index];
    }];
    
    [self.view addSubview:_containerView];
    [self.view addSubview:_segmentControl];
    
    [self addChildViewControllerWithIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- Get childViewController to add

- (void)addChildViewControllerWithIndex:(NSInteger)index {
    if (index < 0) {
        return;
    }
    if (_selectedViewController) {
        [_selectedViewController.view removeFromSuperview];
    }
    
    UINavigationController *viewController;
    switch (index) {
        case 0:
            if (!_pithyCourtNavigationController) {
                _pithyCourtNavigationController =
                [[UINavigationController alloc] initWithRootViewController:[[LLSPithyCourtViewController alloc] init]];
                
                [self addChildViewController:_pithyCourtNavigationController];
                [_pithyCourtNavigationController didMoveToParentViewController:self];
            }
            viewController = _pithyCourtNavigationController;
            break;
        case 1:
            if (!_speakEtiqNavigationController) {
                _speakEtiqNavigationController =
                [[UINavigationController alloc] initWithRootViewController:[[LLSSpeakEtiqViewController alloc] init]];
                
                [self addChildViewController:_speakEtiqNavigationController];
                [_speakEtiqNavigationController didMoveToParentViewController:self];
            }
            viewController = _speakEtiqNavigationController;
            break;
        case 2:
            if (!_treasureHouseNavigationController) {
                _treasureHouseNavigationController =
                [[UINavigationController alloc] initWithRootViewController:[[LLSTreasureHouseViewController alloc] init]];

                [self addChildViewController:_treasureHouseNavigationController];
                [_treasureHouseNavigationController didMoveToParentViewController:self];
            }
            viewController = _treasureHouseNavigationController;
            break;
        case 3:
            if (!_settingsNavigationController) {
                _settingsNavigationController =
                [[UINavigationController alloc] initWithRootViewController:[[LLSSettingsViewController alloc] initWithNibName:@"LLSSettingsViewController" bundle:nil]];

                [self addChildViewController:_settingsNavigationController];
                [_settingsNavigationController didMoveToParentViewController:self];
            }
            viewController = _settingsNavigationController;
            break;
        default:
            break;
    }
    _selectedViewController = viewController;
    
    [viewController.view setFrame:_containerView.bounds];
    
    [_containerView addSubview:viewController.view];
}

@end
