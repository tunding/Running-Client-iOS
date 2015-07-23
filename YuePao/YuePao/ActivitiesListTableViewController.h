//
//  ActivitiesListTableViewController.h
//  YuePao
//
//  Created by lime on 15/7/20.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ACTIVITIES_LIST_TYPE)
{
    ACTIVITIES_LIST_TYPE_PUBLISH,
    ACTIVITIES_LIST_TYPE_PARTICIPATE
};

@interface ActivitiesListTableViewController : UITableViewController

-(instancetype)initWithListType:(ACTIVITIES_LIST_TYPE)type;
@end
