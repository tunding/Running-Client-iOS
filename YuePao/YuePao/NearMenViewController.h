//
//  NearMenViewController.h
//  YuePao
//
//  Created by lime on 15/6/15.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearMenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *nearMenTableView;
@end
