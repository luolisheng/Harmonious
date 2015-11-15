//
//  LLSProductModel.h
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLSProduct : NSObject

@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productHead;
@property (nonatomic, strong) NSString *productContext;

@property (nonatomic, strong) NSString *productImg1;
@property (nonatomic, strong) NSString *productImg2;
@property (nonatomic, strong) NSString *productImg3;

@property (nonatomic, strong) NSString *productNum;
@property (nonatomic, strong) NSString *productSW;
@property (nonatomic, strong) NSString *productBZ;
@property (nonatomic, strong) NSString *productCZ;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *productPhone;
@property (nonatomic, strong) NSString *productAddress;

@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, assign) NSInteger contentId;

@end
