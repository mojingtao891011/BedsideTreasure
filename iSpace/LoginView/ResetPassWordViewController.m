//
//  ResetPassWordViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ResetPassWordViewController.h"

@interface ResetPassWordViewController ()

@end

@implementation ResetPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"重设密码" ;
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
    
}
#pragma mark -----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
@end
