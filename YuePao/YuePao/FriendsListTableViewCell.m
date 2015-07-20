//
//  FriendsListTableViewCell.m
//  YuePao
//
//  Created by lime on 15/7/20.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "FriendsListTableViewCell.h"

@implementation FriendsListTableViewCell

@synthesize name;
@synthesize lblName;

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
@end
