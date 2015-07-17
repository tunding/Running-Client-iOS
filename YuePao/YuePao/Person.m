//
//  Person.m
//  YuePao
//
//  Created by lime on 15/7/17.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize uuid;
@synthesize name;
@synthesize age;
@synthesize distance;
@synthesize lastTime;
@synthesize signature;

-(instancetype)initWithDic:(NSDictionary*)dic
{
    self = [self init];
    uuid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uuid"]];
    name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    age =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"age"]];
    distance = [NSString stringWithFormat:@"%@",[dic objectForKey:@"distance"]];
    distance = [NSString stringWithFormat:@"%@m", [distance substringToIndex:[distance rangeOfString:@"."].location]];
    lastTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lastTime"]];
    signature = [NSString stringWithFormat:@"%@",[dic objectForKey:@"signature"]];
    return self;
}
@end
