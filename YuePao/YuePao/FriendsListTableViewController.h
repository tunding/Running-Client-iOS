//
//  FriendsListTableViewController.h
//  YuePao
//
//  Created by lime on 15/7/20.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FRIEDNS_LIST_TYPE)
{
    FRIEDNS_LIST_TYPE_FOLLOW,
    FRIEDNS_LIST_TYPE_FOLLOWED
};

@interface FriendsListTableViewController : UITableViewController
-(instancetype)initWithListType:(FRIEDNS_LIST_TYPE)type;
@end
