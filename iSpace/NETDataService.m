//
//  SGDataService.m
//  ASIService
//
//  Created by Width on 14-2-28.
//  Copyright (c) 2014年 mojingtao. All rights reserved.
//

#import "NetDataService.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#import "SBJsonWriter.h"

@implementation NetDataService

+(NSMutableDictionary*)needCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue
{
    //请求头
    NSMutableArray *headKey = [NSMutableArray arrayWithObjects:@"flag" , @"protocol" , @"sequence" , @"timestamp" , @"command" , @"user_id" ,nil] ;
    NSMutableArray *headValue = [NSMutableArray arrayWithObjects:@"0" , @"1" , @"0" , @"0", command , userId , nil] ;
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headKey];
    
    //请求体、把请求体的headKey和headValue装进字典里
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyArrValue forKeys:bobyArrkey];
    
    //把请求体与 请求头装进字典里
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    return Dict ;
}
+(ASIHTTPRequest*)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod AndisWaitActivity:(BOOL)isWaitActivity AndWaitActivityTitle:(NSString*) waitTitle andViewCtl:(UIViewController*)viewCtl completeBlock:(requestFinishBlock)block
{
    //检查网络
    BOOL reachable = [[Reachability reachabilityForInternetConnection] isReachable];
    
    if (!reachable) {
        UIAlertView *alertViews = [[UIAlertView alloc] initWithTitle:@"该功能需要连接网络才能使用，请检查您的网络连接状态" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
        [alertViews show];
        return nil;
    }

    NSURL *url = [NSURL URLWithString:[urlString URLEncodedString]];
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:httpMethod];
    //比较看是post还是get请求
    NSComparisonResult comparRet = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparRet == NSOrderedSame) {
        //把字典转化为json
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        NSString *jsonStr = [jsonWriter stringWithObject:dictparams];
//        NSLog(@"dictParams = %@" , dictparams);
//       NSLog(@"json = %@" , jsonStr);
        //添加请求头还有请求体
        [request addRequestHeader:@"content-type" value:@"application/json"];
        [request appendPostData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding ]];
        
    }
    //请求完成的block
    [request setCompletionBlock:^{
        
        //请求完成隐藏等待指示器
        [MBProgressHUD hideHUDForView:viewCtl.view animated:YES];

        __weak NSString *getStr = [request responseString] ;
        //json解析（ios5以后NSJSONSerialization）
        id result = [NSJSONSerialization JSONObjectWithData:[getStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"request=====%@",request);
        if (block != nil) {
            block(result);
        }
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
       // block([error localizedDescription]);
    }];
    [request startAsynchronous];
    
    //是否要显示等待指示器
    if (isWaitActivity) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewCtl.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView ;
        hud.labelText = waitTitle;
    }
    return nil ;
}


@end
