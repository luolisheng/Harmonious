
//
//  LLSShareSDKManager.m
//  Harmonious
//
//  Created by luolisheng on 15/4/19.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSShareSDKManager.h"

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/WeiBoAPI.h>

#import <QZoneConnection/ISSQZoneApp.h>
#import <SinaWeiboConnection/ISSSinaWeiboApp.h>

@implementation LLSShareSDKManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [ShareSDK registerApp:@"330bf065e354"];
        
        [self initPlatforms];
    }
    return self;
}

#pragma mark -- Create singleton

+ (instancetype)sharedInstance {
    static LLSShareSDKManager *shareSDKManager = nil;
    DISPATCH_ONCE_BLOCK(^{
        shareSDKManager = [[LLSShareSDKManager alloc] init];
    });
    
    return shareSDKManager;
}

#pragma mark -- Init platfroms

- (void)initPlatforms {
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    // 未安装QQ客户端使用网页授权
    id<ISSQZoneApp> QZoneApp = (id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [QZoneApp setIsAllowWebAuthorize:YES];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn" 
                             weiboSDKCls:[WeiboSDK class]];
    
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:nil];
    
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           wechatCls:[WXApi class]];
}

#pragma mark -- Is login

- (BOOL)isLoginedWithShareType:(ShareType)shareType {
    return [ShareSDK hasAuthorizedWithType:shareType];
}

#pragma mark -- Login

- (void)loginWithShareType:(ShareType)shareType completedHandler:(LoginCompletedHandler)completedHandler {
    [ShareSDK getUserInfoWithType:shareType
                      authOptions:nil 
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
    {
        if (result) {
            completedHandler(result, userInfo);
        } else {
            completedHandler(result, nil);
        }
    }];
}

#pragma mark -- Share 

- (void)shareWithContent:(NSString *)content
                   image:(UIImage *)image
                    type:(ShareType)shareType completedHandler:(ShareCompletedHandler)completedHandler {
    // 新闻类型必须要加url参数
    // http%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fid1020572201%23rd
    
    NSData *data = UIImageJPEGRepresentation(image, .5);
    id<ISSCAttachment> shareImage = [ShareSDK imageWithData:data fileName:@"share" mimeType:@"image/jpeg"];
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:shareImage
                                                title:nil
                                                  url:@"http://mp.weixin.qq.com/mp/redirect?url=https://itunes.apple.com/us/app/id1020572201"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    [ShareSDK shareContent:publishContent
                      type:shareType 
               authOptions:nil 
             statusBarTips:YES 
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end)
    {
        if (state == SSResponseStateSuccess) {
            completedHandler(YES);
        } else if (state == SSResponseStateFail) {
            completedHandler(NO);
        }
    }];
}

#pragma mark -- Logout

- (void)logoutWithShareType:(ShareType)shareType {
    [ShareSDK cancelAuthWithType:shareType];
}

@end
