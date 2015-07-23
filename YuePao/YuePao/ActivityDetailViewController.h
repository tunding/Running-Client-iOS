//
//  ActivityDetailViewController.h
//  YuePao
//
//  Created by lime on 15/7/23.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *lblActName;
@property (nonatomic, strong) IBOutlet UILabel *lblActTime;
@property (nonatomic, strong) IBOutlet UILabel *lblDistance;
@property (nonatomic, strong) IBOutlet UILabel *lblAddress;
@property (nonatomic, strong) IBOutlet UILabel *lblInfo;
@property (nonatomic, strong) IBOutlet UILabel *lblLimiteCount;
@property (nonatomic, strong) IBOutlet UILabel *lblPubName;
@property (nonatomic, strong) IBOutlet UILabel *lblPubTime;
@property (nonatomic, strong) IBOutlet UILabel *lblParticipateCount;
@property (nonatomic, strong) IBOutlet UIButton *btnParticipate;

- (instancetype)initWithActivityDic:(NSDictionary*)dic;
@end
