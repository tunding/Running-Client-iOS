//
//  ActivityDetailViewController.m
//  YuePao
//
//  Created by lime on 15/7/23.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "Activity.h"

@interface ActivityDetailViewController ()
{
    Activity *activity;
}
@end

@implementation ActivityDetailViewController
@synthesize lblActName;
@synthesize lblActTime;
@synthesize lblDistance;
@synthesize lblAddress;
@synthesize lblInfo;
@synthesize lblLimiteCount;
@synthesize lblPubName;
@synthesize lblPubTime;
@synthesize lblParticipateCount;
@synthesize btnParticipate;

- (void)viewDidLoad {
    [super viewDidLoad];
    lblActName.text = activity.actName;
    lblActTime.text = activity.actTime;
    lblDistance.text = activity.distance;
    lblAddress.text = activity.address;
    lblInfo.text = activity.info;
    lblLimiteCount.text = activity.limitCount;
    lblPubName.text = activity.pubName;
    lblPubTime.text = activity.pubTime;
    lblParticipateCount.text = activity.participateCount;
    self.navigationItem.title = activity.actName;
    if ([activity.participateFlag isEqualToString:@"1"]) {
        [btnParticipate setTitle:@"已报名" forState:UIControlStateNormal];
        [btnParticipate setUserInteractionEnabled:NO];
    }
    else{
        [btnParticipate setTitle:@"报名参加" forState:UIControlStateNormal];
        [btnParticipate setUserInteractionEnabled:YES];
    }
}
- (instancetype)initWithActivityDic:(NSDictionary*)dic{
    self = [self init];
    activity = [[Activity alloc] initWithDic:dic];
    
    return self;
}
-(IBAction)btnParticipatePressed:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
