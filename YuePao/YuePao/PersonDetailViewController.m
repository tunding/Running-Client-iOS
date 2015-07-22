//
//  PersonDetailViewController.m
//  YuePao
//
//  Created by lime on 15/7/17.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "Person.h"
#import "RCDChatViewController.h"
#import "prefix-header.h"

@interface PersonDetailViewController ()
{
    Person *person;
}

@end

@implementation PersonDetailViewController

@synthesize lblName;
@synthesize lblAge;
@synthesize lblDistance;
@synthesize lblLastTime;
@synthesize lblSignature;
@synthesize btnFollow;
@synthesize btnSendMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    lblName.text = person.name;
    lblAge.text = person.age;
    lblDistance.text = person.distance;
    lblLastTime.text = person.lastTime;
    lblSignature.text = person.signature;
    self.navigationItem.title = person.name;
    if ([person.followFlag isEqualToString:@"1"]) {
        [btnFollow setTitle:@"已关注" forState:UIControlStateNormal];
        [btnFollow setUserInteractionEnabled:NO];
    }
    else{
        [btnFollow setTitle:@"未关注" forState:UIControlStateNormal];
        [btnFollow setUserInteractionEnabled:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithPersonDic:(NSDictionary*)dic{
    self = [self init];
    person = [[Person alloc] initWithDic:dic];
    
    return self;
}

-(IBAction)btnFollowPressed:(id)sender
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:person.uuid forKey:@"passiveAttentionUuid"];
    [manager POST:kUrlFollowOther parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"code"]];
        if ([result isEqualToString:@"1000"]) {
            
            NSLog(@"follow other success!");
            [btnFollow setTitle:@"已关注" forState:UIControlStateNormal];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"关注成功！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"follow other net error!");
    }];
}
-(IBAction)btnSendMessasgePressed:(id)sender
{
//创建会话
    RCDChatViewController *chatViewController = [[RCDChatViewController alloc] init];
    chatViewController.conversationType = ConversationType_PRIVATE;
    chatViewController.targetId = person.uuid;
    chatViewController.title = person.name;
    chatViewController.userName = person.name;
    [self.navigationController pushViewController:chatViewController animated:YES];
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
