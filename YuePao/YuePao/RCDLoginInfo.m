//
//  LoginInfo.m
//  RongCloud
//
//  Created by Liv on 14/11/10.
//  Copyright (c) 2014年 胡利武. All rights reserved.
//

#import "RCDLoginInfo.h"

@implementation RCDLoginInfo

+(id)shareLoginInfo
{
    static RCDLoginInfo *loginInfo = nil;
    static dispatch_once_t  predicate;
    dispatch_once(&predicate,^{
        loginInfo = [[self alloc] init];
    });

    return loginInfo;
}


@end
