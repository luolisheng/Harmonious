//
//  LLSProductViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/18.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSProductViewController.h"

#import "LLSProductCell.h"
#import "LLSProgerssHUD.h"

static CGFloat const kHeight_Estimated = 480.0f;

@interface LLSProductViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL isPCViewController;
@property (nonatomic, strong) LLSProduct *product;

@end

@implementation LLSProductViewController

- (instancetype)initWithProduct:(LLSProduct *)product
                 controllerType:(LLSProductViewControllerType)type {
    self = [super init];
    if (self) {
        _product = product;
        _isPCViewController = (type == LLSProductViewControllerType_PC);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_isPCViewController) {
        [self.titleBar setTitleBarWithTitle:@"Speaking Etiquette"
                                      image:[UIImage imageNamed:@"tib_se"]
                    titleButtonPressedBlock:nil 
                     moreButtonPressedBlock:nil];
    }
    WSelf(weakSelf)
    [self setProductCollectBlock:^{
        [weakSelf.businessManager collectProductWithProductId:weakSelf.product.productId
                                             completedHandler:^(id responseObject, NSString *message, NSError *error)
        {
            [LLSProgerssHUD showHUDAddedTo:weakSelf.view animated:YES withMessage:message];
        }];
    }];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setRowHeight:UITableViewAutomaticDimension];
    [_tableView setEstimatedRowHeight:kHeight_Estimated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLSProductCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LLSProductCell class])];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LLSProductCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    };
    cell.titleLabel.text = _isPCViewController ? @"精粹苑" : @"言礼堂";
    [cell configCellWithProduct:_product];
    
    return cell;
}

@end
