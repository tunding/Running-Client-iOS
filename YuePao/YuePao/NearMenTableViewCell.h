//
//  NearMenTableViewCell.h
//  YuePao
//
//  Created by lime on 15/7/16.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearMenTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *iconView;
@property (nonatomic,strong) IBOutlet UILabel *lblName;
@property (nonatomic,strong) IBOutlet UILabel *lblAge;
@property (nonatomic,strong) IBOutlet UILabel *lblDistance;
@property (nonatomic,strong) IBOutlet UILabel *lblLastTime;
@property (nonatomic,strong) IBOutlet UILabel *lblSignature;
@property (nonatomic,strong) IBOutlet UIButton *btnFollow;

-(void)setPersonFromDic:(NSDictionary *)personDic;
@end
