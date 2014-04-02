//
//  LoginViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userName_bg.layer.borderColor = [UIColor colorWithRed:125/255.0 green:214/255.9 blue:208/255.0 alpha:1.0].CGColor;
    self.userName_bg.layer.borderWidth = 1;
    self.password_bg.layer.borderColor = [UIColor colorWithRed:125/255.0 green:214/255.9 blue:208/255.0 alpha:1.0].CGColor;
    self.password_bg.layer.borderWidth = 1;
    
   // self.userImage.layer.cornerRadius = 60;
   // self.userImage.layer.borderColor = [UIColor grayColor].CGColor;
    //self.userImage.layer.borderWidth = 3;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES ;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
- (IBAction)loginAction:(id)sender {
    NSLog(@"loginAction");
}

- (IBAction)RegisterAction:(id)sender {
    NSLog(@"RegisterAction");
    RegisterViewController *registerViewCtl = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewCtl animated:YES];
}
@end
