//
//  Activity.h
//  YuePao
//
//  Created by lime on 15/7/23.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic,copy) NSString *actUuid;
@property (nonatomic,copy) NSString *actName;
@property (nonatomic,copy) NSString *pubUuid;
@property (nonatomic,copy) NSString *pubName;
@property (nonatomic,copy) NSString *actTime;
@property (nonatomic,copy) NSString *pubTime;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,copy) NSString *limitCount;
@property (nonatomic,copy) NSString *participateCount;
@property (nonatomic,copy) NSString *tag;
//1:已参加 2:未参加
@property (nonatomic,copy) NSString *participateFlag;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
