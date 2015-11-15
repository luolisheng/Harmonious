//
//  LLSTraditionalCraftsViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTreasureHouseDetailViewController.h"

#import "LLSProductCell.h"
#import "LLSProgerssHUD.h"
#import "LLSActionView.h"

static NSString *const kPanelViewIdentifier = @"LLSPanelView";
static NSString *const kPanelViewCellIdentifier = @"LLSPanelViewCell";

@interface LLSTreasureHouseDetailViewController ()

@property (nonatomic, strong) NSArray *products;

@property (nonatomic, assign) THouseDetailType thouseDetailType;

@property (nonatomic, strong) UIImage *image;

@end

@implementation LLSTreasureHouseDetailViewController

- (instancetype)initWithType:(THouseDetailType)type {
    self = [super init];
    if (self) {
        _thouseDetailType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSelf(weakSelf)
    [self.titleBar setTitleBarWithTitle:@"Treasure House"
                                  image:[UIImage imageNamed:@"tib_th"]
                titleButtonPressedBlock:^{
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                } moreButtonPressedBlock:^{
                    weakSelf.image = [UIImage lls_screenShot];
                    [weakSelf showActionView];
                }];
    
    [LLSProgerssHUD showLoadingHUDAddedTo:self.view animated:YES];
    
    [self.businessManager fetchTreasureHouseDetailDataWithType:_thouseDetailType
                                              completedHandler:^(id responseObject, NSString *message, NSError *error)
    {
        SSelf(strongSelf)
        if (error) {
            [LLSProgerssHUD showHUDAddedTo:strongSelf.view animated:YES
                               withMessage:[error localizedDescription]];
        } else {
            strongSelf.products = (NSArray *)responseObject;
            [strongSelf loadData];
            
            [LLSProgerssHUD hideHUDForView:strongSelf.view animated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- Show actionview

- (void)showActionView {
    NSArray *actionButtonTitles = @[@"新浪微博",
                                    @"腾讯微博",
                                    @"微信好友",
                                    @"朋友圈",
                                    @"收藏",
                                    @"联系我们"];
    NSArray *actionButtonImages = @[@"am_sinaweibo",
                                    @"am_txweibo",
                                    @"am_wechatsession",
                                    @"am_wechattml",
                                    @"am_collection",
                                    @"am_contact"];
    
    LLSActionView *actionView = [[LLSActionView alloc] initWithTitle:@"分享到"
                                                  actionButtonTitles:actionButtonTitles
                                                  actionButtonImages:actionButtonImages];
    WSelf(weakSelf)
    [actionView setActionButtonPressedBlock:^(NSInteger index) {
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
                if (![self.businessManager loginAccount]) {
                    [LLSProgerssHUD showHUDAddedTo:self.view animated:YES withMessage:@"请登录"];
                } else {
                    [weakSelf collectProduct];
                }
                return;
            }
                break;
            case 5: {
                NSString *urlStr = @"tel://4006570880";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                return;
            }
                break;
            default:
                break;
        }
        
        [weakSelf.shareSDKManager shareWithContent:@"贵为和，app store下载链接 https://itunes.apple.com/us/app/gui-wei-he/id1020572201?mt=8"
                                             image:weakSelf.image
                                              type:shareType
                                  completedHandler:^(BOOL result)
         {
             [LLSProgerssHUD showHUDAddedTo:weakSelf.view
                                   animated:YES
                                withMessage:(result?@"分享成功":@"分享失败")];
         }];
    }];
    [actionView show];
}

- (void)collectProduct {
    LLSProduct *product = _products[self.currentPage];
    WSelf(weakSelf)
    [self.businessManager collectProductWithProductId:product.productId
                                     completedHandler:^(id responseObject, NSString *message, NSError *error)
     {
         [LLSProgerssHUD showHUDAddedTo:weakSelf.view
                               animated:YES
                            withMessage:(error?@"收藏失败":@"收藏成功")];
     }];
}

#pragma mark -- Panel count / Panel view

- (NSInteger)numberOfPanels {
    return _products.count;
}

- (PanelView *)panelForPage:(NSInteger)page {
    PanelView *panelView = (PanelView*)[self dequeueReusablePageWithIdentifier:kPanelViewIdentifier];
    if (!panelView) {
        panelView = [[PanelView alloc] initWithIdentifier:kPanelViewIdentifier];
    }
    
    return panelView;
}

#pragma mark -- PanelViewDelegate

- (NSInteger)panelView:(id)panelView numberOfSectionsInPage:(NSInteger)pageNumber {
    return 1;
}

- (NSInteger)panelView:(id)panelView numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return 1;
}

- (CGFloat)panelView:(id)panelView heightForRowAtIndexPath:(PanelIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)panelView:(id)panelView cellForRowAtIndexPath:(PanelIndexPath *)indexPath {
    LLSProductCell *cell =
    [((PanelView *)panelView).tableView dequeueReusableCellWithIdentifier:kPanelViewCellIdentifier];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LLSProductCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSString *title = @"";
    switch (_thouseDetailType) {
        case THouseDetailType_TC:
            title = @"传统工艺";
            break;
        case THouseDetailType_FP:
            title = @"外事精粹";
            break;
        case THouseDetailType_CI:
            title = @"中国创新";
            break;
    }
    cell.titleLabel.text = title;
    [cell configCellWithProduct:_products[indexPath.page]];
    
    return cell;
}

@end
