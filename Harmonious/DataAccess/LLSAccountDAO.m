//
//  LLSAccountDAO.m
//  Harmonious
//
//  Created by luolisheng on 15/4/21.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSAccountDAO.h"

static NSString *const kLoginAccount = @"LoginAccount";

@implementation LLSAccountDAO

+ (void)saveLoginAccount:(LLSAccount *)account {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account];
    [UserDefaults setObject:data forKey:kLoginAccount];
}

+ (LLSAccount *)loginAccount {
    NSData *data = [UserDefaults objectForKey:kLoginAccount];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
