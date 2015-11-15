//
//  LLSSpeakEtiqViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/5.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSSpeakEtiqViewController.h"
#import "LLSProductViewController.h"

#import "LLSTableViewCell.h"
#import "LLSTableViewImageCell.h"
#import "LLSProgerssHUD.h"

static NSString *const kPanelViewIdentifier = @"LLSPanelView";
static NSString *const kPanelViewIdentifier_Cell = @"LLSPanelViewCell";
static NSString *const kPanelViewIdentifier_ImageCell = @"LLSPanelViewImageCell";

@interface LLSSpeakEtiqViewController ()

@property (nonatomic, strong) NSArray *speakEtiqs;
@property (nonatomic, strong) LLSGeImge *geImage;

@end

@implementation LLSSpeakEtiqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleBar setTitleBarWithTitle:@"Speaking Etiquette"
                                  image:[UIImage imageNamed:@"tib_se"]
                titleButtonPressedBlock:nil
                 moreButtonPressedBlock:nil];
    
    [LLSProgerssHUD showLoadingHUDAddedTo:self.view animated:YES];
    WSelf(weakSelf)
    [self.businessManager fetchSpeakingEtiquetteDataWithCompletedHandler:^(id responseObject, NSString *message, NSError *error) {
        SSelf(strongSelf)
        if (error) {
            [LLSProgerssHUD showHUDAddedTo:strongSelf.view animated:YES
                               withMessage:[error localizedDescription]];
        } else {
            strongSelf.speakEtiqs = (NSArray *)responseObject;
            [strongSelf loadData];
            
            [LLSProgerssHUD hideHUDForView:strongSelf.view animated:YES];
        }
    }];
    
//    [self.businessManager fetchGeImageDataWithCompletedHandler:^(id responseObject, NSString *message, NSError *error) {
//        if (!error) {
//            weakSelf.geImage = (LLSGeImge *)responseObject;
//        }
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)jumpToProductWith:(NSInteger)productId {
    NSInteger page = self.currentPage;
    NSArray *products = ((LLSPithyCourt *)_speakEtiqs[page/2]).products;
    
    WSelf(weakSelf)
    [products enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SSelf(strongSelf)
        LLSProduct *product = (LLSProduct *)obj;
        if (product.productId == productId) {
            *stop = YES;
            LLSProductViewController *productViewController = [[LLSProductViewController alloc] initWithProduct:product controllerType:LLSProductViewControllerType_SE];
            
            [strongSelf presentViewController:[[UINavigationController alloc] initWithRootViewController:productViewController]
                                     animated:YES
                                   completion:nil];
        }
    }];
}

#pragma mark -- Panel count / Panel view

- (NSInteger)numberOfPanels {
    return (_speakEtiqs.count)+2;
}

- (PanelView *)panelForPage:(NSInteger)page {
    PanelView *panelView =
    (PanelView*)[self dequeueReusablePageWithIdentifier:kPanelViewIdentifier];
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
    if ((indexPath.page)%2 == 0) {
        return UITableViewAutomaticDimension;
    } else {
        return CGRectGetHeight(self.view.bounds);
    }
}

- (UITableViewCell *)panelView:(id)panelView cellForRowAtIndexPath:(PanelIndexPath *)indexPath {
    NSInteger page = indexPath.page;
    switch (page) {
        case 1:
        case 3: {
            LLSTableViewImageCell *cell =
            [((PanelView *)panelView).tableView dequeueReusableCellWithIdentifier:kPanelViewIdentifier_ImageCell];
            if (!cell) {
                cell =
                [[[NSBundle mainBundle] loadNibNamed:@"LLSTableViewImageCell" owner:self options:nil] firstObject];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [self.businessManager fetchGeImageDataWithURLStr:(page==1)?kURL_GeImg1:kURL_GeImg2
                                            completedHandler:^(id responseObject, NSString *message, NSError *error)
            {
                if (!error) {
                    [cell configCellWithImageName:((LLSGeImge *)responseObject).geImg];
                }
            }];
            
            return cell;
        }
        default: {
            LLSTableViewCell *cell =
            [((PanelView *)panelView).tableView dequeueReusableCellWithIdentifier:kPanelViewIdentifier_Cell];
            if (!cell) {
                cell =
                [[[NSBundle mainBundle] loadNibNamed:@"LLSTableViewCell" owner:self options:nil] firstObject];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            WSelf(weakSelf)
            [cell configCellWithObject:_speakEtiqs[(indexPath.page)/2]];
            [cell setProductTapedBlock:^(NSInteger Id) {
                [weakSelf jumpToProductWith:Id];
            }];
            return cell;
        }
    }
}

@end
