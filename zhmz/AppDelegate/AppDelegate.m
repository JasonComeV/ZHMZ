//
//  AppDelegate.m
//  zhmz
//
//  Created by 魏亮 on 2018/3/8.
//  Copyright © 2018年 魏亮. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [RequsetManager getOnlyCodeWithCompletion:^(NSDictionary *returnData) {
        if ([returnData[@"Error"][@"ErrorCode"]intValue]==0) {
            UserMessage * user = USER;
            user.jzResultIp = returnData[@"Result"][0][@"result"];
            user.hdResultIp = returnData[@"Result"][1][@"result"];
            user.yzsResultIp = returnData[@"Result"][2][@"result"];
            [user.arrIp addObjectsFromArray:@[user.jzResultIp,user.hdResultIp,user.yzsResultIp]];
        } else {

        }
    }];
    [self reachabilityStatusChange];
    return YES;
}

- (void)reachabilityStatusChange
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [MBProgressHUD showError:@"没有连接网络" toView:self.window.rootViewController.view];
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    [mgr startMonitoring];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
