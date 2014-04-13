//
//  RingViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "RingViewController.h"
#import "SBJsonWriter.h"

@interface RingViewController ()<NSURLConnectionDelegate>
{
    NSMutableData *datas ;
}
@end

@implementation RingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"铃声" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testPost];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)testPost
{
    // {"message_body":{"account":"fffhjbh","password":"bbryhvg"},"message_head":{"command":2049,"flag":0,"protocol":1,"sequence":0,"timestamp":0,"user_id":0}}
    //@"[\"lenght\":\"123\",\"command\":\"123456\"]" ;
    
//    NSString *postbody = @"{\"name\":\"hello1\",\"password\":\"123\",\"email\":\"245891752@qq.com\",\"phone_no\":\"12345678901\"}" ;
//   NSString *postHead = @"{\"command\":\"2048\",\"flag\":\"0\",\"protocol\":\"1\",\"sequence\":\"0\",\"timestamp\":\"0\",\"user_id\":\"0\"}" ;
//    NSString *post = [NSString stringWithFormat:@"{\"message_head\":%@ , \"message_body\":%@ }" , postHead , postbody];
    
    NSArray *headkey = @[@"command" , @"flag" , @"protocol" , @"sequence" , @"timestamp" , @"user_id"  ] ;
    NSArray *headValue = @[@"2048" , @"0" , @"1" , @"0" , @"0" , @"0" , ];
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headkey];
    NSArray *bobyKey = @[@"name" , @"password" , @"email" , @"phone_no" ];
    NSArray *bobyValue = @[@"helloworld" , @"123" , @"245891752@qq.com" , @"12345678901"] ;
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyValue forKeys:bobyKey];
    NSDictionary *Dict =@{@"message_head": headDic , @"message_body":bobyDic};
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *jsonStr = [jsonWriter stringWithObject:Dict];
    
    NSURL *url = [NSURL URLWithString:URl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (conn) {
        NSLog(@"ok");
    }else{
        NSLog(@"error");
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@" , [error description]);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%s" ,__func__);
    datas = [NSMutableData new];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [datas appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"------%@" , [[NSString alloc]initWithData:datas encoding:NSUTF8StringEncoding]);
    id jsonObj = [NSJSONSerialization JSONObjectWithData:datas
                                                 options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@" === %@" , jsonObj);
}
@end
