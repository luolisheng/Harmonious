//
//  AppDelegate.m
//  Harmonious
//
//  Created by luolisheng on 15/4/4.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "AppDelegate.h"
#import "LLSMainViewController.h"

#import "LLSTipsView.h"

#import <HexColors/HexColor.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <ShareSDK/ShareSDK.h>
#import <GCDWebServer/GCDWebUploader.h>

static NSString *const kFirstLaunch = @"kFirstLaunch";

@interface AppDelegate ()

@property (nonatomic, strong) GCDWebUploader *webUploader;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"CCCCCC"]];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    /*
    NSString *documentsPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    [_webUploader start];*/
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window setBackgroundColor:[UIColor whiteColor]];
    
    [_window setRootViewController:[[LLSMainViewController alloc] init]];
    
    [_window makeKeyAndVisible];
    
    NSNumber *firstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstLaunch];
    if (!firstLaunch) {
        LLSTipsView *tipsView = [[LLSTipsView alloc] initWithFrame:_window.bounds];
        [_window addSubview:tipsView];
        
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:kFirstLaunch];
    }
    
    sleep(2);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url wxDelegate:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
}

@end
