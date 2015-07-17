//
//  NearRunViewController.m
//  YuePao
//
//  Created by lime on 15/6/22.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "NearActivityViewController.h"
#import "PublishActivityViewController.h"
#import "prefix-header.h"
#import <MJRefresh/MJRefresh.h>
#import "NearActivityTableViewCell.h"

@interface NearActivityViewController ()
{
    NSMutableArray *arrNearRun;
}

@end

@implementation NearActivityViewController
@synthesize nearRunTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 下拉刷新
    nearRunTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [nearRunTableView.header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    nearRunTableView.header.autoChangeAlpha = YES;
    
    // 上拉刷新
    nearRunTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [nearRunTableView.footer endRefreshing];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"附近的跑";
    //自定义rightBarButtonItem
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(publishActivity:)];
    [rightButton setTintColor:[UIColor blueColor]];
    self.tabBarController.navigationItem.rightBarButtonItem = rightButton;
    [self getNearRunList];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
-(void)getNearRunList
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"108.862443" forKey:@"longitude"];
    [params setObject:@"34.208155" forKey:@"latitude"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [manager POST:kUrlNearRun parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [responseDic objectForKey:@"result"];
        if ([result isEqualToString:kSuccess]) {
            
            NSLog(@"get nearrun success!");
            arrNearRun = (NSMutableArray*)[responseDic objectForKey:@"data"];
            [nearRunTableView reloadData];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"net error!");
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    if ([arrNearRun respondsToSelector:@selector(count)]) {
        num = arrNearRun.count;
    }
    else
        num = 0;
    return num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearActivityTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"nearActivity"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NearActivityTableViewCell" owner:self options:nil] lastObject];
    }
    NSInteger row = indexPath.row;
    NSString *time = [NSString stringWithFormat:@"%@",[[arrNearRun objectAtIndex:row] objectForKey:@"time"]];
    NSString *address = [NSString stringWithFormat:@"%@",[[arrNearRun objectAtIndex:row] objectForKey:@"address"]];
    NSString *count = [NSString stringWithFormat:@"%@",[[arrNearRun objectAtIndex:row] objectForKey:@"participateCount"]];
    cell.time = time;
    cell.address = address;
    cell.count = count;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)publishActivity:(id)sender
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PublishActivityViewController *activityController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"publishActivity"];
    [self.navigationController pushViewController:activityController animated:YES];
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
