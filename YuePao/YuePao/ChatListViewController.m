//
//  ChatListViewController.m
//  YuePao
//
//  Created by lime on 15/5/31.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "ChatListViewController.h"
#import "RCDChatListViewController.h"
@interface ChatListViewController ()

@end

@implementation ChatListViewController

@synthesize rcdChatView;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RCDChatListViewController *rcdController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"RCDChatList"];
//    [self.view addSubview:rcdController.view];
    [self presentViewController:rcdController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    
//    [self rightBarButtonItemPressed:nil];
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

//重载函数，onSelectedTableRow 是选择会话列表之后的事件，该接口开放是为了便于您自定义跳转事件。在快速集成过程中，您只需要复制这段代码。
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.userName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
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
