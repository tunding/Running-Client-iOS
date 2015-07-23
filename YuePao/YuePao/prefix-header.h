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

//登录
#define kUrlLogin [NSString stringWithFormat:@"%@login",kUrlHost]
//退出登录
#define kUrlLogout [NSString stringWithFormat:@"%@logout",kUrlHost]
//获取融云token
#define kUrlGetRongCloudToken [NSString stringWithFormat:@"%@rongcloud/gettoken",kUrlHost]

/****************************************关于人*****************************************/
//附近的人
#define kUrlNearMen [NSString stringWithFormat:@"%@runner/near",kUrlHost]
//获取某人信息
#define kUrlGetUserInfo [NSString stringWithFormat:@"%@runner/near/info",kUrlHost]
//关注某人
#define kUrlFollowOther [NSString stringWithFormat:@"%@ralationship/friendship/attention",kUrlHost]
//取消关注某人
#define kUrlFollowCancel [NSString stringWithFormat:@"%@ralationship/friendship/attentionremove",kUrlHost]
//我关注的人
#define kUrlFollowList [NSString stringWithFormat:@"%@ralationship/friendship/iattention",kUrlHost]
//关注我的人
#define kUrlFollowedList [NSString stringWithFormat:@"%@ralationship/friendship/attentionme",kUrlHost]


/****************************************关于活动*****************************************/
//附近的活动
#define kUrlNearRun [NSString stringWithFormat:@"%@activity/near",kUrlHost]
//参加活动
#define kUrlParticipateAct [NSString stringWithFormat:@"%@activity/near/participate",kUrlHost]
//取消参加活动
#define kUrlParticipateCancel [NSString stringWithFormat:@"%@activity/near/participateremove",kUrlHost]
//发布活动
#define kUrlPublishActivity [NSString stringWithFormat:@"%@activity/info/saveactivity",kUrlHost]
//我发布的活动
#define kUrlPublishList [NSString stringWithFormat:@"%@activity/info/public/gethistoryactivity",kUrlHost]
//我参与的活动
#define kUrlParticipateList [NSString stringWithFormat:@"%@activity/info/participate/gethistoryactivity",kUrlHost]


#endif
