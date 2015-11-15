//
//  LLSPithyCourtModel.h
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLSProduct.h"

@interface LLSPithyCourt : NSObject

@property (nonatomic, assign) NSInteger jincuiId;
@property (nonatomic, strong) NSString *jincuiName;
@property (nonatomic, strong) NSString *jincuiHead;
@property (nonatomic, strong) NSString *jincuiDate;
@property (nonatomic, strong) NSString *jincuiContent;

@property (nonatomic, strong) NSArray *products;

@end
