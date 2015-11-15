//
//  LLSPithyCourtViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/5.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSBaseViewController.h"

#import "LLSActionView.h"
#import "LLSProgerssHUD.h"

#import <HexColors/HexColor.h>

@interface LLSBaseViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIImage *image;

@end

@implementation LLSBaseViewController

- (id)init {
    self = [super init];
    if (self) {
        _businessManager = [LLSBusinessManager sharedInstance];
        _shareSDKManager = [LLSShareSDKManager sharedInstance];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _businessManager = [LLSBusinessManager sharedInstance];
        _shareSDKManager = [LLSShareSDKManager sharedInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.navigationController.navigationBar.bounds;
    
    WSelf(weakSelf)
    _titleBar = [[LLSTittleBar alloc] initWithFrame:frame];
    [_titleBar setTitleBarWithTitle:nil
                              image:nil
            titleButtonPressedBlock:nil
             moreButtonPressedBlock:^{
                 weakSelf.image = [UIImage lls_screenShot];
                 [weakSelf showActionView];
             }];
    
    [self.navigationController.navigationBar addSubview:_titleBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- Show action view

- (void)showActionView {
    NSArray *actionButtonTitles = @[@"新浪微博",
                                    @"腾讯微博",
                                    @"微信好友",
                                    @"朋友圈",
                                    @"联系我们"];
    NSArray *actionButtonImages = @[@"am_sinaweibo",
                                    @"am_txweibo",
                                    @"am_wechatsession",
                                    @"am_wechattml",
                                    @"am_contact"];
    LLSActionView *actionView = [[LLSActionView alloc] initWithTitle:@"分享到"
                                                  actionButtonTitles:actionButtonTitles 
                                                  actionButtonImages:actionButtonImages];
    WSelf(weakSelf)
    [actionView setActionButtonPressedBlock:^(NSInteger index) {
        [weakSelf shareWithIndex:index];
    }];
    [actionView show];
}

- (void)shareWithIndex:(NSInteger)index {
    ShareType shareType = -1;
    switch (index) {
        case 0:
            shareType = ShareTypeSinaWeibo;
            break;
        case 1:
            shareType = ShareTypeTencentWeibo;
            break;
        case 2:
            shareType = ShareTypeWeixiSession;
            break;
        case 3:
            shareType = ShareTypeWeixiTimeline;
            break;
        case 4: {
            [self showAlertView];
            return;
        }
            break;
        default:
            break;
    }
    // http://t.cn/RLQnOEq https://itunes.apple.com/us/app/gui-wei-he/id1020572201?mt=8
    WSelf(weakSelf)
    [_shareSDKManager shareWithContent:@"贵为和，app store下载链接 https://itunes.apple.com/us/app/gui-wei-he/id1020572201?mt=8"
                                 image:weakSelf.image
                                  type:shareType 
                      completedHandler:^(BOOL result)
    {
        [LLSProgerssHUD showHUDAddedTo:weakSelf.view
                              animated:YES 
                           withMessage:(result?@"分享成功":@"分享失败")];
    }];
}

- (void)showAlertView {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"是否拨打电话：4006570880" 
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 1) {
        return;
    }
    NSString *urlStr = @"tel://4006570880";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

@end
