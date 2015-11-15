//
//  LLSProductViewController.h
//  Harmonious
//
//  Created by luolisheng on 15/4/18.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSBaseProductViewController.h"

#import "LLSProduct.h"

typedef NS_ENUM(NSInteger, LLSProductViewControllerType) {
    LLSProductViewControllerType_PC = 0,
    LLSProductViewControllerType_SE
};

@interface LLSProductViewController : LLSBaseProductViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithProduct:(LLSProduct *)product
                 controllerType:(LLSProductViewControllerType)type;

@end
