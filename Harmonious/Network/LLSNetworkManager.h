//
//  LLSNetworkManager.h
//  Harmonious
//
//  Created by luolisheng on 15/4/9.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^NetworkCompletedHandler)(id responseObject, NSError *error);

@interface LLSNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
               completedHandler:(NetworkCompletedHandler)completedHandler;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters 
                completedHandler:(NetworkCompletedHandler)completedHandler;

@end
