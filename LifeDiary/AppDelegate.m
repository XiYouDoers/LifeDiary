//
//  AppDelegate.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotifications/UNNotificationSound.h>
#import <UserNotifications/UNNotificationTrigger.h>
#import <UserNotifications/UNNotificationRequest.h>


@interface AppDelegate (){
    NSUInteger notificationSum;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    UNUserNotificationCenter *center = [UNUserNotificationCenter  currentNotificationCenter];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取用户是否同意开启通知
            NSLog(@"request authorization successed!");
        }
    }];
    
    //第二步：新建通知内容对象
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"物品过期通知";
    content.subtitle = @"您有新的物品即将到期";
    content.body = @"您添加的旺仔牛奶距离到期还有3个月，赶快使用吧";
    notificationSum++;
    NSNumber *number = [NSNumber numberWithInteger:notificationSum];
    content.badge = number;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"wakeup.caf"];
    content.sound = sound;
    
    //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3600  repeats:YES];
    
    //第四步：创建UNNotificationRequest通知请求对象
//    NSString *requertIdentifier = @"RequestIdentifier";
//    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
    
    //第五步：将通知加到通知中心
//    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//        NSLog(@"Error:%@",error);
//        
//    }];
    
    
    
    
    
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    return YES;
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
