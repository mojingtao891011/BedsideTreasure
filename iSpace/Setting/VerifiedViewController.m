//
//  VerifiedViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-5-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "VerifiedViewController.h"


@interface VerifiedViewController ()

@end

@implementation VerifiedViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitCaptcha:(UIButton *)sender {
    
    
    NSDictionary *accInfoDict = @{
                                  @"name": USERNAME,
                                  @"email":@"",
                                  @"phone_no":_phoneNumber,
                                  @"uid":USER_ID
                                  };
    NSDictionary *baseDict = @{
                               @"acc_info": accInfoDict,
                               @"sex" :@"-1" ,
                               @"city" :@"" ,
                               @"pic_url":@"",
                               @"pic_id" :@"-1"
                               };
    NSDictionary *birthdayDict = @{
                                   @"year": @"-1",
                                   @"month":@"-1",
                                   @"day":@"-1"
                                   };
    NSDictionary *infoDict = @{
                               @"base_info": baseDict ,
                               @"password":@"",
                               @"birthday" :birthdayDict,
                               };
    NSMutableDictionary *dict = [NetDataService needCommand:@"2057" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"info" , @"password" , @"req_id"] andNeedBobyArrValue:@[infoDict ,  _captcha.text , @"-1"]];
   
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        int  errorInt = [result[@"message_body"][@"error"] intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (errorInt == 0) {
                NSArray *infoArr = @[_phoneNumber , @"5"];
                [[NSNotificationCenter defaultCenter]postNotificationName:REFRESHTABLEVIEW object:infoArr];
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"绑定成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"绑定失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];

            }
        });
    }];

    
}
@end
