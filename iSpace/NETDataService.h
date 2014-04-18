//
//  SGDataService.h
//  ASIService
//
//  Created by Width on 14-2-28.
//  Copyright (c) 2014年 mojingtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef void( ^requestFinishBlock )( id result );

@interface NetDataService : NSObject

+(NSMutableDictionary*)needCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue  ;

+(ASIHTTPRequest*)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod AndisWaitActivity:(BOOL)isWaitActivity AndWaitActivityTitle:(NSString*) waitTitle andViewCtl:(UIViewController*)viewCtl completeBlock:(requestFinishBlock)block ;

@end
