//
//  LLSCollectionCell.m
//  Harmonious
//
//  Created by luolisheng on 15/4/22.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSCollectionCell.h"

#import <HexColors/HexColor.h>
#import <XLRemoteImageView/UIImageView+XLProgressIndicator.h>

@interface LLSCollectionCell ()

@property (nonatomic, strong) LLSProduct *product;
@property (nonatomic, strong) DeleteButtonPressedBlock pressedBlock;

@end

@implementation LLSCollectionCell

- (void)awakeFromNib {
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [_deleteButton setBackgroundColor:[UIColor colorWithHexString:@"D30003"]];
}

- (void)configCellWithProduct:(LLSProduct *)product {
    _product = product;
    
    NSString *imageURLStr = [kBaseURL_Img stringByAppendingPathComponent:product.productHead];
    [_avatarImageView setImageWithProgressIndicatorAndURL:[NSURL URLWithString:imageURLStr]];
    
    [_nameLabel setText:product.productName];
}

- (void)setDeleteButtonPressedBlock:(DeleteButtonPressedBlock)block {
    _pressedBlock = block;
}

- (IBAction)deleteButtonPressed:(id)sender {
    if (_pressedBlock) {
        _pressedBlock(_product.productId);
    }
}

@end
