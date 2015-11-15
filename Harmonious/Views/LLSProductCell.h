//
//  LLSProductCell.h
//  Harmonious
//
//  Created by luolisheng on 15/4/18.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLSProduct.h"

@interface LLSProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSec;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThird;

@property (weak, nonatomic) IBOutlet UILabel *bzLabel;
@property (weak, nonatomic) IBOutlet UILabel *swSize;
@property (weak, nonatomic) IBOutlet UILabel *bzSize;
@property (weak, nonatomic) IBOutlet UILabel *swLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *faxLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImgOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImgTwoHeight;

- (void)configCellWithProduct:(LLSProduct *)product;

@end
