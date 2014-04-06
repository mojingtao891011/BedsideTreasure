//
//  EmailLookPassWordViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "EmailLookPassWordViewController.h"
#import "ResetPassWordViewController.h"

@interface EmailLookPassWordViewController ()

@end

@implementation EmailLookPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"找回密码" ;
        [self.titleLabel sizeToFit] ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.CancelButton.layer.borderWidth = 1 ;
    self.CancelButton.layer.borderColor = buttonBackgundColor.CGColor ;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
- (IBAction)enterAction:(id)sender {
    ResetPassWordViewController *resetPasswordView = [[ResetPassWordViewController alloc]init];
    [self.navigationController pushViewController:resetPasswordView animated:YES];
}
@end
