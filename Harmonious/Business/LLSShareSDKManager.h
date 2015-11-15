//
//  LLSShareSDKManager.h
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

typedef void(^LoginCompletedHandler)(BOOL result, id<ISSPlatformUser> userInfo);
typedef void(^ShareCompletedHandler)(BOOL result);

@interface LLSShareSDKManager : NSObject

/**
 *  创建单例
 *
 *  @return
 */
+ (instancetype)sharedInstance;

/**
 *  是否登录
 *
 *  @param shareType
 *
 *  @return 
 */
- (BOOL)isLoginedWithShareType:(ShareType)shareType;

/**
 *  登录
 *
 *  @param shareType        shareType
 *  @param completedHandler 
 */
- (void)loginWithShareType:(ShareType)shareType completedHandler:(LoginCompletedHandler)completedHandler;

/**
 *  分享
 *
 *  @param content          分享内容
 *  @param shareType        分享平台类型
 *  @param completedHandler 
 */
- (void)shareWithContent:(NSString *)content
                   image:(UIImage *)image
                    type:(ShareType)shareType
        completedHandler:(ShareCompletedHandler)completedHandler;

/**
 *  注销登录
 *
 *  @param shareType 
 */
- (void)logoutWithShareType:(ShareType)shareType;

@end
