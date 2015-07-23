//
//  NearActivityTableViewCell.m
//  YuePao
//
//  Created by lime on 15/7/16.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "NearActivityTableViewCell.h"
#import "prefix-header.h"
#import "Activity.h"

@implementation NearActivityTableViewCell
{
    Activity *activity;
}

@synthesize lblName;
@synthesize lblTime;
@synthesize lblAddress;
@synthesize lblCount;
@synthesize lblDistance;
@synthesize lblTag;
@synthesize btnParticipate;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setActivityFromDic:(NSDictionary *)activityDic
{
    activity = [[Activity alloc] initWithDic:activityDic];
    lblName.text = activity.actName;
    lblTime.text = activity.actTime;
    lblDistance.text = activity.distance;
    lblAddress.text = activity.address;
    lblCount.text = activity.participateCount;
    lblTag.text = activity.tag;
    if ([activity.participateFlag isEqualToString:@"1"]) {
        [btnParticipate setTitle:@"已参加" forState:UIControlStateNormal];
        [btnParticipate setUserInteractionEnabled:NO];
    }
    else{
        [btnParticipate setTitle:@"参加" forState:UIControlStateNormal];
        [btnParticipate setUserInteractionEnabled:YES];
    }
}
-(IBAction)btnParticipatePressed:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:activity.actUuid forKey:@"actuuid"];
    [manager POST:kUrlParticipateAct parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"code"]];
        if ([result isEqualToString:@"1000"]) {
            
            NSLog(@"participate success!");
            [btnParticipate setTitle:@"已参加" forState:UIControlStateNormal];
            [btnParticipate setUserInteractionEnabled:NO];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"参加成功！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"follow other net error!");
    }];
}
@end
