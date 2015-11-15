//
//  LLSManager.m
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSBusinessManager.h"
#import "LLSNetworkManager.h"
#import "LLSShareSDKManager.h"

#import "LLSAccountDAO.h"

#import <MJExtension/MJExtension.h>

@interface LLSBusinessManager ()

@property (nonatomic, strong) LLSNetworkManager *networkManager;
@property (nonatomic, strong) LLSShareSDKManager *shareSDKManager;

@property (nonatomic, strong) LLSAccount *loginAccount;

@end

@implementation LLSBusinessManager

#pragma mark -- Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkManager = [LLSNetworkManager sharedInstance];
        _shareSDKManager = [LLSShareSDKManager sharedInstance];
        
        _loginAccount = [LLSAccountDAO loginAccount];
    }
    
    return self;
}

#pragma mark -- Create singleton

+ (instancetype)sharedInstance {
    static LLSBusinessManager *businessManager = nil;
    DISPATCH_ONCE_BLOCK(^{
        businessManager = [[LLSBusinessManager alloc] init];
    });
    
    return businessManager;
}

#pragma mark Get login account 

- (LLSAccount *)loginAccount {
    return _loginAccount;
}

#pragma mark -- Login

- (void)loginWithUserId:(NSString *)userId
               nickName:(NSString *)nickName 
       completedHandler:(BusinessCompletedHandler)completedHandler {
    NSDictionary *paramsDict = @{@"userId": userId,
                                 @"userNick": nickName,
                                 @"userName": [NSString stringWithFormat:@"%@%@", nickName, userId]};
    WSelf(weakSelf)
    [_networkManager GET:kURL_Login
              parameters:paramsDict
        completedHandler:^(id responseObject, NSError *error)
    {
        if (!error) {
            NSInteger msgCode = [(NSNumber *)responseObject[@"msgcode"] integerValue];
            if (msgCode == 1) {
                NSDictionary *userInfo = responseObject[@"userinfo"];
                LLSAccount *account = [LLSAccount objectWithKeyValues:userInfo];
                weakSelf.loginAccount = account;
                [LLSAccountDAO saveLoginAccount:weakSelf.loginAccount];
                
                NSArray *productItems = responseObject[@"listshoucang"];
                NSMutableArray *products = [NSMutableArray array];
                [productItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    LLSProduct *product = [LLSProduct objectWithKeyValues:obj];
                    if (product) {
                        [products addObject:product];
                    }
                }];
                
                if (completedHandler) {
                    completedHandler(products, @"登录成功", nil);
                }
            } else {
                if (completedHandler) {
                    completedHandler(nil, @"登录失败", nil);
                }
            }
        } else {
            if (completedHandler) {
                completedHandler(nil, @"请求失败", error);
            }
        }
    }];
}

#pragma mark -- Fetch verifCode

- (void)fetchVerifCodeWithPhoneNum:(NSString *)phoneNum
                  completedHandler:(BusinessCompletedHandler)completedHandler {
    NSDictionary *paramsDict = @{@"Tel" : phoneNum};
    [_networkManager GET:kURL_VerifCode
              parameters:paramsDict 
        completedHandler:^(id responseObject, NSError *error) {
            if (!error) {
                NSInteger msgCode = [(NSNumber *)responseObject[@"msgcode"] integerValue];
                if (msgCode == 1) {
                    if (completedHandler) {
                        completedHandler(responseObject, @"验证码已发送，请查收", nil);
                    }
                } else {
                    if (completedHandler) {
                        completedHandler(nil, @"获取验证码失败", nil);
                    }
                }
            } else {
                if (completedHandler) {
                    completedHandler(nil, @"请求失败", error);
                }
            }
    }];
}

#pragma mark -- Fetch pithy court data

- (void)fetchPithyCourtDataWithCompletedHandler:(BusinessCompletedHandler)completedHandler {
    [_networkManager GET:kURL_PithyCourt
              parameters:nil
        completedHandler:^(id responseObject, NSError *error)
     {
         NSArray *pithyCourtItems = responseObject[@"jingcuiData"];
         
         NSMutableArray *pithyCourts = [NSMutableArray array];
         [pithyCourtItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
             NSArray *productItems = obj[@"jincuiProduct"];
             
             LLSPithyCourt *pithyCourt = [LLSPithyCourt objectWithKeyValues:obj[@"jincui"]];
             
             NSMutableArray *products = [NSMutableArray array];
             [productItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                 LLSProduct *product = [LLSProduct objectWithKeyValues:obj];
                 if (product) {
                     [products addObject:product];
                 }
             }];
             
             pithyCourt.products = products;
             if (pithyCourt) {
                 [pithyCourts addObject:pithyCourt];
             }
         }];
         
         if (completedHandler) {
             completedHandler(pithyCourts, nil, error);
         }
     }];
}

#pragma mark -- Fetch speaking etiquette data

- (void)fetchSpeakingEtiquetteDataWithCompletedHandler:(BusinessCompletedHandler)completedHandler {
    [_networkManager GET:kURL_SpeakEtiquette
              parameters:nil 
        completedHandler:^(id responseObject, NSError *error)
    {
        NSArray *speakEtiqItems = responseObject[@"yanliData"];
        
        NSMutableArray *speakEtiqs = [NSMutableArray array];
        [speakEtiqItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray *productItems = obj[@"yanliProduct"];
            
            LLSSpeakEtiquette *speakEtiq = [LLSSpeakEtiquette objectWithKeyValues:obj[@"yanli"]];
            
            NSMutableArray *products = [NSMutableArray array];
            [productItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                LLSProduct *product = [LLSProduct objectWithKeyValues:obj];
                if (product) {
                    [products addObject:product];
                }
            }];
            
            speakEtiq.products = products;
            if (speakEtiq) {
                [speakEtiqs addObject:speakEtiq];
            }
        }];
        
        if (completedHandler) {
            completedHandler(speakEtiqs, nil, error);
        }
    }];
}

#pragma mark -- Get geimage

- (void)fetchGeImageDataWithURLStr:(NSString *)urlStr completedHandler:(BusinessCompletedHandler)completedHandler {
    [_networkManager GET:urlStr
              parameters:nil 
        completedHandler:^(id responseObject, NSError *error)
    {
        LLSGeImge *geImage = [LLSGeImge objectWithKeyValues:responseObject];
        if (completedHandler) {
            completedHandler(geImage, nil, error);
        }
    }];
}

#pragma mark -- Treasure house detail data

- (void)fetchTreasureHouseDetailDataWithType:(THouseDetailType)type
                            completedHandler:(BusinessCompletedHandler)completedHandler {
    NSString *strURL;
    if (type == THouseDetailType_TC) {
        strURL = kURL_Traditional;
    } else if (type == THouseDetailType_FP) {
        strURL = kURL_ForeignAffairs;
    } else {
        strURL = kURL_Innovation;
    }
    [_networkManager GET:strURL
              parameters:nil 
        completedHandler:^(id responseObject, NSError *error)
    {
        NSArray *traditionalCraftItems = responseObject[@"productList"];
        
        NSMutableArray *products = [NSMutableArray array];
        [traditionalCraftItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            LLSProduct *product = [LLSProduct objectWithKeyValues:obj];
            if (product) {
                [products addObject:product];
            }
        }];
        
        if (completedHandler) {
            completedHandler(products, nil, error);
        }
    }];
}

#pragma mark -- Collect product

- (void)collectProductWithProductId:(NSInteger)productId
                   completedHandler:(BusinessCompletedHandler)completedHandler {
    NSDictionary *paramsDict = @{@"userId": @(_loginAccount.userId),
                                 @"productId": @(productId)};
    [_networkManager GET:kURL_Collect
              parameters:paramsDict
        completedHandler:^(id responseObject, NSError *error)
    {
        if (!error) {
            NSInteger msgCode = [(NSNumber *)responseObject[@"msgcode"] integerValue];
            if (msgCode == 1) {
                if (completedHandler) {
                    completedHandler(responseObject, @"收藏成功", nil);
                }
            } else {
                if (completedHandler) {
                    completedHandler(nil, responseObject[@"msg"], nil);
                }
            }
        } else {
            if (completedHandler) {
                completedHandler(nil, @"请求失败", error);
            }
        }
    }];
}

#pragma mark -- Cancel collect product

- (void)deCollectProductWithProductId:(NSInteger)productId
                     completedHandler:(BusinessCompletedHandler)completedHandler {
    NSDictionary *paramsDict = @{@"userId": @(_loginAccount.userId),
                                 @"productId": @(productId)};
    [_networkManager GET:kURL_CancelCollect
              parameters:paramsDict
        completedHandler:^(id responseObject, NSError *error)
     {
         if (!error) {
             NSInteger msgCode = [(NSNumber *)responseObject[@"msgcode"] integerValue];
             if (msgCode == 1) {
                 if (completedHandler) {
                     completedHandler(responseObject, @"取消成功", nil);
                 }
             } else {
                 if (completedHandler) {
                     completedHandler(nil, responseObject[@"msg"], nil);
                 }
             }
         } else {
             if (completedHandler) {
                 completedHandler(nil, @"请求失败", error);
             }
         }
     }];
}

#pragma mark -- Fetch collectiones

- (void)fetchCollectionesWithCompletedHandler:(BusinessCompletedHandler)completedHandler {
    NSDictionary *paramsDict = @{@"userId": @(_loginAccount.userId),
                                 @"userNick": _loginAccount.userNick,
                                 @"userName": _loginAccount.userName};
    [_networkManager GET:kURL_Login
              parameters:paramsDict
        completedHandler:^(id responseObject, NSError *error)
     {
         if (!error) {
             NSInteger msgCode = [(NSNumber *)responseObject[@"msgcode"] integerValue];
             if (msgCode == 1) {
                 NSArray *productItems = responseObject[@"listshoucang"];
                 NSMutableArray *products = [NSMutableArray array];
                 [productItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                     LLSProduct *product = [LLSProduct objectWithKeyValues:obj];
                     if (product) {
                         [products addObject:product];
                     }
                 }];
                 if (completedHandler) {
                     completedHandler(products, @"获取收藏成功", nil);
                 }
             } else {
                 if (completedHandler) {
                     completedHandler(nil, @"获取收藏失败", nil);
                 }
             }
         } else {
             if (completedHandler) {
                 completedHandler(nil, @"请求失败", error);
             }
         }
     }];
}

#pragma mark -- Logout

- (void)logoutWithCompletedHandler:(BusinessCompletedHandler)completedHandler {
    _loginAccount = nil;
    [LLSAccountDAO saveLoginAccount:nil];
}

@end
