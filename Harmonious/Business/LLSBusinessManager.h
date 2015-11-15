//
//  LLSManager.h
//  Harmonious
//
//  Created by luolisheng on 15/4/12.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLSAccount.h"
#import "LLSPithyCourt.h"
#import "LLSSpeakEtiquette.h"
#import "LLSGeImge.h"

typedef NS_ENUM(NSInteger, THouseDetailType) {
    THouseDetailType_TC = 0,
    THouseDetailType_FP,
    THouseDetailType_CI
};

typedef void(^BusinessCompletedHandler)(id responseObject, NSString *message, NSError *error);

@interface LLSBusinessManager : NSObject

/**
 *  Create singleton
 *
 *  @return
 */
+ (instancetype)sharedInstance;

/**
 *  获取登录的用户
 *
 *  @return
 */
- (LLSAccount *)loginAccount;

/**
 *  登录
 *
 *  @param userId
 *  @param nickName
 *  @param completedHandler
 */
- (void)loginWithUserId:(NSString *)userId
               nickName:(NSString *)nickName
       completedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  获取验证码
 *
 *  @param phoneNum
 *  @param completedHandler
 */
- (void)fetchVerifCodeWithPhoneNum:(NSString *)phoneNum
                  completedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  注销
 */
- (void)logoutWithCompletedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  获取精萃苑数据
 *
 *  @param completedHandler
 */
- (void)fetchPithyCourtDataWithCompletedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  获取言礼堂数据
 *
 *  @param completedHandler
 */
- (void)fetchSpeakingEtiquetteDataWithCompletedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  获取插图
 *
 *  @param completedHandler 
 */
- (void)fetchGeImageDataWithURLStr:(NSString *)urlStr
                  completedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  获取藏宝阁详情数据
 *
 *  @param type             藏宝阁类型
 *  @param completedHandler
 */
- (void)fetchTreasureHouseDetailDataWithType:(THouseDetailType)type
                            completedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  收藏产品
 *
 *  @param productId
 *  @param completedHandler
 */
- (void)collectProductWithProductId:(NSInteger)productId
                   completedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  取消收藏产品
 *
 *  @param productId
 *  @param completedHandler
 */
- (void)deCollectProductWithProductId:(NSInteger)productId
                     completedHandler:(BusinessCompletedHandler)completedHandler;

/**
 *  获取收藏列表
 *
 *  @param completedHadler
 */
- (void)fetchCollectionesWithCompletedHandler:(BusinessCompletedHandler)completedHandler;

@end
