//
//  AppDelegate.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/14.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"



// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define appkey @"f3655879f18d4f1465214ca4"
#define channell @""
#define isProduction 1

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

static AppDelegate *_appDelegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:channell
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            [self method];
        }
        else{
        }
    }];
    
    
    return YES;
}

+ (AppDelegate *)appDelegate {
    return _appDelegate;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)method{
//    NSString*tag=[[NSUserDefaults standardUserDefaults] objectForKey:@"mendian"];
//    NSSet *tags=[NSSet setWithObjects:tag, nil];
    
    NSString*alias=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"studentId"]];
    
    [JPUSHService setTags:nil alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
    }];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

@end
