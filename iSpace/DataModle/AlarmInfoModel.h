//
//  AlarmInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-21.
//  Copyright (c) 2014年 莫景涛. All rights reserved.

//单个 ALARM 信息结构

#import "WXBaseModel.h"

@interface AlarmInfoModel : WXBaseModel

@property(nonatomic , assign) int       index ;
@property(nonatomic , assign) int       state ;
@property(nonatomic , assign)int        frequency ;
@property(nonatomic , assign)int        sleep_times ;
@property(nonatomic , assign)int        sleep_gap ;
@property(nonatomic , assign)int        hour ;
@property(nonatomic , assign)int        minute ;
@property(nonatomic , assign)int        vol_level ;
@property(nonatomic , assign)int        vol_type ;
@property(nonatomic , copy)NSString        *fm_chnl ;
@property(nonatomic , copy)NSString        *file_path ;

@end
