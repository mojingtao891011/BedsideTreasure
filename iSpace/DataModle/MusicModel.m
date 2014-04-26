//
//  MusicModel.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

static  MusicModel  *shareManager ;
+(MusicModel*)sharedManager
{
    static dispatch_once_t once ;
    dispatch_once (&once , ^{
        shareManager = [[self alloc]init ];
    });
    return shareManager ;
}
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
