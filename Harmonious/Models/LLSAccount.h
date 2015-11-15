//
//  LLSAccount.h
//  Harmonious
//
//  Created by luolisheng on 15/4/21.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLSAccount : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userNick;

@end
