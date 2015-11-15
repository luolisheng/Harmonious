//
//  NSString+LLSString.h
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LLSString)

+ (BOOL)lls_isEmpty:(NSString *)string;

+ (BOOL)lls_isPhoneNum:(NSString *)string;

@end
