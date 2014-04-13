//
//  FriendsViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "FriendsViewController.h"
#import "SBJsonWriter.h"
#import "NetDataService.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"好友" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self test];
    
}
- (void)test
{
    NSArray *headkey = @[@"command" , @"flag" , @"protocol" , @"sequence" , @"timestamp" , @"user_id"  ] ;
    NSArray *headValue = @[@"2048" , @"0" , @"1" , @"0" , @"0" , @"0" , ];
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headkey];
    
    NSArray *bobyKey = @[@"name" , @"password" , @"email" , @"phone_no" ];
    NSArray *bobyValue = @[@"1111" , @"123" , @"245891752@qq.com" , @"12345678901"] ;
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyValue forKeys:bobyKey];
    
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    
    [NetDataService requestWithUrl:URl dictParams:Dict httpMethod:@"POST" completeBlock:^(id result){
        NSLog(@"++++%@" , result);
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)landAction:(id)sender {
    NSArray *headkey = @[@"command" , @"flag" , @"protocol" , @"sequence" , @"timestamp" , @"user_id"  ] ;
    NSArray *headValue = @[@"2049" , @"0" , @"1" , @"0" , @"0" , @"0" , ];
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headkey];
    
    NSArray *bobyKey = @[@"account" , @"password"];
    NSArray *bobyValue = @[@"1111" , @"123" ] ;
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyValue forKeys:bobyKey];
    
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;

    
    
    [NetDataService requestWithUrl:URl dictParams:Dict httpMethod:@"POST" completeBlock:^(id result){
        NSLog(@"++++===%@" , result);
    }];

}
@end
