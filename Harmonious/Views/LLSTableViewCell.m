//
//  LLSTableViewCell.m
//  Harmonious
//
//  Created by luolisheng on 15/4/14.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTableViewCell.h"

#import <XLRemoteImageView/UIImageView+XLProgressIndicator.h>

@interface LLSTableViewCell ()

@property (nonatomic, copy)  ProductTapedBlock tapedBlock;

@end

@implementation LLSTableViewCell

- (void)awakeFromNib {
    [_productOne addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(productTaped:)]];
    [_productTwo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(productTaped:)]];
    [_productThree addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(productTaped:)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configCellWithObject:(id)object {
    NSString *name;
    NSString *headImgURLStr;
    NSString *content;
    __block NSString *date;
    
    NSArray *products;
    __block NSString *productOneURLStr;
    __block NSString *productTwoURLStr;
    __block NSString *productThreeURLStr;
    
    if ([object isMemberOfClass:[LLSPithyCourt class]]) {
        LLSPithyCourt *pithyCourt = (LLSPithyCourt *)object;
        
        name = pithyCourt.jincuiName;
        headImgURLStr = [kBaseURL_Img stringByAppendingPathComponent:pithyCourt.jincuiHead];
        date = pithyCourt.jincuiDate;
        content = pithyCourt.jincuiContent;
        products = pithyCourt.products;
    } else if ([object isMemberOfClass:[LLSSpeakEtiquette class]]) {
        LLSSpeakEtiquette *speakEtiq = (LLSSpeakEtiquette *)object;
        
        name = speakEtiq.yanliName;
        headImgURLStr = [kBaseURL_Img stringByAppendingPathComponent:speakEtiq.yanliHead];
        date = speakEtiq.yanliDate;
        content = speakEtiq.yanliContent;
        products = speakEtiq.products;
    }
    
    [_nameLabel setText:name];
    [_headImageView setImageWithProgressIndicatorAndURL:[NSURL URLWithString:headImgURLStr]];
    [_contentLabel setText:content];
    
    NSArray *strs = [date componentsSeparatedByString:@"-"];
    if (strs) {
        NSMutableArray *mutStrs = [[NSMutableArray alloc] initWithArray:strs];
        [mutStrs exchangeObjectAtIndex:0 withObjectAtIndex:mutStrs.count-1];
        [mutStrs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            switch (idx) {
                case 0:
                    date = [obj stringByAppendingString:@"\n"];
                    break;
                case 1:
                    date = [date stringByAppendingFormat:@"%@ ", obj];
                    break;
                case 2:
                    date = [date stringByAppendingString:obj];
                    break;
                default:
                    break;
            }
        }];
        
        NSRange dayRange = [date rangeOfString:mutStrs[0]];
        if (dayRange.length > 0) {
            NSMutableAttributedString *attributedStr =[[NSMutableAttributedString alloc]initWithString:date];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineHeightMultiple:.6f];
            [paragraphStyle setAlignment:NSTextAlignmentCenter];
            
            NSDictionary *attributedDict = @{NSParagraphStyleAttributeName : paragraphStyle,
                                             NSForegroundColorAttributeName: [UIColor redColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:30.0f]};
            
            [attributedStr addAttributes:attributedDict range:dayRange];
            
            [_dateLabel setAttributedText:attributedStr];
        } else {
            [_dateLabel setText:date];
        }
    }
    
    [products enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LLSProduct *product = (LLSProduct *)obj;
        NSString *productImgURL = [kBaseURL_Img stringByAppendingPathComponent:product.productHead];
        switch (idx) {
            case 0:
                productOneURLStr = productImgURL;
                [_productOne setTag:product.productId];
                break;
            case 1:
                productTwoURLStr = productImgURL;
                [_productTwo setTag:product.productId];
                break;
            case 2:
                productThreeURLStr = productImgURL;
                [_productThree setTag:product.productId];
                break;
            default:
                break;
        }
    }];
    
    [_productOne setImageWithProgressIndicatorAndURL:[NSURL URLWithString:productOneURLStr]];
    [_productTwo setImageWithProgressIndicatorAndURL:[NSURL URLWithString:productTwoURLStr]];
    [_productThree setImageWithProgressIndicatorAndURL:[NSURL URLWithString:productThreeURLStr]];
}

- (void)setProductTapedBlock:(ProductTapedBlock)block {
    _tapedBlock = block;
}

#pragma mark -- Selector

- (void)productTaped:(UIGestureRecognizer *)tapGestureRecognizer {
    NSInteger productId = tapGestureRecognizer.view.tag;
    if (_tapedBlock) {
        _tapedBlock(productId);
    }
}

@end
