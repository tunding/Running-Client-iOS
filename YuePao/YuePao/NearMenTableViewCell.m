//
//  NearMenTableViewCell.m
//  YuePao
//
//  Created by lime on 15/7/16.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "NearMenTableViewCell.h"

@implementation NearMenTableViewCell
@synthesize iconView;
@synthesize lblName;
@synthesize lblAge;
@synthesize lblDistance;
@synthesize lblLastTime;
@synthesize lblSignature;

@synthesize iconURI;
@synthesize name;
@synthesize age;
@synthesize distance;
@synthesize lastTime;
@synthesize signature;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIconURI:(NSString *)iconURI
{
    
}
-(void)setName:(NSString *)_name
{
    lblName.text = _name;
}
-(void)setAge:(NSString *)_age
{
    lblAge.text = _age;
}
-(void)setDistance:(NSString *)_distance
{
    lblDistance.text = _distance;
}
-(void)setLastTime:(NSString *)_lastTime
{
    lblLastTime.text = _lastTime;
}
-(void)setSignature:(NSString *)_signature
{
    lblSignature.text = _signature;
}
@end
