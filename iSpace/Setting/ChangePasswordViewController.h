//
//  ChangePasswordViewController.h
//  iSpace
//
//  Created by 莫景涛 on 14-5-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *againPassword;

- (IBAction)submitChange:(id)sender;
@end
