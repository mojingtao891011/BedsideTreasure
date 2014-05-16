//
//  VerifiedViewController.h
//  iSpace
//
//  Created by 莫景涛 on 14-5-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface VerifiedViewController : BaseViewController

@property(nonatomic , copy)NSString *phoneNumber ;
@property (weak, nonatomic) IBOutlet UITextField *captcha;
- (IBAction)submitCaptcha:(UIButton *)sender;



@end
