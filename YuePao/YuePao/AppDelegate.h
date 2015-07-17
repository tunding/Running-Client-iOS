//
//  AppDelegate.h
//  YuePao
//
//  Created by lime on 15/5/31.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCIMUserInfoDataSource>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TabBarViewController *barController;
-(void)httpRequestForDeviceToken;
@end

