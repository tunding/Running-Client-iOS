//
//  NearMenViewController.m
//  YuePao
//
//  Created by lime on 15/6/15.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "NearMenViewController.h"
#import "prefix-header.h"
#import "ChatListViewController.h"
#import "RCDChatViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "NearMenTableViewCell.h"
#import "PersonDetailViewController.h"

@interface NearMenViewController ()
{
    NSMutableArray *arrNearMen;
}
@end

@implementation NearMenViewController
@synthesize nearMenTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrNearMen = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 下拉刷新
    nearMenTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [nearMenTableView.header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    nearMenTableView.header.autoChangeAlpha = YES;
    
    // 上拉刷新
    nearMenTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [nearMenTableView.footer endRefreshing];
        });
    }];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.navigationItem.title = @"附近的人";
    [self getNearMenList];
}
-(void)getNearMenList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [manager POST:kUrlNearMen parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [responseDic objectForKey:@"result"];
        if ([result isEqualToString:kSuccess]) {

            NSLog(@"get nearmen success!");
            [arrNearMen setArray:[responseDic objectForKey:@"data"]];
            [nearMenTableView reloadData];
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
    return arrNearMen.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearMenTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"nearmen"];
    if (!cell) {
          cell = [[[NSBundle mainBundle] loadNibNamed:@"NearMenTableViewCell" owner:self options:nil] lastObject];
    }
    NSInteger row = indexPath.row;
    [cell setPersonFromDic:[arrNearMen objectAtIndex:row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    PersonDetailViewController *personDetail = [[PersonDetailViewController alloc] initWithPersonDic:[arrNearMen objectAtIndex:row]];
    [self.navigationController pushViewController:personDetail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)rightBarButtonItemPressed:(id)sender
{
    // 您需要根据自己的 App 选择场景触发聊天。这里的例子是一个 Button 点击事件。
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE; //会话类型，这里设置为 PRIVATE 即发起单聊会话。
    conversationVC.targetId = @"0000000001"; // 接收者的 targetId，这里为举例。
    conversationVC.userName = @"name_xxx"; // 接受者的 username，这里为举例。
    conversationVC.title = @"name_xxx"; // 会话的 title。
    
    // 把单聊视图控制器添加到导航栈。
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
