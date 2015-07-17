//
//  AppDelegate.m
//  YuePao
//
//  Created by lime on 15/5/31.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import "prefix-header.h"

#define kAppKey @"mgb7ka1nb5oag"
#define kDeviceToken @"ANZFOLgJoX9BbLoXrCRzkVBoaNSJDQL6wOwwBKP4E4yZQzisgN/bfMm5txP5GnnrOj/bBmxtugiJm7jQg+v0fwvwgV1QS36e"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    //rongcloud token
    NSString *rongCloudToken;
    //apple token
    NSString *pushToken;
    NSMutableDictionary *dicUserInfo;
}

@synthesize barController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RCIM sharedRCIM] initWithAppKey:kAppKey];
    [self registerPush];
    //设置信息提供者
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    return YES;
}
-(void)syncUserInfo
{
    
}
// 获取用户信息的方法。
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    // 此处最终代码逻辑实现需要您从本地缓存或服务器端获取用户信息。
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    dicUserInfo = [defaults valueForKey:@"arrUserInfo"];
    if (!dicUserInfo) {
        dicUserInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    if ([dicUserInfo objectForKey:userId]) {
        RCUserInfo *user = [dicUserInfo objectForKey:userId];
        return completion(user);
    }
    else {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = userId;
        user.name = @"韩梅梅";
        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
        return completion(user);
        
    }
//    if ([@"1" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"1";
//        user.name = @"韩梅梅";
//        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
//        
//        return completion(user);
//    }
    return completion(nil);
}

-(void)registerPush
{
#ifdef __IPHONE_8_0
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|
                                                                                         UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#endif
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString:@" " withString:@""];
    pushToken = [NSString stringWithString:token];
    [[NSUserDefaults standardUserDefaults] setObject:pushToken forKey:@"rongCloudToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[RCIMClient sharedRCIMClient] setDeviceToken:pushToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@", error.description);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"%@",userInfo);
}
-(void)httpRequestForDeviceToken
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"0000000003" forKey:@"userId"];
    [manager POST:kUrlGetRongCloudToken parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSLog(@"%@",responseDic);
        NSNumber *result = [responseDic objectForKey:@"code"];
        if (result.integerValue ==200) {
            
            NSLog(@"get nearmen success!");
            rongCloudToken = [NSString stringWithString:[responseDic objectForKey:@"token"]];
            NSLog(@"rongCloudToken:%@",rongCloudToken);
            NSLog(@"userId:%@",[responseDic objectForKey:@"userId"]);
            [[RCIM sharedRCIM] connectWithToken:rongCloudToken success:^(NSString *userId) {
                NSLog(@"connect server success!");
            } error:^(RCConnectErrorCode status) {
                NSLog(@"connect server fail");
            } tokenIncorrect:^{
                NSLog(@"tokenIncorrect");
            }];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"connect server net error!");
    }];

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

@end
