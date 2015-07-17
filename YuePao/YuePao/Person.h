//
//  Person.h
//  YuePao
//
//  Created by lime on 15/7/17.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *uuid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *lastTime;
@property (nonatomic,copy) NSString *signature;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
