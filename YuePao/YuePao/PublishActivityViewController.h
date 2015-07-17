//
//  PublishActivityViewController.h
//  YuePao
//
//  Created by lime on 15/6/28.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishActivityViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *fieAddress;
@property (strong, nonatomic) IBOutlet UITextField *fieTime;
@property (strong, nonatomic) IBOutlet UITextView *txtInfo;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnSubmit;

@end
