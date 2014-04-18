//
//  ResetPassWordViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ResetPassWordViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "TabBarViewController.h"

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
#pragma mark-------提交重设的密码
- (IBAction)resetAction:(id)sender {
    
    //提交前判断是否符合要求
    if (_password.text.length >= 8 && [_password.text isEqualToString:_confirmPassword.text]) {
        //对密码进行MD5加密
        NSString *MD5Password = [self md5:_password.text] ;
        
        //请求体
        NSMutableDictionary *dict = [NetDataService needCommand:@"2060" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"request_id" ,@"verify_code" , @"password"] andNeedBobyArrValue:@[@"0" , _captcha , MD5Password] ];
        //请求网络
        [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"Reseting" andViewCtl:self completeBlock:^(id result){
            NSDictionary *returnDict = result[@"message_body"];
            NSString *returnInfo = returnDict[@"error"];
            dispatch_async(dispatch_get_main_queue(), ^{
                int errorInt = returnInfo.intValue ;
                NSString *infoStr ;
                if (errorInt == 0) {
                    infoStr = @"密码重设成功" ;
                }else
                {
                    infoStr = @"密码重设失败" ;
                }
                UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:infoStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show] ;
            });

        }];
    }else{
        UIAlertView *alertViews =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入密码不符合要求" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertViews show] ;

        return ;
    }
}
#pragma mark----对密码进行MD5加密
- (NSString *)md5:(NSString *)str
{
    //转换成utf-8
    const char *cStr = [str UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char result[16];
    //官方封装好的加密方法
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    // 把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
    NSMutableString *Mstr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        //x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
        [Mstr appendFormat:@"%02X",result[i]];
        
    }
    
    return Mstr;
    
}
#pragma mark-----UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
       if ([alertView.message isEqualToString:@"密码重设成功"]) {
        TabBarViewController *tabBarViewCtl = [[TabBarViewController  alloc]init];
        [self presentViewController:tabBarViewCtl animated:YES completion:nil];
    }
    

}
@end
