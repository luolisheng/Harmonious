//
//  LLSSpeakEtiqModel.h
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLSSpeakEtiquette : NSObject

@property (nonatomic, assign) NSInteger yanliId;
@property (nonatomic, strong) NSString *yanliName;
@property (nonatomic, strong) NSString *yanliHead;
@property (nonatomic, strong) NSString *yanliDate;
@property (nonatomic, strong) NSString *yanliContent;

@property (nonatomic, strong) NSArray *products;

@end
