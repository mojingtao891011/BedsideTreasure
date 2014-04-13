//
//  RegisterViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "RegisterViewController.h"
#import "SetIspaceViewController.h"

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
    _userPassword.secureTextEntry = YES , _confirmPassword.secureTextEntry = YES ;
    self.originalHeight = self.registerScrollView.top ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
    [self.view addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
#pragma mark------是否同意使用条款
- (IBAction)checkActin:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
    _isAgree = button.selected ;
}
#pragma mark------提交注册信息
- (IBAction)registerAction:(id)sender {
    
    //点击注册改变背景颜色
    UIButton *button = (UIButton*)sender ;
    [button setBackgroundColor:buttonSelectedBackgundColor];
    
    //判断输入信息是否符合要求
    BOOL isRight = [self judgeUserEnter];
    if (isRight) {
        [self startNetwork];
    }else
    {
        UIAlertView *MessageAlertView = [[UIAlertView alloc]initWithTitle:@"友情提示：" message:_promptMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [MessageAlertView show];
    }
    
}
#pragma mark------开始网络请求
- (void)startNetwork
{
    //检查网络
    BOOL reachable = [[Reachability reachabilityForInternetConnection] isReachable];
    if (!reachable) {
        UIAlertView *alertViews = [[UIAlertView alloc] initWithTitle:@"该功能需要连接网络才能使用，请检查您的网络连接状态" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
        [alertViews show];
        return;
    }

    //请求头
    NSArray *headkey = @[@"command" , @"flag" , @"protocol" , @"sequence" , @"timestamp" , @"user_id"  ] ;
    NSArray *headValue = @[@"2048" , @"0" , @"1" , @"0" , @"0" , @"0" , ];
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headkey];
    
    //请求体
    NSArray *bobyKey = @[@"name" , @"password" , @"email" , @"phone_no"];
    NSArray *bobyValue = @[_userName.text , _userPassword.text , _email.text , _phoneNumber.text ] ;
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyValue forKeys:bobyKey];
    
    //把请求体与 请求头装进字典里
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    //请求网络
    //添加等待指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView ;
    hud.labelText = @"loading" ;
    
    [NetDataService requestWithUrl:URl dictParams:Dict httpMethod:@"POST" completeBlock:^(id result){
        NSLog(@"++++===%@" , result);
        NSDictionary *returnInfoDict = result[@"message_body"];
        NSString *returnInt = returnInfoDict[@"error"];
        int infoInt = [returnInt intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self isSuccessRegister:infoInt];
        });
    }];

}
#pragma mark------从网络获取到数据后返回到主界面
- (void)isSuccessRegister:(int)infoInt
{
    NSLog(@"infoInt = %d" , infoInt);
    _errorInt = infoInt ;
    //请求完成隐藏等待指示器
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    //根据返回的数据判断注册是否成功 0:注册成功 -1:注册失败,未知错误 -2:用户名已注册 -3:邮箱名已注册 -4:手机号已注册
    switch (infoInt) {
        case 0:
            _isSuccessLabel.text = @"注册成功" ;
            _errorMessage = @"恭喜您成为iSpace的用户" ;
            _label.alpha = 1.0  , _userNameLabel.alpha = 1.0 ;
            _userNameLabel.text = _userName.text ;
            [_userNameLabel sizeToFit] ;
            break;
        case -1:
            _label.alpha = 0.0  , _userNameLabel.alpha = 0.0 ;
            _isSuccessLabel.text = @"注册失败" ;
            _errorMessage = @"注册失败,未知错误" ;
            break;
        case -2:
            _label.alpha = 0.0  , _userNameLabel.alpha = 0.0 ;
            _isSuccessLabel.text = @"注册失败" ;
            _errorMessage = @"用户名已注册" ;
            break;
        case -3:
            _label.alpha = 0.0  , _userNameLabel.alpha = 0.0 ;
            _isSuccessLabel.text = @"注册失败" ;
            _errorMessage = @"邮箱名已注册" ;
            break;
        case -4:
            _label.alpha = 0.0  , _userNameLabel.alpha = 0.0 ;
            _isSuccessLabel.text = @"注册失败" ;
            _errorMessage = @"手机号已注册" ;
            break;
        default:
            break;
    }
   //提示用户是否注册成功的提示框
    self.alertView.height = ScreenHeight ;
    self.alertView.top = 0 ;
    self.alertView.alpha = 0.0 ;
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 0.9 ;
        _messageLabel.text = _errorMessage ;
        [self.view addSubview:self.alertView];
        }];
    
}
#pragma mark------判断用户输入的信息是否符合规范
//判断用户输入的信息是否符合规范
- (BOOL)judgeUserEnter
{
    //用户名不能为纯数字,不能带标点符号,编码后的总长度不能超过 32 个字节
    BOOL isName ;
    NSString * regexNumber = @"^[0-9]{1,32}$"; //都为数字
    NSPredicate *predAlphabet = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNumber];
    BOOL isNumber = [predAlphabet evaluateWithObject:_userName.text] ;
    if (isNumber) {
        isName = NO ;
    }
    else {
        NSString * regex = @"^[A-Za-z0-9]{1,32}$";//都有字母、数字
        NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isRegex = [predNumber evaluateWithObject:_userName.text] ;
        isName = isRegex ;
    }
    
    //判断两次输入密码是否相同并且长度小于32个字节
    BOOL isPassword =[_userPassword.text isEqualToString:_confirmPassword.text]&&_userPassword.text.length <= 32&&_userPassword.text.length >= 8;
    
    //判断输入的是否为正确邮箱而且长度小于256个字节
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    BOOL isEmail = [emailTest evaluateWithObject:_email.text];
    
    //如果条件都符合则向服务器提交注册信息
    if (isName && isPassword && isEmail&&_isAgree) {
        return [self isMobileNumber:_phoneNumber.text] ;
    }else{
        if (!isName) {
            _promptMessage = @"用户名不符合要求" ;
        
        }
        else if (!isPassword){
            _promptMessage = @"密码输入不符合要求" ;
        }
        else if (!isEmail){
            _promptMessage = @"邮箱输入不符合要求" ;
        }
        else if (!_isAgree){
            _promptMessage = @"您还未同意我们的使用条款" ;
        }
    }
    return NO ;
    
}
#pragma mark------正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        _promptMessage = @"手机号码地址格式错误" ;
        return NO;
    }
}
#pragma mark-----点击自定义弹出提示框的“确定”按钮时
- (IBAction)registerOkAction:(id)sender {
    if (_errorInt == 0) {
        SetIspaceViewController *setIspaceViewCtl = [[SetIspaceViewController alloc]init];
        [self.navigationController pushViewController:setIspaceViewCtl animated:YES];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 0.0 ;
    }];
    self.alertView.top = ScreenHeight ;
  }
@end
