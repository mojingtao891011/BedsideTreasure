//
//  RegisterViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"注册" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.originalHeight = self.registerScrollView.top ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
    [self.view addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark-----clickTapAction
- (void)clickTap:(UITapGestureRecognizer*)tap
{
    for (UIView *subView in self.registerScrollView.subviews) {
        for (UIView *view in subView.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                [view resignFirstResponder];
            }
        }
    }
}
#pragma mark-----NotificationCenter
- (void)keyboardWillShow:(NSNotification*)showNote
{
    if (self.tempTextField.tag != 5) {
        return ;
    }else if (ScreenHeight > 480)
    {
        return ;
    }
    CGRect rect =[[showNote userInfo][@"UIKeyboardFrameEndUserInfoKey"]CGRectValue] ;
    self.keybordNote = showNote ;
    CGFloat  moveHeight = self.phoneNumberView.bottom - ( ScreenHeight - rect.size.height - 44 - 20) ;
    [UIView animateWithDuration:0.5 animations:^{
        self.registerScrollView.top = self.originalHeight ;
        self.registerScrollView.top = self.registerScrollView.top - moveHeight ;
    }];
    
}
- (void)keyboardWillHide:(NSNotification*)hideNote
{
    [UIView animateWithDuration:0.5 animations:^{
        self.registerScrollView.top = self.originalHeight ;
    }];
}

#pragma mark-----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.tempTextField = textField ;
    [self keyboardWillShow:self.keybordNote ];
    return YES ;
}
#pragma mark-----customAction
- (IBAction)checkActin:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
}
@end
