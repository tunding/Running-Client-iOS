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
