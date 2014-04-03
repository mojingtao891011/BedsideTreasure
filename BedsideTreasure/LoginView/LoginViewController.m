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
    [self drawUserImageView];
    
    self.originalHeight = self.bodyView.top ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
    [self.view addGestureRecognizer:tap];
    
}
- (void)drawUserImageView
{
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake( 0.f, 0.f, 156.f, 156.f);
    imageView.left = (self.bodyView.width - imageView.width) / 2.0 ;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 78;
    [self.bodyView addSubview:imageView];
    imageView.backgroundColor = [UIColor colorWithRed:124/255.0 green:214/255.0 blue:208/255.0 alpha:1.0];
    
    UIImageView * imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(20.f, 20.f, 150.f, 150.f);
    [imageView1 setCenter:CGPointMake(imageView.bounds.size.width / 2 , imageView.bounds.size.height / 2 )];
    imageView1.layer.masksToBounds = YES;
    imageView1.layer.cornerRadius = 75;
    [imageView addSubview:imageView1];
    imageView1.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(20.f, 20.f, 140.f, 140.f);
    [imageView2 setCenter:CGPointMake(imageView.bounds.size.width / 2 , imageView.bounds.size.height / 2 )];
    imageView2.layer.masksToBounds = YES;
    imageView2.layer.cornerRadius = 70;
    [imageView addSubview:imageView2];
    imageView2.image = [UIImage imageNamed:@"ic_test_head"];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES ;
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
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}
#pragma mark-----NotificationCenter
- (void)keyboardWillShow:(NSNotification*)showNote
{
    if (ScreenHeight > 480) {
        return ;
    }
    CGRect rect =[[showNote userInfo][@"UIKeyboardFrameEndUserInfoKey"]CGRectValue] ;
    CGFloat  moveHeight ;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
         moveHeight = self.password_bg.bottom - ( ScreenHeight - rect.size.height  - 44) ;
    }else{
        moveHeight = self.password_bg.bottom - ( ScreenHeight - rect.size.height  - 44 ) ;
    }
        [UIView animateWithDuration:0.5 animations:^{
            self.bodyView.top = self.originalHeight ;
            self.bodyView.top = self.bodyView.top - moveHeight ;
    }];
}
- (void)keyboardWillHide:(NSNotification*)hideNote
{
    [UIView animateWithDuration:0.5 animations:^{
        self.bodyView.top = self.originalHeight ;
    }];
}
#pragma mark-----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
#pragma mark-----customAction
- (IBAction)loginAction:(id)sender {
    NSLog(@"loginAction");
}

- (IBAction)RegisterAction:(id)sender {
    NSLog(@"RegisterAction");
    RegisterViewController *registerViewCtl = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewCtl animated:YES];
}
@end
