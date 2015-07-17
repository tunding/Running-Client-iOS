//
//  NearActivityTableViewCell.m
//  YuePao
//
//  Created by lime on 15/7/16.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "NearActivityTableViewCell.h"

@implementation NearActivityTableViewCell

@synthesize lblName;
@synthesize lblTime;
@synthesize lblAddress;
@synthesize lblCount;

@synthesize name;
@synthesize time;
@synthesize address;
@synthesize count;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setName:(NSString *)_name
{
    lblName.text = _name;
}
-(void)setTime:(NSString *)_time
{
    lblTime.text = _time;
}
-(void)setAddress:(NSString *)_address
{
    lblAddress.text = _address;
}
-(void)setCount:(NSString *)_count
{
    lblCount.text = _count;
}

@end
