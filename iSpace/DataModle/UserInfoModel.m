//
//  UserInfoModel.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           
                           @"name" : @"name" ,
                           @"email" : @"email" ,
                           @"phone_no" : @"phone_no" ,
                                                     
                           };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}
@end
