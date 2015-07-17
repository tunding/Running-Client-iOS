//
//  ViewController.m
//  YuePao
//
//  Created by lime on 15/5/31.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "ViewController.h"
#import "ChatListViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "prefix-header.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSString *username;
    NSString *password;
}

@end

@implementation ViewController

@synthesize txtUsername;
@synthesize txtPassword;
@synthesize btnLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
//    [self.navigationController pushViewController:chatListViewController animated:YES];
//    [self rightBarButtonItemPressed:nil];
}

-(IBAction)btnLoginPressed:(id)sender
{

    txtUsername.text = @"wangzhichao";
    txtPassword.text = @"wangzhichao";
    username = txtUsername.text;
    password = txtPassword.text;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [manager POST:kUrlLogin parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [responseDic objectForKey:@"result"];
        if ([result isEqualToString:kSuccess]) {
            //login success
            NSLog(@"login success!");
            
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *navi = [mainStoryBoard instantiateViewControllerWithIdentifier:@"navi"];
            
            AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//            delegate.barController = barController;
            [[[UIApplication sharedApplication] keyWindow] setRootViewController:navi];
//            barController.selectedIndex = 0;
            [delegate httpRequestForDeviceToken];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"net error!");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
