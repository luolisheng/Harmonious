//
//  NSString+LLSString.m
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "NSString+LLSString.h"

@implementation NSString (LLSString)

+ (BOOL)lls_isEmpty:(NSString *)string {
    BOOL isEmpty = NO;
    if (string == nil) {
        isEmpty = YES;
    }
    else if ([string isEqualToString:@""]) {
        isEmpty = YES;
    }
    else if ([string class] == [NSNull null]) {
        isEmpty = YES;
    }
    NSString *tempStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (tempStr.length == 0) {
        isEmpty = YES;
    }
    return isEmpty;
}

+ (BOOL)lls_isPhoneNum:(NSString *)string {
    if ([NSString lls_isEmpty:string]) {
        return NO;
    }

    NSString *phoneNumStr = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneNumStr.length == 11) {
        NSString *phoneRegex = @"^(13[\\d]{9}|15[\\d]{9}|18[\\d]{9}|14[5,6,7][\\d]{8}|17[\\d]{9})$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phoneTest evaluateWithObject:phoneNumStr];
    }
    
    return NO;
}

@end
