//
//  LLSAccountDAO.h
//  Harmonious
//
//  Created by luolisheng on 15/4/21.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLSAccount.h"

@interface LLSAccountDAO : NSObject

+ (void)saveLoginAccount:(LLSAccount *)account;

+ (LLSAccount *)loginAccount;

@end
