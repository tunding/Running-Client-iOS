//
//  prefix-header.h
//  YuePao
//
//  Created by lime on 15/6/15.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#ifndef YuePao_prefix_header_h
#define YuePao_prefix_header_h

#include <AFNetworking/AFNetworking.h>

#define kSuccess @"success"
#define kFailed @"failed"

#define kUrlHost @"http://120.25.153.117:8080/running/"
//login
#define kUrlLogin [NSString stringWithFormat:@"%@login",kUrlHost]
//logout
#define kUrlLogout [NSString stringWithFormat:@"%@logout",kUrlHost]
//nearby runner
#define kUrlNearMen [NSString stringWithFormat:@"%@runner/near",kUrlHost]
//nearby activity
#define kUrlNearRun [NSString stringWithFormat:@"%@activity/near",kUrlHost]
//get rongCloud Token
#define kUrlGetRongCloudToken [NSString stringWithFormat:@"%@rongcloud/gettoken",kUrlHost]
//publish activity
#define kUrlPublishActivity [NSString stringWithFormat:@"%@activity/info/saveactivity",kUrlHost]
//get user info
#define kUrlGetUserInfo [NSString stringWithFormat:@"%@runner/near/info",kUrlHost]
//follow somebody
#define kUrlFollowOther [NSString stringWithFormat:@"%@ralationship/friendship/attention",kUrlHost]
//我关注的人
#define kUrlFollowList [NSString stringWithFormat:@"%@ralationship/friendship/listfriend",kUrlHost]
//关注我的人
#define kUrlFollowedList [NSString stringWithFormat:@"%@ralationship/friendship/listfriend",kUrlHost]
//我发布的活动
#define kUrlPublishList [NSString stringWithFormat:@"%@activity/info/public/gethistoryactivity",kUrlHost]
//我参与的活动
#define kUrlParticipateList [NSString stringWithFormat:@"%@activity/info/participate/gethistoryactivity",kUrlHost]
#endif
