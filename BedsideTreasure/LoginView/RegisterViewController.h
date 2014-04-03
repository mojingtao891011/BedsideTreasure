//
//  RegisterViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate >

@property (weak, nonatomic) IBOutlet UIScrollView *registerScrollView;
@property(nonatomic , retain)UITextField *tempTextField ;
@property(nonatomic , retain)NSNotification* keybordNote ;
@property(nonatomic , assign)NSInteger originalHeight ;
@property (weak, nonatomic) IBOutlet UIView *phoneNumberView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

- (IBAction)checkActin:(id)sender;

@end
