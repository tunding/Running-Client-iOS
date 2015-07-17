//
//  PublishActivityViewController.m
//  YuePao
//
//  Created by lime on 15/6/28.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "PublishActivityViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "prefix-header.h"

@interface PublishActivityViewController ()
{
    NSDate *pickedDate;
    NSString *pickedDateStr;
    CLLocationCoordinate2D coordinate;
    NSString *info;
//    NS
}

@end

@implementation PublishActivityViewController
@synthesize fieAddress;
@synthesize fieTime;
@synthesize txtInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布活动";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.barController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.barController.tabBar.hidden = NO;
}

-(IBAction)btnSubmitPressed:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    pickedDate =[formatter dateFromString:@"2015-7-10 12:12:00"];
    pickedDateStr = [formatter stringFromDate:pickedDate];
    
    coordinate = CLLocationCoordinate2DMake(34.208155,108.862443);
    info = txtInfo.text;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:pickedDateStr forKey:@"time"];
    [params setObject:fieAddress.text forKey:@"address"];
    [params setObject:[NSString stringWithFormat:@"%f",coordinate.latitude] forKey:@"latitude"];
    [params setObject:[NSString stringWithFormat:@"%f",coordinate.longitude] forKey:@"longitude"];
    [params setObject:@"5" forKey:@"kilometer"];
    [params setObject:info forKey:@"info"];
    [manager POST:kUrlPublishActivity parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [responseDic objectForKey:@"result"];
        if ([result isEqualToString:kSuccess]) {
            
            NSLog(@"publish activity success!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发布成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"net error!");
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnCancelPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
