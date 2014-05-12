//
//  WWXSGetNetData.h
//  MJTNet
//
//  Created by 莫景涛 on 14-4-30.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion)(id);
@interface NetDataService : NSObject

+(NSMutableDictionary*)needCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue  ;

+(void)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod AndisWaitActivity:(BOOL)isWaitActivity AndWaitActivityTitle:(NSString*) waitTitle andViewCtl:(UIViewController*)viewCtl completeBlock:(completion)completionblock ;

+(void)requestWithUrl:(NSString *)urlStrings postData:(NSData*)data httpMethod:(NSString *)httpMethods AndisWaitActivity:(BOOL)isWaitActivitys AndWaitActivityTitle:(NSString*) waitTitles andViewCtls:(UIViewController*)viewCtl completeBlock:(completion)completionblocks;

@end
