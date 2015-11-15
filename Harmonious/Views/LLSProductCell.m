//
//  LLSProductCell.m
//  Harmonious
//
//  Created by luolisheng on 15/4/18.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSProductCell.h"

#import "NSString+LLSString.h"

#import <XLRemoteImageView/UIImageView+XLProgressIndicator.h>

@interface LLSProductCell ()

@property (nonatomic, strong) LLSProduct *product;

@end

@implementation LLSProductCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configCellWithProduct:(LLSProduct *)product {
    self.product = product;
    
    NSString *headImgStrURL = [kBaseURL_Img stringByAppendingPathComponent:product.productHead];
    [_headImageView setImageWithProgressIndicatorAndURL:[NSURL URLWithString:headImgStrURL]];
    
    [_nameLabel setText:product.productName];
    [_numLabel setText:product.productNum];
    [_contentLabel setText:product.productContext];
    
    NSString *firstImageStrURL = [kBaseURL_Img stringByAppendingPathComponent:product.productImg1];
    NSString *secImageStrURL = [kBaseURL_Img stringByAppendingPathComponent:product.productImg2];
    NSString *thirdImageURL = [kBaseURL_Img stringByAppendingPathComponent:product.productImg3];
    [_imageViewFirst setImageWithProgressIndicatorAndURL:[NSURL URLWithString:firstImageStrURL]];
    [_imageViewSec setImageWithProgressIndicatorAndURL:[NSURL URLWithString:secImageStrURL]];
    [_imageViewThird setImageWithProgressIndicatorAndURL:[NSURL URLWithString:thirdImageURL]];

    
    [_swLabel.layer setBorderWidth:1.0f];
    [_swLabel.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line"]] CGColor]];
    [_bzLabel.layer setBorderWidth:1.0f];
    [_bzLabel.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line"]] CGColor]];
    
    [_swSize setText:product.productSW];
    [_bzSize setText:product.productBZ];
    
    [_priceLabel setText:product.productPrice];
    
    [_phoneLabel setText:[NSString stringWithFormat:@"电话: %@", product.productPhone]];
    [_faxLabel setText:[NSString stringWithFormat:@"传真: %@", product.productCZ]];
    [_adressLabel setText:[NSString stringWithFormat:@"地址: %@", product.productAddress]];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if ([NSString lls_isEmpty:self.product.productImg1]) {
        _productImgOneHeight.constant = 0;
        _imageViewFirst.hidden = YES;
    }
    if ([NSString lls_isEmpty:self.product.productImg2]) {
        _productImgTwoHeight.constant = 0;
        _imageViewSec.hidden = YES;
    }
}

@end
