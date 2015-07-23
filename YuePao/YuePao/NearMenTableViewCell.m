//
//  NearMenTableViewCell.m
//  YuePao
//
//  Created by lime on 15/7/16.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "NearMenTableViewCell.h"
#import "prefix-header.h"
#import "Person.h"

@implementation NearMenTableViewCell
{
    Person *person;
}
@synthesize iconView;
@synthesize lblName;
@synthesize lblAge;
@synthesize lblDistance;
@synthesize lblLastTime;
@synthesize lblSignature;
@synthesize btnFollow;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPersonFromDic:(NSDictionary *)personDic
{
    
    person = [[Person alloc] initWithDic:personDic];
    lblName.text = person.name;
    lblAge.text = person.age;
    lblDistance.text = person.distance;
    lblLastTime.text = person.lastTime;
    lblSignature.text = person.signature;
    //add icon uri
    if ([person.followFlag isEqualToString:@"1"]) {
        [btnFollow setTitle:@"已关注" forState:UIControlStateNormal];
        [btnFollow setUserInteractionEnabled:NO];
    }
    else{
        [btnFollow setTitle:@"未关注" forState:UIControlStateNormal];
        [btnFollow setUserInteractionEnabled:YES];
    }
}

-(IBAction)btnFollowPressed:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:person.uuid forKey:@"passiveAttentionUuid"];
    [manager POST:kUrlFollowOther parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"code"]];
        if ([result isEqualToString:@"1000"]) {
            
            NSLog(@"follow other success!");
            [btnFollow setTitle:@"已关注" forState:UIControlStateNormal];
            [btnFollow setUserInteractionEnabled:NO];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"关注成功！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
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
