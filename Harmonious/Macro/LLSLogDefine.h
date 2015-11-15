//
//  LLSLogDefine.h
//  Harmonious
//
//  Created by luolisheng on 15/4/10.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#ifndef Harmonious_LLSLogDefine_h
#define Harmonious_LLSLogDefine_h

#ifdef DEBUG
    #define LLSLog(format, ...) \
        do { \
            NSLog(@"<%@ : %d : %s> -- : %@", \
            [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
            __LINE__, \
            __FUNCTION__, \
            [NSString stringWithFormat:format, ##__VA_ARGS__]); \
        } while(0)
#else
    #define LLSLog(format, ...) do{} while(0)
#endif

#endif
