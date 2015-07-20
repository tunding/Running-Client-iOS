//
//  ActivitiesListTableViewCell.h
//  YuePao
//
//  Created by lime on 15/7/20.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitiesListTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) IBOutlet UILabel *lblName;
@end
