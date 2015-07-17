//
//  NearRunViewController.h
//  YuePao
//
//  Created by lime on 15/6/22.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearActivityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *nearRunTableView;
@end
