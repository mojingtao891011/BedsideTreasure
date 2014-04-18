//
//  ResetPassWordViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface ResetPassWordViewController : BaseViewController<UITextFieldDelegate , UIAlertViewDelegate>

@property(nonatomic , copy)NSString *captcha ;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)resetAction:(id)sender;

@end
