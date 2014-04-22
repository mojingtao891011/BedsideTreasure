//
//  DevicesInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-15.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//
#import "WXBaseModel.h"
#import "AlarmInfoModel.h"

@interface DevicesInfoModel : WXBaseModel
@property (nonatomic , copy)NSString                    * dev_idx;
@property (nonatomic , copy)NSString                    *dev_online;
@property (nonatomic , copy)NSString                    *dev_sn;
@property (nonatomic , copy)NSString                    *dev_city;
@property (nonatomic , copy)NSString                    *dev_name;
@property (nonatomic , retain)AlarmInfoModel    *alermInfo;
@property(nonatomic , retain)NSMutableArray      *alermInfoArr;
@end
