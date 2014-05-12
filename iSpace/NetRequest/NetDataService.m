//
//  WWXSGetNetData.m
//  MJTNet
//
//  Created by 莫景涛 on 14-4-30.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "NetDataService.h"
#import "SBJsonWriter.h"
#import "NetRequest.h"

@implementation NetDataService
+(NSMutableDictionary*)needCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue
{
    //请求头
    NSMutableArray *headKey = [NSMutableArray arrayWithObjects:@"flag" , @"protocol" , @"sequence" , @"timestamp" , @"command" , @"user_id" ,nil] ;
    NSMutableArray *headValue = [NSMutableArray arrayWithObjects:@"0" , @"1" , @"0" , @"0", command , userId , nil] ;
//    for (int i = 0; i < headValue.count; i++) {
//        NSLog(@"%@=====%@" , headKey[i] , headValue[i]);
//    }
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headKey];
    
    //请求体、把请求体的headKey和headValue装进字典里
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyArrValue forKeys:bobyArrkey];
    
    //把请求体与 请求头装进字典里
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    return Dict ;
}
+(void)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod AndisWaitActivity:(BOOL)isWaitActivity AndWaitActivityTitle:(NSString*) waitTitle andViewCtl:(UIViewController*)viewCtl completeBlock:(completion)completionblock
{
    //把字典转化为json
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *jsonStr = [jsonWriter stringWithObject:dictparams];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NetRequest *request = [NetRequest requestWithURL:url];
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:60];
    request.block = ^(NSData *data){
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completionblock(result);
      
    };
    
    [request startAsynrc:YES AndWaitActivityTitle:waitTitle andViewCtl:viewCtl];
    
}
//上传
+(void)requestWithUrl:(NSString *)urlStrings postData:(NSData*)data httpMethod:(NSString *)httpMethods AndisWaitActivity:(BOOL)isWaitActivitys AndWaitActivityTitle:(NSString*) waitTitles andViewCtls:(UIViewController*)viewCtl completeBlock:(completion)completionblocks
{
    NSURL *url = [NSURL URLWithString:urlStrings];
    NetRequest *request = [NetRequest requestWithURL:url];
    [request setHTTPMethod:httpMethods];
    [request setHTTPBody:data];
    [request setTimeoutInterval:60];
    request.block = ^(NSData *data){
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completionblocks(result);
        
    };
    [request startAsynrc:YES AndWaitActivityTitle:waitTitles andViewCtl:viewCtl];
}

@end
