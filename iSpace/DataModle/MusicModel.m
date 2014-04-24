//
//  MusicModel.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           
                           @"musicName" :            @"name" ,
                           @"musicUrl" :             @"url" ,
                           @"musicId" :    @"id" ,
                           @"musicSize" : @"size" ,
                                                      
                           };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}

@end
