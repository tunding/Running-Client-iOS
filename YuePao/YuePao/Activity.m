//
//  Activity.m
//  YuePao
//
//  Created by lime on 15/7/23.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "Activity.h"

@implementation Activity
@synthesize actUuid;
@synthesize actName;
@synthesize pubUuid;
@synthesize pubName;
@synthesize actTime;
@synthesize pubTime;
@synthesize address;
@synthesize distance;
@synthesize longitude;
@synthesize latitude;
@synthesize info;
@synthesize limitCount;
@synthesize participateCount;
@synthesize participateFlag;
@synthesize tag;

-(instancetype)initWithDic:(NSDictionary*)dic
{
    self = [self init];
    actUuid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"actuuid"]];
    actName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"actname"]];
    actTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"acttime"]];
    pubUuid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pubuuid"]];
    pubName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pubname"]];
    pubTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pubtime"]];
    address = [NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
    distance = [NSString stringWithFormat:@"%@",[dic objectForKey:@"distance"]];
    if ([distance rangeOfString:@"."].length >0) {
        distance = [NSString stringWithFormat:@"%@m", [distance substringToIndex:[distance rangeOfString:@"."].location]];
    }
    longitude = [NSString stringWithFormat:@"%@",[dic objectForKey:@"longitude"]];
    latitude = [NSString stringWithFormat:@"%@",[dic objectForKey:@"latitude"]];
    info = [NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
    limitCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"limitCount"]];
    participateCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"participateCount"]];
    participateFlag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"participateFlag"]];
    tag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"tag"]];
    return self;
}
@end
