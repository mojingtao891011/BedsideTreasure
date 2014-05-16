//
//  WeatherInfo.m
//  iSpace
//
//  Created by bear on 14-5-16.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "WeatherInfo.h"

@implementation WeatherInfo
- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           @"datetime" : @"datetime" ,
                           @"error" : @"error" ,
                           @"tempreature" : @"tempreature" ,
                           @"title" : @"title" ,
                           @"weather" : @"weather" ,
                           @"wind" : @"wind"
                           };
   
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    //GTMBase64解密
    _datetime = dataDic[@"datetime"];
    _error = dataDic[@"error"];
    _tempreature = [[NSString alloc]initWithData:[GTMBase64 decodeString:dataDic[@"tempreature"]] encoding:NSUTF8StringEncoding];
    _title = [[NSString alloc]initWithData:[GTMBase64 decodeString:dataDic[@"title"]] encoding:NSUTF8StringEncoding];
    _weather = [[NSString alloc]initWithData:[GTMBase64 decodeString:dataDic[@"weather"]] encoding:NSUTF8StringEncoding];
    _wind = [[NSString alloc]initWithData:[GTMBase64 decodeString:dataDic[@"wind"]] encoding:NSUTF8StringEncoding];
   
}
@end
