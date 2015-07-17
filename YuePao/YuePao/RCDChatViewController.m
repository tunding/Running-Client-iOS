//
//  RCDChatViewController.m
//  RCloudMessage
//
//  Created by Liv on 15/3/13.
//  Copyright (c) 2015年 胡利武. All rights reserved.
//

#import "RCDChatViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDChatViewController.h"
#import "RCDDiscussGroupSettingViewController.h"
#import "RCDRoomSettingViewController.h"
#import "RCDPrivateSettingViewController.h"

@interface RCDChatViewController ()

@end

@implementation RCDChatViewController

-(void)viewDidAppear:(BOOL)animated
{
    
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
  [super viewDidLoad];

  NSString *__string = @"返回";

  int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
    @(ConversationType_PRIVATE),
    @(ConversationType_DISCUSSION),
    @(ConversationType_APPSERVICE),
    @(ConversationType_PUBLICSERVICE),
    @(ConversationType_GROUP),
    @(ConversationType_SYSTEM)
  ]];
  if (0 < unreadMsgCount) {
    __string = [NSString stringWithFormat:@"返回(%d)", unreadMsgCount];
  }

  //添加rightBarButtonItem事件
  //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
  //    initWithTitle:@"设置"
  //                                                                              style:UIBarButtonItemStylePlain
  //                                                                             target:self
  //                                                                             action:@selector(rightBarButtonItemClicked:)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[UIImage imageNamed:@"Setting"]
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(rightBarButtonItemClicked:)];
  //添加leftBarButtonItem点击事件
//  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
//      initWithTitle:__string
//              style:UIBarButtonItemStylePlain
//             target:self
//             action:@selector(leftBarButtonItemPressed:)];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 6, 42, 23);
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
    backImg.frame = CGRectMake(-10, 0, 22, 22);
    [backBtn addSubview:backImg];
    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 40, 22)];
    backText.text = NSLocalizedStringFromTable(@"Back", @"RongCloudKit", nil);
    backText.font = [UIFont systemFontOfSize:15];
    [backText setBackgroundColor:[UIColor clearColor]];
    [backText setTextColor:[UIColor blueColor]];
    [backBtn addSubview:backText];
    [backBtn addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
  //删除不需要的plugin item
  //[self.pluginBoardView removeItemAtIndex:0];
}

- (void)leftBarButtonItemPressed:(id)sender {
  //需要调用super的实现
  [super leftBarButtonItemPressed:sender];

  [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  此处使用自定义设置，开发者可以根据需求自己实现
 *  不添加rightBarButtonItemClicked事件，则使用默认实现。
 */
- (void)rightBarButtonItemClicked:(id)sender {
  if (self.conversationType == ConversationType_PRIVATE) {

    RCDPrivateSettingViewController *settingVC =
        [[RCDPrivateSettingViewController alloc] init];
    settingVC.conversationType = self.conversationType;
    settingVC.targetId = self.targetId;
    settingVC.conversationTitle = self.title;
    //设置讨论组标题时，改变当前聊天界面的标题
    settingVC.setDiscussTitleCompletion = ^(NSString *discussTitle) {
      self.title = discussTitle;
    };
    //清除聊天记录之后reload data
    __weak RCDChatViewController *weakSelf = self;
    settingVC.clearHistoryCompletion = ^(BOOL isSuccess) {
      if (isSuccess) {
        [weakSelf.conversationDataRepository removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
          [weakSelf.conversationMessageCollectionView reloadData];
        });
      }
    };

    [self.navigationController pushViewController:settingVC animated:YES];

  } else if (self.conversationType == ConversationType_DISCUSSION) {

    RCDDiscussGroupSettingViewController *settingVC =
        [[RCDDiscussGroupSettingViewController alloc] init];
    settingVC.conversationType = self.conversationType;
    settingVC.targetId = self.targetId;
    settingVC.conversationTitle = self.title;
    //设置讨论组标题时，改变当前聊天界面的标题
    settingVC.setDiscussTitleCompletion = ^(NSString *discussTitle) {
      self.title = discussTitle;
    };
    //清除聊天记录之后reload data
    __weak RCDChatViewController *weakSelf = self;
    settingVC.clearHistoryCompletion = ^(BOOL isSuccess) {
      if (isSuccess) {
        [weakSelf.conversationDataRepository removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
          [weakSelf.conversationMessageCollectionView reloadData];
        });
      }
    };

    [self.navigationController pushViewController:settingVC animated:YES];
  }

  //聊天室设置
  else if (self.conversationType == ConversationType_CHATROOM) {
    RCDRoomSettingViewController *settingVC =
        [[RCDRoomSettingViewController alloc] init];
    settingVC.conversationType = self.conversationType;
    settingVC.targetId = self.targetId;
    [self.navigationController pushViewController:settingVC animated:YES];
  }

  //群组设置
  else if (self.conversationType == ConversationType_GROUP) {
    RCSettingViewController *settingVC = [[RCSettingViewController alloc] init];
    settingVC.conversationType = self.conversationType;
    settingVC.targetId = self.targetId;
    //清除聊天记录之后reload data
    __weak RCDChatViewController *weakSelf = self;
    settingVC.clearHistoryCompletion = ^(BOOL isSuccess) {
      if (isSuccess) {
        [weakSelf.conversationDataRepository removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
          [weakSelf.conversationMessageCollectionView reloadData];
        });
      }
    };
    [self.navigationController pushViewController:settingVC animated:YES];
  }
  //客服设置
  else if (self.conversationType == ConversationType_CUSTOMERSERVICE) {
    RCSettingViewController *settingVC = [[RCSettingViewController alloc] init];
    settingVC.conversationType = self.conversationType;
    settingVC.targetId = self.targetId;
    //清除聊天记录之后reload data
    __weak RCDChatViewController *weakSelf = self;
    settingVC.clearHistoryCompletion = ^(BOOL isSuccess) {
      if (isSuccess) {
        [weakSelf.conversationDataRepository removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
          [weakSelf.conversationMessageCollectionView reloadData];
        });
      }
    };
    [self.navigationController pushViewController:settingVC animated:YES];
  }
}

/**
 *  打开大图。开发者可以重写，自己下载并且展示图片。默认使用内置controller
 *
 *  @param imageMessageContent 图片消息内容
 */
- (void)presentImagePreviewController:(RCMessageModel *)model;
{
  RCImagePreviewController *_imagePreviewVC =
      [[RCImagePreviewController alloc] init];
  _imagePreviewVC.messageModel = model;
  _imagePreviewVC.title = @"图片预览";

  UINavigationController *nav = [[UINavigationController alloc]
      initWithRootViewController:_imagePreviewVC];

  [self presentViewController:nav animated:YES completion:nil];
}

- (void)didLongTouchMessageCell:(RCMessageModel *)model {
}

/**
 *  更新左上角未读消息数
 */
- (void)notifyUpdateUnReadMessageCount {
  __weak typeof(&*self) __weakself = self;
  int count = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
    @(ConversationType_PRIVATE),
    @(ConversationType_DISCUSSION),
    @(ConversationType_APPSERVICE),
    @(ConversationType_PUBLICSERVICE),
    @(ConversationType_GROUP)
  ]];
  dispatch_async(dispatch_get_main_queue(), ^{
    if (count > 0) {
      [__weakself.navigationItem.leftBarButtonItem
          setTitle:[NSString stringWithFormat:@"返回(%d)", count]];
    } else {
      [__weakself.navigationItem.leftBarButtonItem setTitle:@"返回"];
    }
  });
}

@end
