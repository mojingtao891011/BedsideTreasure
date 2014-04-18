//
//  EmailLookPassWordViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "LookStyleViewController.h"
#import "ResetPassWordViewController.h"

@interface LookStyleViewController ()

@end

@implementation LookStyleViewController

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
    
    [self searchStyle:_searchStyle];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----判断是那种找回方式
- (void)searchStyle:(NSString*)index
{
    if ([index isEqualToString:@"0"]) {
        _searchStyleName.text = @"手机号码" ;
        _showLabel.text = _userInfoModel.phone_no ;
    }else{
        _searchStyleName.text = @"邮箱地址" ;
        _showLabel.text = _userInfoModel.email ;
    }
}
#pragma mark -----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
#pragma mark-----点击确定按钮
- (IBAction)enterAction:(id)sender {
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2059" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"account" , @"request_id" , @"verify_code"] andNeedBobyArrValue:@[ _userInfoModel.name , @"0" , _captchaTextfield.text]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"" andViewCtl:self completeBlock:^(id result){
        NSDictionary *returnDict = result[@"message_body"] ;
        NSString *returnError = returnDict[@"error"] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self returnMainPage:returnError];
        });

    }];
    
}
#pragma mark-----返回到主界面刷UI(点击确定按钮)
- (void)returnMainPage:(NSString*)errorInfo
{
    
    /*
    ￼0:验证码验证成功,界面需要跳转到重设密码那边 -200:账户未注册
    -210:验证码错误(请求 ID 和对应的验证码不对应) -211:验证码超时(验
    */
    ResetPassWordViewController *resetPasswordView = [[ResetPassWordViewController alloc]init];
#warning testTO_ResetPassWordViewController
    resetPasswordView.captcha = _captchaTextfield.text ;
    [self.navigationController pushViewController:resetPasswordView animated:YES];
    
    NSString *infoPrompt ;
    
    int errorInt  = errorInfo.intValue;
    switch (errorInt) {
        case 0:
            resetPasswordView.captcha = _captchaTextfield.text ;
            [self.navigationController pushViewController:resetPasswordView animated:YES];
            return ;
            break;
        case -200:
            infoPrompt = @"账户未注册" ;
            break;
        case -210:
            infoPrompt = @"验证码错误" ;
            break;
        case -211:
            infoPrompt = @"验证码超时" ;
            break;
        default:
            break;
    }
    [self showAlertView:infoPrompt];
}
#pragma mark----显示提示框
- (void)showAlertView:(NSString*)infoPrompt
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:infoPrompt delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}
#pragma mark-----点击发送验证码按钮
- (IBAction)sendCaptchaAction:(id)sender {
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2058" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"request_id" , @"goal" ] andNeedBobyArrValue:@[ @"0" , _searchStyle ]] ;
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"Sending" andViewCtl:self completeBlock:^(id result){
        NSDictionary *returnInfo = result[@"message_body"];
        NSString *returnError = returnInfo[@"error"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self returmMain:returnError];
        });
    }];
  
}
#pragma mark-----返回到主界面刷UI(点击发送验证码按钮)
- (void)returmMain:(NSString*)infoPrompt
{
    //0:验证码已发送成功 -1;验证码获取失败,未知错误
    NSString *infoContent ;
    int infoInt = infoPrompt.intValue ;
    switch (infoInt) {
        case 0:
            infoContent = @"验证码已发送成功" ;
            break;
        case -1:
             infoContent = @"验证码获取失败,未知错误" ;
            break;
            
        default:
            break;
    }
    [self showAlertView:infoContent];
}
@end
