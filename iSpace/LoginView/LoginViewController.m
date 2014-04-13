//
//  LoginViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LookPassWordViewController.h"
#import "TabBarViewController.h"

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES ;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO ;
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
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
    if (Version < 7.0) {
        moveHeight = self.password_bg.bottom - ( ScreenHeight - rect.size.height  - 44 - 20) ;
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
- (IBAction)loginAction:(id)sender
{
    //点击注册改变背景颜色
    UIButton *landButton = (UIButton*)sender ;
    [landButton setBackgroundColor:buttonSelectedBackgundColor];
    
    //点击登录前判断用户名和密码是否为空
    if (_userName.text.length == 0 ) {
        _alertInfo.text = @"用户名不能为空" ;
        [self errorInfo];
        return ;
    }else if(_passWord.text.length == 0){
        _alertInfo.text = @"密码不能为空" ;
        [self errorInfo];
        return ;
    }
    
    //检查网络
    BOOL reachable = [[Reachability reachabilityForInternetConnection] isReachable];
    if (!reachable) {
        UIAlertView *alertViews = [[UIAlertView alloc] initWithTitle:@"该功能需要连接网络才能使用，请检查您的网络连接状态" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
        [alertViews show];
        return;
    }

    //请求头
    NSArray *headkey = @[@"command" , @"flag" , @"protocol" , @"sequence" , @"timestamp" , @"user_id"  ] ;
    NSArray *headValue = @[@"2049" , @"0" , @"1" , @"0" , @"0" , @"0" , ];
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headkey];
    //请求体
    NSArray *bobyKey = @[@"account" , @"password"];
    NSArray *bobyValue = @[_userName.text, _passWord.text ] ;
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyValue forKeys:bobyKey];
    //把请求体与 请求头装进字典里
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:Dict httpMethod:@"POST" completeBlock:^(id result){
        NSLog(@"111111 %@" , result);
         NSDictionary *returnInfo = result[@"message_body"];
        NSString *status = returnInfo[@"error"];
       _statusInt = [status intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self landAction];
        });
    }];
    //登录错误三次弹出找回密码框
    static int count = 0;
    if (count >= 3)
    {
        self.alertView.height = ScreenHeight ;
        self.alertView.top = 0 ;
        self.alertView.alpha = 0.0 ;
        [UIView animateWithDuration:0.5 animations:^{
            self.alertView.alpha = 0.9 ;
            [self.view addSubview:self.alertView];
        }];

    }
    count++ ;
}
- (void)landAction
{
//0:登录成功-1:登录失败,未知错误-2:用户已登录-3:用户不存在-4:密码错误 -5:用户冻结(多次输入错误密码时冻结账户)
    TabBarViewController *tabBarViewCtl = [[TabBarViewController  alloc]init];
    switch (_statusInt) {
        case 0:
            [self presentViewController:tabBarViewCtl animated:YES completion:nil];
            break;
        case -1:
            _alertInfo.text = @"登录失败,未知错误" ;
            break;
        case -2:
            _alertInfo.text = @"用户已登录" ;
            break;
        case -3:
            _alertInfo.text = @"用户不存在" ;
            break;
        case -4:
            _alertInfo.text = @"密码错误" ;
            break;
        case -5:
            _alertInfo.text = @"用户冻结(多次输入错误密码时冻结账户)" ;
            break;
        default:
            break;
    }
    [self errorInfo];

}
- (void)errorInfo
{
    //错误信息提示框
    self.promptView.layer.cornerRadius = 5.0 ;
    self.promptView.alpha = 0.0 ;
    self.promptView.frame = CGRectMake(20, 400, ScreenWidth-40, 60);
    [UIView animateWithDuration:0.5 animations:^{
        self.promptView.alpha = 1.0 ;
    }];
    [self.view addSubview:self.promptView];
    [self performSelector:@selector(hidesPromptView) withObject:nil afterDelay:2];
}
//hide错误信息提示框
- (void)hidesPromptView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.promptView.alpha = 0.0 ;
    }];

}
- (IBAction)RegisterAction:(id)sender {
    
    RegisterViewController *registerViewCtl = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewCtl animated:YES];
}

- (IBAction)forgetPassWord:(id)sender {
    UIButton *button = (UIButton*)sender ;
    [button setBackgroundColor:buttonSelectedBackgundColor];
    LookPassWordViewController *lookPassWordViewCtl = [[LookPassWordViewController alloc]init] ;
    [self.navigationController pushViewController:lookPassWordViewCtl animated:YES];
    self.alertView.top = ScreenHeight ;
}

- (IBAction)cancelLookPassWord:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 0.0 ;
    }];
    self.alertView.top = ScreenHeight ;
}
@end
