//
//  MusicModel.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel

//static  MusicModel  *shareManager ;
//+(MusicModel*)sharedManager
//{
//    static dispatch_once_t once ;
//    dispatch_once (&once , ^{
//        shareManager = [[self alloc]init ];
//    });
//    return shareManager ;
//}
- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           
                           @"recordName" :            @"name" ,
                           @"recordUrl" :             @"url" ,
                           @"recordId" :    @"id" ,
                           @"recordSize" : @"size" ,
                                                      
                           };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}

@end
