//
//  NearActivityTableViewCell.h
//  YuePao
//
//  Created by lime on 15/7/16.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearActivityTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *lblName;
@property (nonatomic,strong) IBOutlet UILabel *lblTime;
@property (nonatomic,strong) IBOutlet UILabel *lblAddress;
@property (nonatomic,strong) IBOutlet UILabel *lblCount;
@property (nonatomic,strong) IBOutlet UILabel *lblDistance;
@property (nonatomic,strong) IBOutlet UILabel *lblTag;
@property (nonatomic,strong) IBOutlet UIButton *btnParticipate;

-(void)setActivityFromDic:(NSDictionary *)activityDic;
@end
