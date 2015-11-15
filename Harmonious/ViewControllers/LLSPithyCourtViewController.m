//
//  LLSPithyCourtViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/7.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSPithyCourtViewController.h"
#import "LLSProductViewController.h"

#import "LLSTableViewCell.h"
#import "LLSTableViewImageCell.h"
#import "LLSProgerssHUD.h"

static NSString *const kPanelViewIdentifier = @"LLSPanelView";
static NSString *const kPanelViewIdentifier_Cell = @"LLSPanelViewCell";
static NSString *const kPanelViewIdentifier_ImageCell = @"LLSPanelViewImageCell";

@interface LLSPithyCourtViewController ()

@property (nonatomic, strong) NSArray *pithyCourts;
@property (nonatomic, strong) LLSGeImge *geImage;

@end

@implementation LLSPithyCourtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LLSProgerssHUD showLoadingHUDAddedTo:self.view animated:YES];
    WSelf(weakSelf)
    [self.businessManager fetchPithyCourtDataWithCompletedHandler:^(id responseObject, NSString *message, NSError *error) {
        SSelf(strongSelf)
        if (error) {
            [LLSProgerssHUD showHUDAddedTo:strongSelf.view animated:YES
                               withMessage:[error localizedDescription]];
        } else {
            strongSelf.pithyCourts = (NSArray *)responseObject;
            [strongSelf loadData];
            
            [LLSProgerssHUD hideHUDForView:strongSelf.view animated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)jumpToProductWith:(NSInteger)productId {
    NSInteger page = self.currentPage;
    NSArray *products = ((LLSPithyCourt *)_pithyCourts[page/2]).products;
    
    WSelf(weakSelf)
    [products enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SSelf(strongSelf)
        LLSProduct *product = (LLSProduct *)obj;
        if (product.productId == productId) {
            *stop = YES;
            LLSProductViewController *productViewController = [[LLSProductViewController alloc] initWithProduct:product controllerType:LLSProductViewControllerType_PC];
            
            [strongSelf presentViewController:[[UINavigationController alloc] initWithRootViewController:productViewController]
                                     animated:YES
                                   completion:nil];
        }
    }];
}

#pragma mark -- Panel count / Panel view

- (NSInteger)numberOfPanels {
    return (_pithyCourts.count)+2;
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
            [self.businessManager fetchGeImageDataWithURLStr:(page==1)?kURL_GeImg3:kURL_GeImg4
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
            [cell configCellWithObject:_pithyCourts[(indexPath.page)/2]];
            [cell setProductTapedBlock:^(NSInteger Id) {
                [weakSelf jumpToProductWith:Id];
            }];
            return cell;
        }
    }
}

@end
