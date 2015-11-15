//
//  LLSNetworkManager.m
//  Harmonious
//
//  Created by luolisheng on 15/4/9.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSNetworkManager.h"

@interface LLSNetworkManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *AFHTTPManager;

@end

@implementation LLSNetworkManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _AFHTTPManager = [AFHTTPRequestOperationManager manager];
        _AFHTTPManager.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"text/html", @"text/plain", nil];
               
        _AFHTTPManager.securityPolicy.allowInvalidCertificates = YES;
        
        [_AFHTTPManager.reachabilityManager startMonitoring];
        [_AFHTTPManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
        }];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static LLSNetworkManager *sharedInstance = nil;
    DISPATCH_ONCE_BLOCK(^{
        sharedInstance = [[LLSNetworkManager alloc] init];
    })
    
    return sharedInstance;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters 
               completedHandler:(NetworkCompletedHandler)completedHandler {
    AFHTTPRequestOperation *requestOperation =
    [_AFHTTPManager GET:URLString
             parameters:parameters 
                success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (completedHandler) {
            completedHandler(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completedHandler) {
            completedHandler(nil, error);
        }
    }];
    
    return requestOperation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters 
                completedHandler:(NetworkCompletedHandler)completedHandler {
    AFHTTPRequestOperation *requestOperation =
    [_AFHTTPManager POST:URLString 
              parameters:parameters 
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (completedHandler) {
            completedHandler(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completedHandler) {
            completedHandler(nil, error);
        }
    }];

    return requestOperation;
}

@end
