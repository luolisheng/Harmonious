//
//  LLSAccount.m
//  Harmonious
//
//  Created by luolisheng on 15/4/21.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSAccount.h"

static NSString *const kUserId = @"userId";
static NSString *const kUserName = @"userName";
static NSString *const kUserNick = @"userNick";

@implementation LLSAccount

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _userId = [[aDecoder decodeObjectForKey:kUserId] integerValue];
        _userName = [aDecoder decodeObjectForKey:kUserName];
        _userNick = [aDecoder decodeObjectForKey:kUserNick];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(_userId) forKey:kUserId];
    [aCoder encodeObject:_userName forKey:kUserName];
    [aCoder encodeObject:_userNick forKey:kUserNick];
}

@end
